#include <iostream>
#include <fstream>
#include <iomanip>
#include <math.h>
#define DIMMAX 500005
#define ll long long
#define un unsigned
#define FOR(i, a, b) for(un i = a; i <= b; i++)

using namespace std;

un v[DIMMAX], N;
un coada[10][DIMMAX];
un st[10], dr[10];

void enqueue(un nr,un poz)
{
    dr[poz]++;
    coada[poz][dr[poz]]=nr;
}

un dequeue(un poz)
{
    st[poz]++;
    un aux=coada[poz][st[poz]];
    return aux;
}

void citire()
{
    ifstream f("algsort.in");
    f>>N;
    FOR(i,1,N)
    {
        f>>v[i];
    }
    f.close();
}

 void afisare()
 {
     ofstream g("algsort.out");

     FOR(i,1,N)
     {
         g<<v[i]<<" ";
     }
     g.close();
 }

 void radixsort()
 {
     un len=10;  //pow(2,31)-1=2147483647 deci maxim 10 cifre
     int k=1;

     FOR(k,1,len)
     {
         ll putere=pow(10,k-1);
         FOR(i,1,N)
         {
             un poz=(v[i]/putere)%10;
             enqueue(v[i],poz);
         }
         un aux=1;
         int i=1;
         FOR(i,0,9)
         {
             while(st[i]<dr[i])
             {
                 v[aux++]=(un)dequeue(i);
             }
         }
     }
 }

int main()
{
    citire();
    radixsort();
    afisare();
    return 0;
}
