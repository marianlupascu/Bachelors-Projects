#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/wait.h>


int main() {

	printf("My pid = %d\n", getppid());
	pid_t pid = fork();
	if( pid < 0 )
		return errno;
	else 
		if( pid == 0 ) {
			printf("Child pid = %d\n", getpid());
			char *argv[] = {"ls", NULL};
			execve ( "/bin/ls", argv, NULL );
			perror( NULL );
			printf("Child %d finished\n", getpid());
		}
		else {
			wait(NULL);
			printf("Parent pid = %d\n", getppid());
		}

	return 0;
}
