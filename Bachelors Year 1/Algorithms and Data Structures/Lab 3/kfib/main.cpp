#include <iostream>
#include <fstream>
#include <math.h>
#define MOD 666013
#define ll long long
#define FOR(i, a, b) for(ll i = a; i <= b; i++)

using namespace std;

ll N, m_n[2][2], m[2][2]={0,1,1,1},aux[2][2];

void citire()
{
    ifstream f("kfib.in");
    f>>N;
    f.close();
}

void recursie(ll);

 void afisare()
 {
     ofstream g("kfib.out");
     g<<m_n[1][1];
     g.close();
 }

 void recursie(ll putere)
 {
     if(putere==1)
     {
         m_n[0][0]=0;
         m_n[0][1]=m_n[1][0]=m_n[1][1]=1;

     }
     else
        if(putere%2)
            {
                recursie(putere-1);
                aux[0][0]=m_n[0][1];
                aux[1][0]=m_n[1][1];
                aux[0][1]=(m_n[0][1]+m_n[0][0])%MOD;
                aux[1][1]=(m_n[1][0]+m_n[1][1])%MOD;
                m_n[0][0]=aux[0][0];
                m_n[0][1]=aux[0][1];
                m_n[1][0]=aux[1][0];
                m_n[1][1]=aux[1][1];
            }
        else
            {
                recursie(putere/2);
                aux[0][0]=((m_n[0][0]*m_n[0][0])%MOD+(m_n[0][1]*m_n[1][0])%MOD)%MOD;
                aux[0][1]=((m_n[0][0]*m_n[0][1])%MOD+(m_n[0][1]*m_n[1][1])%MOD)%MOD;
                aux[1][0]=((m_n[1][0]*m_n[0][0])%MOD+(m_n[1][0]*m_n[1][1])%MOD)%MOD;
                aux[1][1]=((m_n[1][0]*m_n[0][1])%MOD+(m_n[1][1]*m_n[1][1])%MOD)%MOD;
                m_n[0][0]=aux[0][0];
                m_n[0][1]=aux[0][1];
                m_n[1][0]=aux[1][0];
                m_n[1][1]=aux[1][1];
            }
 }

int main()
{
    citire();

    recursie(N-1);

    afisare();

    return 0;
}
