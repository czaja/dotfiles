/*
Krzysztof Czajkowski - http://czajkowski.edu.pl
http://github.com/czaja/dotfiles/c/
Licence: public domain
*/

#include <stdio.h>
#include <stdlib.h>

int **generateMatrix(int sizeofmatrix){
	int **matrix;
	int i, j;
	matrix=(int**)malloc(sizeofmatrix*sizeof(*matrix));
	for (i=0; i<sizeofmatrix; ++i){
		matrix[i] = (int*)malloc(sizeofmatrix*sizeof(int));
	}
	for(i=0; i<sizeofmatrix; ++i){
		for(j=0; j<sizeofmatrix; ++j){
			matrix[i][j] = 0;
		}
	}
	return matrix;
}

void freeMatrix(int **matrix, int sizeofmatrix){
	int i;
	for (i=0; i<sizeofmatrix; ++i){
		free(matrix[i]);
	}
	free(matrix);
	return;
}

int fillMatrix(int **matrix, int sizeofmatrix){
	int i, j;
   for (i=0; i<sizeofmatrix; ++i){
	    for (j=0; j<sizeofmatrix; ++j){
   		scanf("%d", &matrix[i][j]);
	  	 }
   }
	printf("\n");
	return **matrix;
}

int showMatrix(int **matrix, int sizeofmatrix){
	int i, j;
	for (i=0; i<sizeofmatrix; ++i){
		for (j=0; j<sizeofmatrix; ++j){
			printf("%d ",matrix[i][j]);
		}
		printf("\n");
	}
	printf("\n");
	return;
}

int main(){
	int i=0, j=0, k=0, size=0;

	printf("Podaj rozmiar macierzy kwadratowych (jedna liczba): \n");
	scanf("%d", &size);
	printf("Wybrany rozmiar to: %d x %d \n", size, size);
	
	int **matrixOne = generateMatrix(size);
	int **matrixTwo = generateMatrix(size);
	
	printf("Wypełnij macierz pierwszą liczbami (wierszami): \n");
	fillMatrix(matrixOne, size);

	printf("Wypełnij macierz drugą liczbami (wierszami): \n");
	fillMatrix(matrixTwo, size);

	printf("Macierz pierwsza: \n");
   showMatrix(matrixOne, size);
   
	printf("Macierz druga: \n");
   showMatrix(matrixTwo, size);

	int **matrixAdd = generateMatrix(size);
	
	for (i=0; i<size; ++i){
		for (j=0; j<size; ++j){
			matrixAdd[i][j] = matrixOne[i][j] + matrixTwo[i][j];
		}
	}
	
	printf("Wynik dodawania: \n");
	showMatrix(matrixAdd, size);

	int **matrixInc = generateMatrix(size);
	
	for(i=0; i<size; ++i){ 
		for(j=0; j<size; ++j){ 
			for(k=0; k<size; ++k){ 
				matrixInc[i][j] += matrixOne[i][k] * matrixTwo[k][j]; 
			} 
		}
	}			
	
	printf("Wynik mnożenia: \n");
	showMatrix(matrixInc, size);
	
	freeMatrix(matrixOne, size);
	freeMatrix(matrixTwo, size);
	freeMatrix(matrixAdd, size);
	freeMatrix(matrixInc, size);
}
