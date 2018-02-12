#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
	
	char shm_name[] = "myshm";
	int shm_fd;
	shm_fd = shm_open(shm_name, O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
	if(shm_fd < 0) {
		perror(NULL);
		return errno;
	}

	size_t shm_size = getpagesize() * (argc-1);
	if(ftruncate(shm_fd, shm_size) == -1) {
		perror(NULL);
		shm_unlink(shm_name);
		return errno;
	}
	
	int** adres = calloc((argc - 1), sizeof(void*));
	int i;
	
	for(i = 1; i < argc; i++) {
		void* v = mmap(0, getpagesize(), PROT_WRITE|PROT_READ, MAP_SHARED, shm_fd, getpagesize()*(i-1));
		adres[i] = v;
		if(v == MAP_FAILED){
			perror(NULL);
			shm_unlink(shm_name);
			return errno;
		}
		
	}


	for(i = 0; i < argc - 1; i++) {
		int aux = atoi(argv[i+1]);
		pid_t pid = fork();
		if(pid < 0)
			return errno;
		if(pid == 0) {
			printf("Child pid = %d", getpid());
			int* adr = (int*)adres[i];
			int j = 0;
			adr[i] = aux;
			while(aux != 1) {
				if(aux%2)
					aux = aux * 3 + 1;
				else
					aux = aux / 2;
				adr[++j] = aux;
			}
			exit(0);
		}
		else {
			
			printf("Child pid = %d", getppid());
		}
		
	}

	printf("Child pid = %d", getppid());
	

	for(i = 1; i < argc; i++){
		wait(NULL);
		printf("Done Parent %d\n", getppid());
}
	for(i = 1; i < argc; i++) {
		int* adress = (int*) adres[i];
		int j = 0;
		while(adress[j++]!=1)
			printf("%d", adress[j]);
		munmap(adres[i], getpagesize());
		printf("\n");
	}

	munmap(adres[1], shm_size);
	shm_unlink(shm_name);
	
	return 0;
}
