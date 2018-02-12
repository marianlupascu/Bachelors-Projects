#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>


int main(int argc, char* argv[]) {

	int i;
	printf("\n\n\nStarting parent = %d\n", getppid());

	for(i = 1; i < argc; i++) {
		pid_t pid = fork();
		int argument = atoi(argv[i]);
		if( pid < 0 )
			return errno;
		else 
			if( pid == 0 ) {
				printf("%d : ", argument);
				while(argument != 1) {
					printf("%d, ", argument);
					if(argument % 2)
						argument = argument * 3 + 1;
					else
						argument /= 2;
				}
				printf("1\n");
				printf("Done Parent %d Me %d\n", getppid(), getpid());
				return 0;
			}
			else;
 	}

	for(i = 1; i < argc; i++)
		wait(NULL);

	printf("Done Parent %d Me %d\n", getppid(), getpid());

	return 0;
}
