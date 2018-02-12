#include <iostream>
#include <fstream>
#define DIMMAX 16005
#define ll long long
#define FOR(i,a,b) for(int i=a;i<=b;i++)

using namespace std;

int N, C, K, s[DIMMAX], maxim=-1;
ll Maxim;

void citire()
{
    ifstream f("transport.in");
    f>>N>>K;
    FOR(i,1,N)
    {
        f>>s[i];
        Maxim+=s[i];
        if(s[i] > maxim)
            maxim=s[i];
    }
    f.close();
}

void afisare()
{
    ofstream g("transport.out");
    g<<C;
    g.close();
}

int calcul_nr_trans(int x)
{
    ll sum=0,tr=1;
    FOR(i,1,N)
    {
        if(s[i]>x)return 0;
        sum+=s[i];
        if(sum>x)
        {
            sum=s[i];
            tr++;
        }
    }
    if(tr>K)return 0;
    return 1;
}

int cautareBinara(ll s, ll d)
{
    ll m;
    while(s<d)
    {
        m=(s+d)/2;
        int x=calcul_nr_trans(m);
        if(x)
            d=m;
        else
            s=m+1;
    }
    return s;
}

int main()
{
    citire();

    C=cautareBinara(maxim, Maxim);

    afisare();

    return 0;
}
