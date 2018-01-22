#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <time.h>
#include <stdbool.h>
#include <errno.h>

typedef struct processes Process;
typedef struct queue Queue;
typedef struct cpu CPU;
unsigned QuantumTime; // the number of milliseconds a process can burn

unsigned simulationProcess(Process *p, clock_t startClock, unsigned maximum_time);
bool timePassed(clock_t current, clock_t end);
bool isProcessCompleted(Process *p);
void push(Queue *q, Process *p);
void pop(Queue *q, CPU *processor, time_t *exec_time);
bool empty(const Queue *q);
void merge(Queue *q, unsigned left, unsigned middle, unsigned right);
void mergeSortQueue(Queue *q, unsigned left, unsigned right);
void getCurrentState(Queue *q);
void round_robin_algorithm(CPU *cpu, Queue *q, unsigned *tq);
void calculate_process_info(Process *p, int *exec_time);
void analysis(CPU *unit, Queue *queue_with_processes);
bool read(Queue *queue_with_processes, char *fileName);

double cpu_maximum_utilization(CPU *cpu);
int check_current_size(Queue *q);
int compute_burst_time(Process *p, unsigned *tq);
Process *process_pids(unsigned *pid, unsigned *arrival, unsigned *burst, unsigned *userType);

//------------------------------------------
/* Structures:
 * 	- Process
 * 	- Queue
 *  - CPU */
//------------------------------------------

typedef struct processes {
   unsigned pid;
   unsigned arrival_time;
   unsigned burst_time;
   unsigned user_type;
   unsigned waiting_time;
   unsigned completion_time;
   unsigned turnaround_time;
   unsigned context_switch_count;
} Process;

typedef struct queue {
    Process *arr[10];	// Pointer to the array as we don't know what array we're specifying
    int front;
    int rear;
    size_t original_size, current_size;
} Queue;

typedef struct cpu{
	unsigned total_waiting_time;
	unsigned total_completion_time;
	unsigned total_context_switches;
	time_t total_time_running, idle_time;
} CPU;

int main(int argc, char *argv[]) {

	// Initialize items in queue_with_processes to be null, and the variables in CPU to be 0.
    Queue queue_with_processes = {NULL};
    CPU processing_unit = {0, 0, 0, 0 ,0};

    // Read the argument, which is a file.
    if (read(&queue_with_processes, "pid.txt") ) {

        /*
            if (argc != 2) {
            printf("Please input a txt file when running \n");
            return 0;
        }
        */
        if(empty(&queue_with_processes)) {
            perror((const char*)("Initially, you have no processes in the queue\n"));
            return 0;
        }
        mergeSortQueue(&queue_with_processes, 0, check_current_size(&queue_with_processes)-1);

        printf("Your time quantum is: %d\n", QuantumTime);
        printf("Size is: %d\nProcesses loaded into ready queue:\n", check_current_size(&queue_with_processes));

        getCurrentState(&queue_with_processes);
        printf("\n");

        processing_unit.total_time_running = (int) clock() / CLOCKS_PER_SEC;
        round_robin_algorithm(&processing_unit, &queue_with_processes, &QuantumTime);
        printf("Done processing\n\n");

        analysis(&processing_unit, &queue_with_processes);
    }
    else {
        printf("Read error...\n");
        return 0;
    }
}

//-------------------------
// Methods
//-------------------------

// Prints out the completion time, turnaround time, and waiting time for the process.
void calculate_process_info(Process *p, int *exec_time) {

	// Calculate Turnaround time & Waiting time
	p->turnaround_time = *exec_time - p->arrival_time;
	//printf("Exec time: %d and Arrival Time %d\n", *exec_time, p->arrival_time);
	p->waiting_time = p->completion_time - p->turnaround_time ;

	printf("Process Completion Time: %dms\nProcess Waiting Time: %dms\nProcess Turnaround time: %dms\n"
	"Removing from queue\n\n", p->completion_time, p->waiting_time, p->turnaround_time);
}

double cpu_maximum_utilization(CPU *unit) {
	printf("Unit idle time:%.2fs\n", (double) unit->idle_time);
	return ((double) (unit->total_time_running - unit->idle_time) / (double) (unit->total_time_running)) * 100;
}

// This function returns amount of items currently in the ready queue
// returns queue size
int check_current_size(Queue *q) {
    return q->current_size;
}

