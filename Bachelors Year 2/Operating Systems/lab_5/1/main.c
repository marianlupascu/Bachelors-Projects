#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>


int main(int argc, char* argv[]) {
	
	int PS = getpagesize();

	int i;
	printf("\n\n\nStarting parent = %d\n", getppid());

	char shm_name[] = "myshm";
	int shm_fd;
	shm_fd = shm_open(shm_name, O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
	if(shm_fd < 0) {
		perror(NULL);
		return errno;
	}


	size_t shm_size = PS * (argc-1);
	if(ftruncate(shm_fd, shm_size) == -1) {
		perror(NULL);
		shm_unlink(shm_name);
		return errno;
	}

	int* adrese[argc-1];

	for(i = 1; i < argc; i++) {
		int* v = mmap(0, PS, PROT_WRITE|PROT_READ, MAP_SHARED, shm_fd, PS * (i-1));
		adrese[i-1] = v;
		if(v == MAP_FAILED){
			perror(NULL);
			shm_unlink(shm_name);
			return errno;
		}
		
	}


	for(i = 1; i < argc; i++) {
		int j = 0;
		pid_t pid = fork();
		int argument = atoi(argv[i]);
		if(argument == 0) {
			printf("Oh dear, something went wrong! The numbers must be != 0\n");
			perror("Number == 0");
			return errno;
		}
		if( pid < 0 )
			return errno;
		else 
			if( pid == 0 ) {
				while(argument != 1) {
					adrese[i-1][j] = argument;
					if(argument % 2)
						argument = argument * 3 + 1;
					else
						argument /= 2;
					j++;
				}
				adrese[i-1][j] = 1;
				printf("Done Parent %d Me %d Adresa de Mem %p\n", getppid(), getpid(), adrese[i-1]);
				return 0;
			}
			else;
 	}

	for(i = 1; i < argc; i++){
		wait(NULL);
	}

	for(i = 1; i < argc; i++) {
		int j = 0;
		printf("%d : ", atoi(argv[i]));
		while(adrese[i-1][j]!=1) {
			printf("%d ", adrese[i-1][j]);
			j++;
		}
		printf("%d ", adrese[i-1][j]);
		if(munmap(adrese[i-1], PS) == -1) {
			perror(NULL);
			return errno;
		}
		printf("\n");
	}

	if(shm_unlink(shm_name) == -1) {
		perror(NULL);
		return errno;
		}


	return 0;
}
