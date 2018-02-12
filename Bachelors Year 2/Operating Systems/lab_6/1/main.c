#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>

char *str;

void* inv(void* param) {
	
	char* aux = (char*)param;
	str = (char*)calloc(strlen(aux), sizeof(char));
	int i;
	for(i = 0; i < strlen(aux); i++) {
		str[strlen(aux)-i-1] = aux[i];
		
	}
	
	return str;	
}

int main(int argc, char *argv[]) {
	
	int i;

	pthread_t thr;

	if(pthread_create(&thr, NULL, inv, argv[1])) {
		perror(NULL);
		return errno;
	}

	void *result;

	if(pthread_join(thr, &result)){
		perror(NULL);
		return errno;
	}

	printf("%s\n", (char*)result);

	free(str);
	
	return 0;
}
