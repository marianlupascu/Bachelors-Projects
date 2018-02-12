#include <iostream>
#include <fstream>
#include <math.h>
#define MOD 1999999973
#define ll long long
#define FOR(i, a, b) for(ll i = a; i <= b; i++)

using namespace std;

ll N, P;

void citire()
{
    ifstream f("lgput.in");
    f>>N;
    f>>P;
    f.close();
}

ll recursie(ll);

 void afisare()
 {
     ofstream g("lgput.out");
     g<<recursie(P);
     g.close();
 }

 ll recursie(ll putere)
 {
     if(putere==0)return 1;
     else
        if(putere%2)
            return (N * recursie(putere-1)%MOD)%MOD;
        else
            {
                ll aux=recursie(putere/2)%MOD;
                return (aux*aux)%MOD;
            }
 }

int main()
{
    citire();

    afisare();

    return 0;
}
