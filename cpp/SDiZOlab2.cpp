#include <iostream>
#include <cstdlib>
#include <ctime>

// lista jednokierunkowa
// kod dziala, zaliczenie jest, edytowac dalej mi sie nie chce

using namespace std;

struct list
{
    int number;
    list *next;
    list()
    {
        number = 0;
        next = NULL;
    }
    ~list()
    {
        delete next;
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
int ui();

int main()
{
    first = NULL;
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
                first = NULL;
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
        }
    }
    while(w!=7);

    delete [] first;
    delete [] tail;
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
        if ( !first )
        {
            list *tmp = new list();
            tmp->number = key;
            cout << "Dodano " << tmp->number << endl;
            tmp->next = NULL;
            first = tmp;
            tail = first;
        }
        else
        {
            list *tmp = new list();
            list *nju = new list();
            list *prev = new list();
            prev = NULL;
            nju->next = NULL;
            nju->number = key;
            tmp = first;
            while(tmp)
            {
                if ( tmp->number < key )
                {
                    prev = tmp; tmp = prev->next;
                }
                else //znaleziono wlasciwe miejsce
                {
                    if (!prev) //nowy na poczatek
                    {
                        first = nju;
                    }
                    else
                    {
                        prev->next = nju;
                    }
                    nju->next = tmp;
                    //tail->next = first;
                    cout << "Dodano " << nju->number << endl;
                    break;
                }
                if (prev->next == NULL)
                {
                tail = nju;
                prev->next = tail; //nowy na koniec
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
        if ( !first )
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
    while( tmp != NULL );

    return what;
}

void search(int searched)
{
    list *tmp = new list();
    tmp = first;
    int i = 1;
    do
    {
        if ( !first )
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
    while( tmp != NULL );
}

void remove(int rm)
{
    list *tmp = new list();
    list *ubezpieczenie = new list();
    list *dowywalenia = new list();
    tmp = first;
    if ( check(rm) == 1 )
    {
        do
        {
            if ( tmp->next == tail ) //do usuniecia ostatniego elementu
            {
                ubezpieczenie = tmp;
            }
            if ( tmp->number == rm )
            {
                if ( tmp->next == NULL ) //do usuniecia ostatniego elementu
                {
                    ubezpieczenie->next = NULL;
                    tail = ubezpieczenie;
                    cout << "Usunięto!" << endl;
                    //delete tmp;
                    break;
                }
                else                        //kazdy inny element
                {
                    tmp->number = tmp->next->number;
                    tmp->next = tmp->next->next;
                    cout << "Usunięto!" << endl;
                    break;
                }
            }
            tmp = tmp->next;
        }
        while( tmp != NULL );
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
    if ( !first )
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
        while(tmp != NULL);
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
    cout << "7. Zakończ" << endl;
    cout << "Wybór: ";
    int w;
    cin >> w;
    return w;
}
