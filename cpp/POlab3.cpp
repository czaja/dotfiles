#include <iostream>

using namespace std;

class B;

class A
{
    int x;
public:
    friend class B;
    void set(B &pt, int x2, int y2);
    void get(B &pt);
};

class B
{
    int y;
public:
    friend class A;
    void set(A &pt, int x1, int y1)
    {
        pt.x = x1;
        y = y1;
    }
    void get(A &pt)
    {
        cout << pt.x << " " << y << endl;
    }
};

void A::set(B &pt, int x2, int y2)
{
    pt.y = y2;
    x = x2;
}

void A::get(B &pt)
{
    cout << x << " " << pt.y << endl;
}

int main()
{
    A *klasa1 = new A();
    A *klasa2 = new A();
    B *klasa3 = new B();
    B *klasa4 = new B();

    klasa1->set(*klasa3, 1, 2);
    klasa4->set(*klasa2, 3, 4);
    klasa1->get(*klasa3);
    klasa4->get(*klasa2);

}