// This functions adds incoming processes or already processed process into queue
void push(Queue *q, Process *process) {
	size_t size = sizeof(q->arr)/sizeof(q->arr[0]);
	unsigned currentSize = check_current_size(q);

	if (q->arr[currentSize] == NULL && currentSize < size) {
	   q->arr[currentSize] = process;
	   q->current_size++;
	}
	q->original_size = size;
}

// This function either:
// Shift processes in array by 1 and move front process to the end if process is not null OR
// Delete the process otherwise
// Problems: Does not make it null
void pop(Queue *q, CPU *processor, time_t *start_exec) {
    Process *tempProcess = q->arr[0];
    time_t start, end;

    q->front = 0;
    q->rear = q->current_size - 1;

    start = clock();

    // Check if the first process in the queue is not considered NULL
    // Move front process to the end
    if (tempProcess != NULL) {
        size_t i;
        for (i = 0; i < q->current_size - 1; ++i) {
            q->arr[i] = q->arr[i + 1];
        }
        q->arr[q->current_size - 1] = tempProcess;
    }
    // Since it's null, pop it permanently
    else {
        size_t i;
        for (i = 0; i < q->current_size - 1; ++i) {
            q->arr[i] = q->arr[i + 1];
        }
        --q->current_size;
        printf("Process has been removed from queue\n");
    }

    // Get end clock of when context switch ends...
    end = clock();

    // Then assign the difference divided by the clocks per second to the idle time
    processor->idle_time += (float)((end - *start_exec) / CLOCKS_PER_SEC);
    printf("Idle time of process is: %d\n", processor->idle_time);
}

// After the program runs for specified time quantum, check the current state of all processes
void getCurrentState(Queue *q) {
    size_t i;
	for (i = 0; i < q->current_size; i++) {
		printf("Process id#: %3d | Arrival Time: %3d | Burst Time %5d | User Type: %15s\n", q->arr[i]->pid,
		q->arr[i]->arrival_time, q->arr[i]->burst_time,
		((q->arr[i]->user_type == 0)?("User"):((q->arr[i]->user_type == 1)?("Intermediate"):("Administrator"))));
	}
}

//Function that returns true if the queue is non-void and false if is void
bool empty(const Queue *q) {

    if(q->current_size == 0)
        return true;
    return false;
}

// Merges two subarrays of q->arr[].
// First subarray is q->arr[left..middle]
// Second subarray is q->arr[middle+1..right]
void merge(Queue *q, unsigned left, unsigned middle, unsigned right)
{
    unsigned i, j, k;
    unsigned n1 = middle - left + 1;
    unsigned n2 =  right - middle;

    // create temp arrays
    Process **L = (Process**)calloc(n1, sizeof(Process*));
    Process **R = (Process**)calloc(n2, sizeof(Process*));

    // Copy data to temp arrays L[] and R[]
    for (i = 0; i < n1; i++) {
        L[i] = q->arr[left + i];
    }
    for (j = 0; j < n2; j++)
        R[j] = q->arr[middle + 1 + j];

    // Merge the temp arrays back into arr[l..r]
    i = 0; // Initial index of first subarray
    j = 0; // Initial index of second subarray
    k = left; // Initial index of merged subarray
    while (i < n1 && j < n2) {
        if (L[i]->arrival_time <= R[j]->arrival_time) {
            q->arr[k] = L[i];
            i++;
        } else {
            q->arr[k] = R[j];
            j++;
        }
        k++;
    }

    // Copy the remaining elements of L[], if there are any
    while (i < n1) {
        q->arr[k] = L[i];
        i++;
        k++;
    }

    // Copy the remaining elements of R[], if there are any
    while (j < n2) {
        q->arr[k] = R[j];
        j++;
        k++;
    }
    free(L);
    free(R);
}

// Sorts the queue based on initial processes
// left is for left index and right is right index of the
// sub-array of arr to be sorted
void mergeSortQueue(Queue *q, unsigned left, unsigned right)
{
    if (left < right)
    {
        // Same as (l+r)/2, but avoids overflow for
        unsigned middle = left + (right - left) / 2;
        // Sort first and second halves
        mergeSortQueue(q, left, middle);
        mergeSortQueue(q, middle + 1, right);

        merge(q, left, middle, right);

//        printf("l = %d, m = %d, r = %d\n", left, middle, right);
//        int i;
//        for(i = 0; i < 6; i++) {
//            printf("%d ", q->arr[i]->pid);
//            printf("%d ", q->arr[i]->arrival_time);
//            printf("%d\n", q->arr[i]->burst_time);
//        }
//        printf("\n");
    }
}

