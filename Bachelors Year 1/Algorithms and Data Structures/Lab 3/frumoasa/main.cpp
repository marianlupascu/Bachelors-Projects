#include <iostream>
#include <fstream>
#include <math.h>
#define MOD 1000000007
#define ll long long
#define FOR(i, a, b) for(ll i = a; i <= b; i++)

using namespace std;

ll N, P, aux=1;

void citire()
{
    ifstream f("frumoasa.in");
    f>>N;
    f>>P;
    f.close();
}

ll recursie(ll);

 void afisare(int ok)
 {
     ofstream g("frumoasa.out");
     if(ok==-1)
            g<<"0";
     else
        g<<(recursie(N-P)*aux)%MOD;
     g.close();
 }

 ll recursie(ll putere)
 {
     if(putere==0)return 1;
     else
        if(putere%2)
            return ((26-P) * recursie(putere-1)%MOD)%MOD;
        else
            {
                ll aux1=recursie(putere/2)%MOD;
                return (aux1*aux1)%MOD;
            }
 }

int main()
{
    citire();

    if(P>=26) afisare(-1);
    FOR(i,26-P+1,26)
    aux=(aux*i)%MOD;

    afisare(1);

    return 0;
}
