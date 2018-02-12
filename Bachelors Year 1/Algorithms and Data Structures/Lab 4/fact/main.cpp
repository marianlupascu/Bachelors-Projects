#include <iostream>
#include <fstream>
#define DIMMAX 4223372036854775807
#define ll long long int
#define FOR(i, a, b) for(int i = a; i <= b; i++)

ll P, N=1;

using namespace std;

void citire()
{
    ifstream f("fact.in");
    f>>P;
    f.close();
}

ofstream g("fact.out");

void afisare(int k)
{

     if(k==1)g<<1;
     else g<<N;

}

ll factorial(ll val)
{
    int ok=1;
    ll sum=0;
    ll aux=val/5;
    while(ok)
    {
        if(aux)
        {
            sum+=aux;
            aux/=5;
        }
        else ok=0;
    }
    return sum;
}

void binary_search(ll s, ll d)
{
    if(d<s){N=-1;return;}
    ll m=(s + d) / 2;
    ll aux=factorial(m);
    if(aux==P) {N=m;N=N-N%5;return;}
    else
        if(aux<P)binary_search(m+1,d);
        else binary_search(s,m-1);
}

int main()
{
    citire();

    if(P==0)
    {
         afisare(1);
         return 0;
    }


    binary_search(1,DIMMAX);


    afisare(2);

    g.close();

    return 0;
}