// Methods needed for starting Round Robin CPU Scheduling
// Process the processes in the ready queue with specified time quantum, etc
// returns pointer to process
// works like an constructor
Process *process_pids(unsigned *p_id, unsigned *arrival, unsigned *burst,  unsigned *userType) {
    Process *p;
    p = malloc(sizeof(Process));
    p->pid = *p_id;
    p->arrival_time = *arrival;
    p->burst_time = *burst;
    p->user_type = *userType;
    p->turnaround_time = 0;
    p->completion_time = 0;
    p->waiting_time = 0;
    return p;
}

// Read file and check the input from this.
// that int is then passed to the process in the queue array.
bool read(Queue *queue_with_processes, char *fileName) {

    bool pidFound = false, arrivalTimeFound = false, burstTimeFound = false, userTypeFound = false;
    unsigned int process_id = 0, arrival_time = 0, burst_time = 0, user_type = 0;
    unsigned int index = 0;

    FILE *file = fopen(fileName,"r+"); // Pointer to file to be read and open the txt file

	// Check if file exists, if exists I parsing it if not I do anything
	if (file) {

	    bool isTimeToExit = false;
	    char c;
	    while((c = getc(file)) != EOF && !isTimeToExit) {
            if(c == '\n') {
                isTimeToExit = true;
            }
	    }
	    if(fseek(file, 1, SEEK_CUR)) {
            perror((const char*)("Error when calling the 'fseek' function\n"));
            perror((const char*)(errno));
            return false;
	    }

	    if(fscanf(file, "%d", &QuantumTime) <= 0) {
            perror((const char*)("Error when calling the 'fscanf' function when read quantum time\n"));
            perror((const char*)(errno));
            return false;
	    }

		while (!feof(file)) { //continue reading until end of file
            //read pid
            if(fscanf(file, "%d", &process_id) > 0) {
                pidFound = true;
                //printf("%d ", process_id);
            } else {
                pidFound = false;
                perror((const char*)("Error when calling the 'fscanf' function when read process pid\n"));
                perror((const char*)(errno));
                return false;
            }
            //read arrivalTime
            if(fscanf(file, "%d", &arrival_time) > 0) {
                arrivalTimeFound = true;
                //printf("%d ", arrival_time);
            } else {
                arrivalTimeFound = false;
                perror((const char*)("Error when calling the 'fscanf' function when read arrival time\n"));
                perror((const char*)(errno));
                return false;
            }
            //read burstTime
            if(fscanf(file, "%d", &burst_time) > 0) {
                burstTimeFound = true;
                //printf("%d\n", burst_time);
            } else {
                burstTimeFound = false;
                perror((const char*)("Error when calling the 'fscanf' function when read burst time\n"));
                perror((const char*)(errno));
                return false;
            }

            //read userType
            if(fscanf(file, "%d\n", &user_type) > 0) {
                userTypeFound = true;
                //printf("%d\n", burst_time);
            } else {
                userTypeFound = false;
                perror((const char*)("Error when calling the 'fscanf' function when read user type\n"));
                perror((const char*)(errno));
                return false;
            }

			// Begin enqueueing the processes
			if (pidFound && burstTimeFound && arrivalTimeFound && userTypeFound) {
				push(queue_with_processes, process_pids(&process_id, &arrival_time, &burst_time, &user_type));
				pidFound = false;
                arrivalTimeFound = false;
                burstTimeFound = false;
                userTypeFound = false;
				index++;
			}
		}
		fclose(file);
	}
	else {
        perror((const char*)("Error opening file\n"));
        perror((const char*)(errno));
        return errno;
	}
	return true;
}

