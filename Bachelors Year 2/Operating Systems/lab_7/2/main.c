#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <pthread.h>
#include <semaphore.h> 

sem_t sem;
pthread_mutex_t mtx;

int PTHREAD;
int nr_thr;

void barrier_point() {

	//pthread_mutex_lock(&mtx);

		PTHREAD ++;

		if(PTHREAD == nr_thr)
			if( sem_post (&sem ) ) {
				perror (NULL);
				return errno;
			}

	//pthread_mutex_unlock(&mtx);

		if( sem_wait (&sem ) ) {
			perror (NULL);
			return errno;
		}

		if( sem_post (&sem ) ) {
			perror (NULL);
			return errno;
		}

}

void* tfun( void *v ) {

	int *tid = (int*) v;
	printf ("%d reached the barrier\n" , *tid);
	barrier_point();
	printf ("%d passed the barrier\n" , *tid);
	free ( tid );
	return NULL;
}

int main(int argc, char *argv[]) {
	
	int i;
	nr_thr = atoi(argv[1]);
	pthread_t thr[nr_thr];

	if ( pthread_mutex_init(&mtx, NULL) ){
		perror (NULL);
		return errno;
	}

	if( sem_init (&sem , 0 , 0)) {
		perror (NULL);
		return errno;
	}

	for(i = 0; i < nr_thr; i++) {

		int* C = (int*)calloc(1, sizeof(int));	
		C[0] = i;	
		if(pthread_create(&thr[i], NULL, tfun, C)) {
			perror(NULL);
			return errno;
		}
	}

	for(i = 0; i < nr_thr; i++) {
	
		void *result;
		if(pthread_join(thr[i], &result)){
			perror(NULL);
			return errno;
		}

	}

	sem_destroy(&sem);
	pthread_mutex_destroy(&mtx);
	
	return 0;
}
