#include <iostream>
#include <fstream>
#include <iomanip>
#include <math.h>
#define DIMMAX 500005
#define sqrt_DIMMAX 710
#define ll long long
#define un unsigned
#define FOR(i, a, b) for(un i = a; i <= b; i++)

using namespace std;

int v[DIMMAX];
un N, rad, nou[DIMMAX],k=1;
int smen[2][sqrt_DIMMAX];

void init()
{
    FOR(i,0,DIMMAX-5)
    {
        v[i]=-2;
    }
    FOR(i,0,sqrt_DIMMAX-2)
    {
        smen[0][i]=-3;
    }
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

//     FOR(i,1,rad)
//     {
//         g<<smen[0][i]<<" ";
//     }
//     g<<'\n';
//     FOR(i,1,rad)
//     {
//         g<<smen[1][i]<<" ";
//     }
     FOR(i,1,N)
     g<<nou[i]<<" ";
     g.close();
}

void build_smen(un poz)
{
    int maxim=-10, loc;
    FOR(i, (poz-1)*rad+1, poz*rad)
    {
        if(v[i]>maxim)
        {
            maxim=v[i];
            loc=i;
        }
    }
    smen[0][poz]=maxim;
    smen[1][poz]=loc;
}

void sortare()
{
    int maxim=-5,loc;
    FOR(i,1,rad)
    {
        if(smen[0][i]>maxim)
        {
            maxim = smen[0][i];
            loc=i;
        }
    }
    loc=smen[1][loc];
    if(maxim>=0)
    {
        nou[k++]=maxim;
        v[loc]=-11;
        build_smen((loc-1)/rad+1);
    }
}

void inv()
{
    FOR(i,1,N/2)
    {
        int aux=nou[i];
        nou[i]=nou[N-i+1];
        nou[N-i+1]=aux;
    }
}

int main()
{
    init();
    citire();
    rad=sqrt(N);
    if(rad*rad!=N)rad++;

    FOR(i,1,rad)
    {
        build_smen(i);
    }

    FOR(i,1,N)
        sortare();

    inv();

    afisare();
    return 0;
}