// Start Round Robin Scheduling Algorithm
void round_robin_algorithm(CPU *processor, Queue *queue_with_processes, unsigned *QuantumTime) {
    Process *newProcess = queue_with_processes->arr[queue_with_processes->front];
    time_t context_switch_start;
    while (newProcess != NULL) {

        if(newProcess->burst_time <= 0)
            continue;

        printf("Processing...\n");

        // Run process on CPU
        newProcess->burst_time = compute_burst_time(newProcess, QuantumTime);

        // Get time at which process finishes running on CPU
        time_t end_execution = clock() / CLOCKS_PER_SEC;

        printf("\n");

         // Get time for how long CPU is idle
        context_switch_start = clock();
        getCurrentState(queue_with_processes);
        printf("\n");
        printf("Current time in seconds: %.2fs\n", (double) (clock() - processor->total_time_running) / CLOCKS_PER_SEC);
        int burst_now;

        // Check if the burst time is zero
        if (newProcess->burst_time == 0) {

            // Fill in processes' turnaround time, completion time, etc.
            int execution_time = end_execution - (int) processor->total_time_running;
            calculate_process_info(newProcess, &execution_time);

            // If this process had some type of context switch event, add number of context switches
            // to total amount that occured.
            if (newProcess->context_switch_count != 0)
                processor->total_context_switches += newProcess->context_switch_count;

            // Add process' waiting time to total waiting time
            processor->total_waiting_time += newProcess->waiting_time;
            printf("Current total waiting time: %d\n", processor->total_waiting_time);

            // Make that item null now
            burst_now = queue_with_processes->arr[queue_with_processes->front]->user_type;
            queue_with_processes->arr[queue_with_processes->front] = NULL;
        }else {
            printf("Context switch...\n");
            ++newProcess->context_switch_count;
        }
        pop(queue_with_processes, processor, &context_switch_start);
        printf("Process ran for time quantum of: %d\nThe time quantum for this process was: %d\n"
               "Original size of the queue was: %d\n"
               "Current size of the queue is: %d\nAfter pop, state of processes looks as follows.\n",
                *QuantumTime, *QuantumTime * (burst_now + 1), queue_with_processes->original_size,
               check_current_size(queue_with_processes));
        getCurrentState(queue_with_processes);

        // Set the process equal to whatever is in front now
        newProcess = queue_with_processes->arr[queue_with_processes->front];
        printf("\n");
    }
}

unsigned minimum (unsigned a, unsigned b) {

    return ((a < b) ? (a) : (b));
}

//  This function returns burst time after computing difference between process' burst time and the
//  time quantum itself
//  if the process belongs to an user then it burns 1*quantum_time
//  if the process belongs to an intermediate then it burns 2*quantum_time
//  if the process belongs to an admin then it burns 3*quantum_time
int compute_burst_time(Process *p, unsigned *QuantumTime) {

    clock_t currentClock = clock();

    unsigned timeToBurn = *QuantumTime * (p->user_type + 1);
    unsigned burnedTime = simulationProcess(p, currentClock, timeToBurn);

    p->burst_time -= burnedTime;
    p->completion_time += burnedTime;
    printf("Running on CPU... Burst Time Decremented...\n");
    printf("Burned time in this process %dms (process id is %d)\n", burnedTime, p->pid);

	return p->burst_time;
}

unsigned simulationProcess(Process *p, clock_t startClock, unsigned maximum_time) {

    clock_t endClock = startClock + minimum(p->burst_time, maximum_time) * (CLOCKS_PER_SEC/1000);
    clock_t currentClock = startClock;

    while(!(isProcessCompleted(p) || timePassed(currentClock, endClock))) {
        //
        //do something (process p turn)
        //
        currentClock = clock();
    }
    return minimum(p->burst_time, maximum_time);
}

// A function that tests whether a trial has passed
// is a query
bool timePassed(clock_t current, clock_t end) {

    if(current >= end)
        return true;
    else return false;
}

bool isProcessCompleted(Process *p) {

    if(p->burst_time == 0)
        return true;
    return false;
}

// Return CPU Utilization, average waiting time, throughput, and number of occurances of context switching
void analysis(CPU *unit, Queue *queue_with_processes) {
	// Get end duration of the clock and subtract the end from the beginning to get the total run time
	time_t end = clock() / CLOCKS_PER_SEC;
	unit->total_time_running = end - unit->total_time_running;
	double average_waiting_time = unit->total_waiting_time / queue_with_processes->original_size;

	printf("This took %.2lfms\n", (double)unit->total_time_running);
	printf("CPU Utilization: %.2f%\n", cpu_maximum_utilization(unit));
	printf("Average Waiting Time: %.2fms\n", average_waiting_time);
	printf("Total throughput: %.2f\n", queue_with_processes->original_size / (double) (unit->total_time_running));
	printf("Total amount of context switches: %d\n", unit->total_context_switches);
}
