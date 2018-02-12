#include <iostream>
#include <fstream>
#include <math.h>
#define DIMMAX1 1030
#define DIMMAX2 50005
#define ll long long
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

int m[DIMMAX1][DIMMAX1], N, M, C, v[DIMMAX2],sum[DIMMAX1][DIMMAX1],frecv[DIMMAX2];

void citire()
{
    ifstream f("geamuri.in");
    f>>C;
    f>>N;
    FOR(i,1,N)
    {
        int x1,y1,x2,y2;
        f>>x1>>y1>>x2>>y2;
        m[x1][y1]++;
        m[x1][y2 + 1]--;
        m[x2 + 1][y1]--;
        m[x2 + 1][y2 + 1]++;
    }
    f>>M;
    FOR(i,1,M)
    {
        f>>v[i];
    }
    f.close();
}

 void afisare()
 {
     ofstream g("geamuri.out");

     FOR(i,1,M)
     {
         g<<frecv[v[i]]<<'\n';
     }
     g.close();
 }

 void constructie_sum()
 {
     FOR(i,1,C+1)
     {
         FOR(j,1,C+1)
         {
             sum[i][j]=sum[i][j-1]+sum[i-1][j]-sum[i-1][j-1]+m[i][j];
         }
     }
 }

 void constructie_frecv()
 {
     FOR(i,1,C)
     {
         FOR(j,1,C)
         {
             frecv[sum[i][j]]++;
         }
     }
 }

int main()
{
    citire();

    constructie_sum();

    constructie_frecv();

    afisare();

    return 0;
}
