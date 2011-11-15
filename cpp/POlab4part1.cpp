#include<iostream>
using namespace std;

class Macierz
{
      private:
              int x,y;
              int **macierz;
        public:
               Macierz(int _x,int _y) : x(_x),y(_y)
               {
                         macierz=new int*[y];
                         for(int i=0;i<y;i++) macierz[i]=new int[x];
               };
               void set(int x,int y,int wartosc)
               {
                   // cout<<endl<<wartosc<<endl;
                    macierz[x][y]=wartosc;
               }
               void uzupelnij()
               {
                    cout<<"uzupelnianie macierzy \n";
                    for(int i=0;i<y;i++)
                    {
                            for(int j=0;j<x;j++)
                            {
                                   cout<<"podaj wartosc dla "<<i<<" "<<j<<endl;
                                    int tmp;
                                    cin>>tmp;
                                    set(i,j,tmp);
                            }
                    }

               }
               void print()
               {
                    cout<<endl<<endl;
                    for(int i=0;i<y;i++)
                    {
                            for(int j=0;j<x;j++)
                            {
                                    cout<<macierz[i][j]<<" ";
                                    }
                            cout<<endl;
                    }
               }
               Macierz& operator+(const Macierz& a)
               {
                      Macierz tmp(x,y);
                      for(int i=0;i<y;i++)
                      {
                              for(int j=0;j<x;j++)
                              {
                                      tmp.macierz[i][j] = macierz[i][j] + a.macierz[i][j];
                              }
                      }
                      return tmp;

               }
               Macierz& operator-(const Macierz& a)
               {
                        Macierz tmp(x,y);
                        for(int i=0 ; i<y ; i++)
                        {
                            for(int j=0;j<x;j++)
                            {
                                tmp.macierz[i][j] = macierz[i][j] - a.macierz[i][j];
                                }
                        }
                        return tmp;
                }


};
int main()
{
    int r,e;
    cout <<"Podaj rozmiar macierzy A:" << endl;
    cin >> r;
    cout << "\nPodaj rozmiar macierzy B:" << endl;
    cin >> e;
    if(r!=e)
    {
         cout << "\nMacierze o roznych rozmiarach!!!! Blad operacji na macierzach!" << endl;
    }

    else
    {
    cout << "\nWprowadz wartosci do Macierzy A:\n";

    Macierz a(r,e);
    a.uzupelnij();

    cout << "\nWprowadz wartosci do Macierzy B:\n";

    Macierz b(r,e);
    b.uzupelnij();

    cout << "\nMacierz C = A+B:";

    Macierz c=a+b;
    c.print();

    cout << "\nMacierz D = A-B:";
    Macierz d=a-b;
    d.print();
    }
}
