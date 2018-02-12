#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>

const int DIMMAX = 100;

int mA, pA, pB, nB;
int **A, **B, **C;

int citire() {
	
	FILE *fin;
	fin = fopen("date.in","r");
	int i, j;
	if (fin == NULL) {
		perror ("Error opening file");
		return errno;
	}
	else {
		fscanf (fin, "%d %d", &mA, &pA);

		A = (int **)calloc(mA+1, sizeof(int *)); 
		for (i = 1; i <= mA; ++i)
			A[i] = (int *)calloc(pA+1, sizeof(int));

		for (i = 1; i <=mA; i++)
			for (j = 1; j <=pA; j++)
				fscanf (fin, "%d ", &A[i][j]);
		

		fscanf (fin, "%d %d", &pB, &nB);

		if(pA!=pB) {
			perror("Dimensiuni incompatibile la matrici");
			return errno;
		}

		B = (int **)calloc(pB+1, sizeof(int *)); 
		for (i = 1; i <= pB; ++i)
			B[i] = (int *)calloc(nB+1, sizeof(int));

		for (i = 1; i <=pB; i++)
			for (j = 1; j <=nB; j++)
				fscanf (fin, "%d ", &B[i][j]);

		
		fclose (fin);
		if (fin == NULL) {
			perror ("Error opening file");
			return errno;
		}
	}
	
}

void* cell(void* param) {
	
	int* aux = (int*)param;
	int k, i, j;
	
	i = aux[0];
	j = aux[1];
	for(k = 1; k <= pA; k++) {
		C[i][j] += A[i][k] * B[k][j];
		
	}

	free(aux);
	
	return NULL;	
}

int main() {

	citire();
	
	int i, j;

	C = (int **)calloc(mA+1, sizeof(int *)); 
		for (i = 1; i <= mA; ++i)
			C[i] = (int *)calloc(nB+1, sizeof(int));
	
/*	for(i = 1; i <= mA; i++) {
		for(j = 1; j <= nB; j++){
			pthread_t thr;

			int P[] = {i, j};
			if(pthread_create(&thr, NULL, cell, P)) {
				perror(NULL);
				return errno;
			}

			void *result;

			if(pthread_join(thr, &result)){
				perror(NULL);
				return errno;
			}

			int*d = (int*)result;

			C[i][j] = d[0];
		}

	}
*/

	pthread_t thr[mA+1][nB+1];

	for(i = 1; i <= mA; i++) {
		for(j = 1; j <= nB; j++){
			
			int* P = calloc(2, sizeof(int));
			P[0] = i;
			P[1] = j;
			if(pthread_create(&thr[i][j], NULL, cell, P)) {
				perror(NULL);
				return errno;
			}
		}
	}

	
	for(i = 1; i <= mA; i++) {
		for(j = 1; j <= nB; j++){

			void *result;

			if(pthread_join(thr[i][j], &result)){
				perror(NULL);
				return errno;
			}
		}
	}


	for(i = 1; i <= mA; i++) {
		for(j = 1; j <= nB; j++){
			printf("%d  ", C[i][j]);
		}
		printf("\n");
	}

	for (i = 1; i <= mA; ++i)
		free(A[i]);
	free(A);

	for (i = 1; i <= pB; ++i)
		free(B[i]);
	free(B);
	
	for (i = 1; i <= mA; ++i)
		free(C[i]);
	free(C);

	
	return 0;
}
