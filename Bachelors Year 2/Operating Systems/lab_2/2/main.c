#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#define DIMMAX 1000
#define BUFF_SIZE 100

int min(int a, int b) {
	return ((a < b) ? a : b);
}

int copy_file(char path_to_read_file[], char path_to_write_file[])
{	

	int fd_for_read, fd_for_write;

	if ((fd_for_write = open(path_to_write_file, O_WRONLY)) == -1) {
		printf("Oh dear, something went wrong with write()! %s\n%s\n",path_to_write_file, strerror(errno));
		if((fd_for_write = open(path_to_write_file, O_CREAT | O_WRONLY)) == -1) {
			printf("Oh dear, something went wrong with file creation! %s\n%s\n",path_to_write_file, strerror(errno));
			perror("Creat file won't work");
			return errno;
		}
		else
			printf("I create a new file with same name for you :)\n");
	}

	if ((fd_for_read = open(path_to_read_file, O_RDONLY)) == -1) {
		printf("Oh dear, something went wrong with read()! %s\n%s\n",path_to_read_file, strerror(errno));
		perror("Problem with read()");
		return errno;
	}
	
	struct stat sb;
	if(stat(path_to_read_file, &sb)) {
		perror(path_to_read_file);
		return errno;
	}
	
	int dim = (int)sb.st_size;
	int index = (int)sb.st_size;
	int count = 0;
	int rest;
	int nread = 0, nwrite = 0;

	char buffer[BUFF_SIZE * sizeof(char) + 1];
	for(; index > 0; count += min(BUFF_SIZE * sizeof(char), index)) {
		rest = min(BUFF_SIZE * sizeof(char), index); //rest = cat citesc la o iteratie
		nread = read(fd_for_read, buffer, rest);
		if(nread < 0){
			perror("read buf");
			return errno;
		}
		nwrite = write(fd_for_write, buffer, rest);
		if(nwrite < 0){
			perror("write buf");
			return errno;
		}
		index -= rest;
	}

	if(count != dim) 
		return -1;
	

	close(fd_for_write);
	close(fd_for_read);

	return 0;
}

int main(int argc, char *argv[]) {

	char name_stream_for_read[DIMMAX];
	char name_stream_for_write[DIMMAX];

	strcpy(name_stream_for_read, argv[1]);
	strcpy(name_stream_for_write, argv[2]);

    	copy_file(name_stream_for_read, name_stream_for_write);
	
	return 0;
}
