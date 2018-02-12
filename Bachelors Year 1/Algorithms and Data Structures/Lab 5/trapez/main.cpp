#include <iostream>
#include <fstream>
#include <vector>
#define FOR(i,a,b) for(int i=a; i<=b; i++)
#define MMAX 999999
#include<bits/stdc++.h>

using namespace std;

long N;
struct punct
{
    long x,y;
};
vector<punct> p;
vector<double> m;

void citire()
{
    ifstream f("trapez.in");
    f>>N;
    FOR(i,0,N-1)
    {
        punct P;
        f>>P.x>>P.y;
        p.push_back(P);
    }
    f.close();
}

void afisare(unsigned x)
{
    ofstream g("trapez.out");

    g<<x<<'\n';
//
//    FOR(i,0,m.size()-1)
//    g<<m[i]<<"  ";

    g.close();
}

double panta(punct a, punct b)
{
    if((b.x-a.x)==0) return MMAX;
    double pan=(double)(b.y-a.y)/(double)(b.x-a.x);
    return pan;
}

void constructie_pante()
{
    FOR(i,0,N-1)
    {
        FOR(j,i+1,N-1)
        {
            m.push_back(panta(p[i],p[j]));
        }
    }
    sort(m.begin(),m.end());
}

int determina_trapeze()
{
    unsigned k=0,t;
    long i = 0, j;
    while (i < m.size())
    {
        j = i + 1;
        while(m[j] == m[j-1] && j < m.size())
            j++;
        k+=(j-i)*(j-i-1)/2;
        i=j;
    }
    return k;
}

int main()
{
    citire();

    constructie_pante();

    afisare(determina_trapeze());

    return 0;
}
