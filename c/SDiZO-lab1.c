#include <stdlib.h>
#include <stdio.h>
#include <time.h>

struct struktura
{
    int liczba;
    char znak;
};

struct struktura **tab;

struct struktura **los(int liczba)
{
    srand(time(NULL)); //żeby za każdym razem w randzie były różne wartości
    tab = (struct struktura**)malloc(sizeof(struct struktura*)*liczba);
    int i;
    for (i=0;i<liczba;i++)
    {
        tab[i] = (struct struktura*)malloc(sizeof(struct struktura));
        tab[i]->liczba = (rand() % 100);
        tab[i]->znak = (char)(rand() % 100);
    }
    return tab;
}

void usun(struct struktura **tab, int liczba)
{
    int i;
    for (i=0;i<liczba;i++)
    {
        free(tab[i]);
    }
    free(tab);
}

void pokaz(struct struktura **tab, int liczba)
{
    int i;
    for (i=0; i<liczba; i++)
    {
        printf("Liczba w %d strukturze to %d a znak to %c \n",i+1,tab[i]->liczba,tab[i]->znak);
    }
}

void sortuj(struct struktura **tab, int liczba)
{
    //sortowanie bąbelkowe
    struct struktura temp;
    int i,j;
    for (i=0; i<liczba; i++)
    {
        for (j=0; j<liczba-1; j++)
        {
            if (tab[j]->liczba > tab[j+1]->liczba)
            {
                temp.liczba = tab[j+1]->liczba;
                temp.znak = tab[j+1]->znak;
                tab[j+1]->liczba = tab[j]->liczba;
                tab[j+1]->znak = tab[j]->znak;
                tab[j]->liczba = temp.liczba;
                tab[j]->znak = temp.znak;
            }
        }
    }
}

int main()
{
    int numb;
    printf("Podaj ilość struktur: \t");
    scanf("%d",&numb);
    tab = los(numb);
    pokaz(tab,numb);
    sortuj(tab,numb);
    printf("\n");
    pokaz(tab,numb);
    usun(tab,numb);
}
