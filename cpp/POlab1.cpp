#include <iostream>
#include <string.h>

using namespace std;

class osoba
{
    char *imie;
    char *nazwisko;
    int dzien, miesiac, rok;
public:
    osoba();
    osoba(osoba &from);
    osoba(char *imie1, char *nazwisko1, int dzien1, int miesiac1, int rok1);
    ~osoba();
    void get();
    void setimie();
    void setnazwisko();
    void setdzien();
    void setmiesiac();
    void setrok();
};

osoba::osoba()
{
    imie=NULL;
    nazwisko=NULL;
    dzien=0;
    miesiac=0;
    rok=0;
}

osoba::osoba(osoba &from)
{
    imie = strdup(from.imie);
    nazwisko = strdup(from.nazwisko);
    dzien = from.dzien;
    miesiac = from.miesiac;
    rok = from.rok;
}

osoba::osoba(char *imie1, char *nazwisko1, int dzien1, int miesiac1, int rok1)
{
    imie = strdup(imie1);
    nazwisko = strdup(nazwisko1);
    dzien = dzien1;
    miesiac = miesiac1;
    rok = rok1;
}

osoba::~osoba()
{
    delete [] imie;
    delete [] nazwisko;
}

void osoba::get()
{
    cout << "Imię: " << imie << "\tNazwisko: " << nazwisko << "\tData: " << dzien << " " << miesiac << " " << rok << endl;
}

void osoba::setimie()
{
    char imietmp[50];
    cout << "Podaj imię: ";
    cin >> imietmp;
    cout << endl;
    imie = strdup(imietmp);
}

void osoba::setnazwisko()
{
    char nazwiskotmp[50];
    cout << "Podaj nazwisko: ";
    cin >> nazwiskotmp;
    cout << endl;
    nazwisko = strdup(nazwiskotmp);
}

void osoba::setdzien()
{
    cout << "Podaj dzien: ";
    cin >> dzien;
    cout << endl;
}

void osoba::setmiesiac()
{
    cout << "Podaj miesiac: ";
    cin >> miesiac;
    cout << endl;
}

void osoba::setrok()
{
    cout << "Podaj rok: ";
    cin >> rok;
    cout << endl;
}

int main()
{
    char imie[50], nazwisko [50];
    int dzien, miesiac, rok;

    osoba *gosc1 = new osoba();
    gosc1->setimie();
    gosc1->setnazwisko();
    gosc1->setdzien();
    gosc1->setmiesiac();
    gosc1->setrok();

    cout << "Podaj dane w kolejności: imię nazwisko dzień miesiąc rok:" << endl;
    cin >> imie >> nazwisko >> dzien >> miesiac >> rok;

    osoba *gosc2 = new osoba(imie,nazwisko,dzien,miesiac,rok);

    osoba *gosc3 = new osoba(*gosc2);

    cout << "Gość 1:" << endl;
    gosc1->get();
    cout << "Gość 2:" << endl;
    gosc2->get();
    cout << "Gość 3:" << endl;
    gosc3->get();

    delete gosc1;
    delete gosc2;
    delete gosc3;
}
