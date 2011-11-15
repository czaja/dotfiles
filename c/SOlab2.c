#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <wait.h> /* waitpid */
#include <sys/types.h> /* pid_t */
#include <errno.h> /* errno */
#include <unistd.h> /* _exit, fork */

//działa tylko dla wartości od 0 do 255;
//dlatego, ze do status mozna przekazac max 8 najmniej znaczacych bitow;


int main()
{
    printf("Define size of table: ");
    int size, i, min, max, status;
    scanf("%d",&size);
    printf("\n");
    int *tab = ( int* ) malloc( sizeof(int) * size );
    srand(time(NULL));

    for ( i=0; i<size; i++ )
    {
        tab[i] = (rand () % 100);
        printf("%d ", tab[i]);
    }

    printf("\n");

    pid_t pid1, pid2;

    pid1 = fork();
    if ( pid1 == -1 ) {
        perror("Cannot proceed. fork() error");
        return 1;
    }
    if ( pid1 == 0 )
    {
        int j = 0, max = tab[0];
        while ( j != size )
        {
            if ( tab[j] >  max ) max = tab[j];
            j++;
        }
        printf("I am fork(), my parent: %d and I: %d \n", getppid(), getpid());
        _exit(max);
        //return max;
    }

    pid2 = fork();
    if ( pid2 == -1 ) {
        perror("Cannot proceed. fork() error");
        return 1;
    }
    if ( pid2 == 0 )
    {
        int k = 0, min = tab[0];
        for ( k=0; k<size; k++ )
        {
            if ( tab[k] < min ) min = tab[k];
        }
        printf("I am fork(), my parent: %d and I: %d \n", getppid(), getpid());
        _exit(min);
        //return min;
    }

    waitpid(pid1, &status, 0);
    max = WEXITSTATUS(status);
    waitpid( pid2, &status, 0);
    min = WEXITSTATUS(status);

    printf("Min: %d, Max: %d \n", min, max);

}
