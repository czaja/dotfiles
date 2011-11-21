#include <iostream>

using namespace std;

class Bazowa1
{
private:
    int x;
protected:
    int y;
public:
    int a,b;

      void set(int xx, int yy, int aa, int bb)
      {
          x=xx; y=yy; a=aa; b=bb;
      }

      void get()
      {
           cout << "Wartosc Pierwszej Bazowej\n";
           cout << "x = " << x << endl;
           cout << "y = " << y << endl;
           cout << "a = " << a << endl;
           cout << "b = " << b << endl;
      }
};

class Bazowa2
{
public:
    int a,b;

    void set(int aa, int bb)
    {
        a=aa; b=bb;
    }

    void get()
    {
        cout << "Wartosc Drugiej Bazowej\n";
        cout << "a = " << a << endl;
        cout << "b = " << b << endl;
    }
};

class Pochodna : public Bazowa1, public Bazowa2
{
public:
    void set_Bazowa1(int xx, int yy, int aa, int bb)
    {
        Bazowa1::set(xx,yy,aa,bb);
    }

    void set_Bazowa2(int aa, int bb)
    {
        Bazowa2::set(aa,bb);
    }
};

int main()
{
    Pochodna nowy;
    nowy.set_Bazowa1(1,2,3,4);
    nowy.set_Bazowa2(5,6);

    nowy.Bazowa1::get();
    nowy.Bazowa2::get();
}
