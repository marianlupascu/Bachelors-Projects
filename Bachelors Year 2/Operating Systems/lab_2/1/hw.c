#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

int main() {
	
	char string[]="Hello, World!\n";
	if(write(1, string, strlen(string))==-1) {
		printf("Oh dear, something went wrong with write()! %s\n", strerror(errno));
		perror ( "write buf");
		return errno;
	}	
		
	return 0;
}
