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
    friend void ustaw(osoba &pt);
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

void ustaw(osoba &pt)
{
    cout << "Podaj dane w kolejności: imię nazwisko dzień miesiąc rok: (zaprzyjaźniony)" << endl;
    char imie1[50], nazwisko1 [50];
    int dzien1, miesiac1, rok1;
    cin >> imie1 >> nazwisko1 >> dzien1 >> miesiac1 >> rok1;
    pt.imie = strdup(imie1);
    pt.nazwisko = strdup(nazwisko1);
    pt.dzien = dzien1;
    pt.miesiac = miesiac1;
    pt.rok = rok1;

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

    osoba *gosc4 = new osoba();
    ustaw(*gosc4);

    cout << "Gość 1:" << endl;
    gosc1->get();
    cout << "Gość 2:" << endl;
    gosc2->get();
    cout << "Gość 3:" << endl;
    gosc3->get();
    cout << "Gość 4: (zaprzyjaźniony)" << endl;
    gosc4->get();

    delete gosc1;
    delete gosc2;
    delete gosc3;
    delete gosc4;
}
