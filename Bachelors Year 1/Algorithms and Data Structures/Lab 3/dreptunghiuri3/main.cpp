#include <iostream>
#include <fstream>
#include <math.h>
#define DIMMAX1 3000
#define DIMMAX2  1005
#define ll long long
#define FOR(i, a, b) for(ll i = a; i <= b; i++)

using namespace std;

int m[DIMMAX1][DIMMAX1], N, M, K, sum[DIMMAX1][DIMMAX1], frecv[DIMMAX2];

ll aux, maxim, nr;

void citire()
{
    ifstream f("dreptunghiuri3.in");
    f>>N>>M>>K;
    FOR(i,1,K)
    {
        int x1,y1,x2,y2,v;
        f>>x1>>y1>>x2>>y2>>v;
        aux+=v;
        m[x1][y1]+= v;
        m[x1][y2 + 1]-= v;
        m[x2 + 1][y1]-= v;
        m[x2 + 1][y2 + 1]+= v;
    }
    f.close();
}

 void afisare()
 {
     ofstream g("dreptunghiuri3.out");
//
//     FOR(i,1,aux)
//     {
//         g<<i<<"   "<<frecv[i]<<'\n';
//     }
     g<<maxim<<" "<<nr;
     g.close();

 }

 void constructie_sum()
 {
     FOR(i,1,N+1)
     {
         FOR(j,1,M+1)
         {
             sum[i][j]=sum[i][j-1]+sum[i-1][j]-sum[i-1][j-1]+m[i][j];
         }
     }
 }

 void constructie_frecv()
 {
     FOR(i,1,N)
     {
         FOR(j,1,M)
         {
             ll c=sum[i][j];
             frecv[sum[i][j]]++;
             if(c>=maxim && frecv[c])
             {
                 maxim=c;
                 nr=frecv[c];
             }
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
