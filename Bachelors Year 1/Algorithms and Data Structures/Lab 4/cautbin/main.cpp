#include <iostream>
#include <fstream>
#include <math.h>
#define DIMMAX 100005
#define ll long long
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

ll N, M;
int a[DIMMAX];

ifstream f("cautbin.in");
void citire()
{
    f>>N;
    FOR(i, 1, N)
    {
        f>>a[i];
    }
    f>>M;
}

ofstream g("cautbin.out");

void afisare(int x)
{
    g<<x<<'\n';
}

int caz0(int s, int d, int val)
{
    int m;
    while(s<=d)
    {
        m=(d+s)/2;
        if (a[m]<=val)
            s=m+1;
        else
            d=m-1;
    }
    m =(s+d)/2;

    if (a[m]>val)m--;
    if (a[m]==val)
        return m;
    return -1;
}

int caz1(int s, int d, int val)
{
    int m;
    while (s<d)
    {
        m=(d+s)/2;
        if(a[m]<=val)
            s=m+1;
        else
            d=m;
    }
    m=(s+d)/2;
    if(a[m]>val)--m;
    return m;
}

int caz2(int s, int d, int val)
{
    int m;
    while (s<d)
    {
        m =(s+d)/2;
        if (a[m]<val)
            s=m+1;
        else
            d=m;
    }

    m=(s+d)/2;
    if (a[m]<val)++ m;
    return m;
}

int main()
{
    citire();

    FOR(i,1,M)
    {
        int tip,val;
        f>>tip>>val;
        if(tip==0)
        {
            afisare(caz0(1,N,val));
        }
        else
            if(tip==1)
            {
                afisare(caz1(1,N,val));
            }
            else
            {
                afisare(caz2(1,N,val));
            }
    }

    g.close();
    f.close();

    return 0;
}
