#include <iostream>

using namespace std;

class klasa
{
    int liczba;
public:
    int& operator[](int dodawana)
    {
        liczba += dodawana;
        return liczba;
    }
    int& operator()(int od1, int od2, int od3)
    {
        liczba -= od1;
        liczba -= od2;
        liczba -= od3;
        return liczba;
    }
    klasa(int liczba1) : liczba(liczba1){};
    void get()
    {
        cout << liczba << endl;
    }
};

int main()
{
    klasa licz(0);
    cout << "dodaje 123" << endl;
    licz[123];
    licz.get();
    cout << "odejmuje 3 liczby" << endl;
    licz(3,20,100);
    licz.get();
}
