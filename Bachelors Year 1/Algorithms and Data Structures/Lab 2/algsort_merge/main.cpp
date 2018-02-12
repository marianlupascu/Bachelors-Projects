#include <iostream>
#include <fstream>
#include <iomanip>
#include <math.h>
#define DIMMAX 500005
#define ll long long
#define un unsigned
#define FOR(i, a, b) for(un i = a; i <= b; i++)

using namespace std;

un v[DIMMAX], v_nou[DIMMAX], N;

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

void ordonare (un s, un d )
{
    un aux;
    if(v[s]>v[d])
    {
        aux=v[s];
        v[s]=v[d];
        v[d]=aux;
    }
}
void interclasare (un s, un d, un m)
{
    un i, k=0, j, a[DIMMAX];
    i=s;
    j=m+1;
    while (i<=m&&j<=d)
    {
        if(v[i]<v[j])
        {
            k++;
            a[k]=v[i];
            i++;
        }
        else
        {
            k++;
            a[k]=v[j];
            j++;
        }
    }
    if(i<=m)
    FOR(j,i,m)
    {
        k++;
        a[k]=v[j];
    }
    else
    {
        FOR(i,j,d)
        {
            k++;
            a[k]=v[i];
        }
    }
    FOR(i,1,k)
        v[s+i-1]=a[i] ;
}

void mergesort(un s, un d)
{
    un m;
    if(d<=s+1)
    ordonare(s,d);
    else
    {
        m=(s+d)/2;
        mergesort(s,m);
        mergesort(m+1,d);
        interclasare(s,d,m);
    }
}

int main()
{
    citire();
    mergesort(1,N);
    afisare();
    return 0;
}
