#include <iostream>
#include <cstdlib>
#include <ctime>

// Lista dwukierunkowa.
// kod dziala, zaliczenie jest, edytowac dalej mi sie nie chce

using namespace std;

struct list
{
    int number;
    list *next;
    list *prev;
    list()
    {
        number = 0;
        next = NULL;
        prev = NULL;
    }
    ~list()
    {
        delete next;
        delete prev;
    }
};

list *first = new list();
list *tail = new list();

void generate(int howmuch);
void addone(int key);
int check(int key);
void search(int searched);
void remove(int rm);
void show();
void showend();
int ui();

int main()
{
    int w, temp;
    do
    {
        w = ui();
        switch(w)
        {
            case 1:
                system("clear");
                first->number = 0;
                first->next = NULL;
                first->prev = NULL;
                cout << "Done!";
                break;
            case 2:
                system("clear");
                cout << "Podaj ilość losowych elementów: ";
                cin >> temp;
                generate(temp);
                break;
            case 3:
                system("clear");
                cout << "Podaj wartość: ";
                cin >> temp;
                addone(temp);
                break;
            case 4:
                system("clear");
                cout << "Podaj wartość do wyszukania: ";
                cin >> temp;
                search(temp);
                break;
            case 5:
                system("clear");
                cout << "Podaj wartość do usunięcia: ";
                cin >> temp;
                remove(temp);
                break;
            case 6:
                system("clear");
                show();
                break;
            case 7:
                system("clear");
                showend();
                break;
        }
    }
    while(w!=8);
}

void generate(int howmuch)
{
    srand(time(NULL));
    for (int i = 0; i < howmuch; i++)
    {
        int j = (rand() % 1000);
        addone(j);
    }
}

void addone(int key)
{
    if ( check(key) == 1)
    {
        cout << "Wartość " << key << " już istnieje!" << endl;
    }
    else
    {
        if ( first->next == NULL )
        {
            first->number = key;
            cout << "Dodano " << first->number << endl;
            first->next = first;
            tail = first;
            first->prev = tail;
        }
        else
        {
            list *tmp = new list();
            list *nju = new list();
            list *previu = new list();
            previu = NULL;
            nju->next = NULL;
            nju->prev = NULL;
            nju->number = key;
            tmp = first;
            while(tmp)
            {
                if ( tmp->number < key )
                {
                    previu = tmp; tmp = previu->next;
                }
                else
                {
                    if (!previu) //nowy na poczatek
                    {
                        nju->next = tmp;
                        nju->prev = tail;
                        tmp->prev = nju;
                        first = nju;
                    }
                    else // w srodku
                    {
                        previu->next = nju;
                        nju->prev = previu;
                        nju->next = tmp;
                        tmp->prev = nju;
                    }
                    first->prev = tail;
                    tail->next = first;
                    cout << "Dodano " << nju->number << endl;
                    break;
                }
                if (previu->next == first)
                {
                tail = nju;
                previu->next = tail; //nowy na koniec
                tail->prev = previu;
                tail->next = first;
                first->prev = tail;
                cout << "Dodano " << nju->number << endl;
                break;
                }
            }
        }
    }
}

int check(int key)
{
    list *tmp = new list();
    tmp = first;
    int i = 1, what = 0;
    do
    {
        if ( tmp->next == NULL )
        {
            break;
        }
        if ( tmp->number == key )
        {
            what = 1;
            break;
        }
        tmp = tmp->next;
        i++;
    }
    while( tmp != first );

    return what;
}

void search(int searched)
{
    list *tmp = new list();
    tmp = first;
    int i = 1;
    do
    {
        if ( tmp->next == NULL )
        {
            cout << "Lista jest pusta!" << endl;
            break;
        }
        if ( tmp->number == searched )
        {
            cout << "Znaleziono na " << i << " miejscu od początku listy!" << endl;
            break;
        }
        cout << "Na miejscu " << i << " nie znaleziono!" << endl;
        tmp = tmp->next;
        i++;
    }
    while( tmp != first );
}

void remove(int rm)
{
    list *tmp = new list();
    list *dowywalenia = new list();
    tmp = first;
    if ( check(rm) == 1 )
    {
        do
        {
            if ( tmp->number == rm )
            {
                if ( tmp->prev != NULL )
                    tmp->prev->next = tmp->next;
                if ( tmp->next != NULL )
                    tmp->next->prev = tmp->prev;
                if ( tmp == tail )
                    tail = tmp->prev;
                if ( tmp == first )
                    first = tmp->next;
                cout << "Usunięto!" << endl;
                break;
            }
            tmp = tmp->next;
        }
        while( tmp != first );
    }
    else
    {
        cout << "Na liście nie ma takiego elementu do usunięcia lub lista jest pusta!" << endl;
    }

}

void show()
{
    list *tmp = new list();
    tmp = first;
    cout << endl << "Elementy to: " << endl;
    int i = 1;
    if ( tmp->next == NULL)
    {
        cout << "Lista jest pusta!" << endl;
    }
    else
    {
        do
        {
            cout << "Pozycja " << i << ": " << tmp->number << endl;
            tmp = tmp->next;
            i++;
        }
        while(tmp != first);
    }
}

void showend()
{
    list *tmp = new list();
    tmp = tail;
    cout << endl << "Elementy to: " << endl;
    int i = 1;
    if ( tmp->prev == NULL)
    {
        cout << "Lista jest pusta!" << endl;
    }
    else
    {
        do
        {
            cout << "Pozycja " << i << ": " << tmp->number << endl;
            tmp = tmp->prev;
            i++;
        }
        while( tmp != tail );
    }
}

int ui()
{
    cout << endl;
    cout << "\tMenu:" << endl;
    cout << "1. Zainicjuj pustą listę (Zerowanie)" << endl;
    cout << "2. Wstaw X losowo wygenerowanych elementów" << endl;
    cout << "3. Wstaw nowy element" << endl;
    cout << "4. Wyszukaj element" << endl;
    cout << "5. Usuń element" << endl;
    cout << "6. Wyświetl elementy" << endl;
    cout << "7. Wyświetl elementy od końca" << endl;
    cout << "8. Zakończ" << endl;
    cout << "Wybór: ";
    int w;
    cin >> w;
    return w;
}
