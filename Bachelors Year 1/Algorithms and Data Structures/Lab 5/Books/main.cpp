#include <bits/stdc++.h>
#define ll long long
#define FOR(i,a,b) for(ll i=a;i<=b;i++)
#define DIMMAX 100005

using namespace std;

ll n,t;
int a[DIMMAX];
void citire()
{
    //ifstream f("input.in");
    cin>>n>>t;
    FOR(i,1,n)
    {
        cin>>a[i];
    }
}

ll numara_carti()
{
    ll j=1 ,maxim=-1,suma=0;;
    FOR(i,1,n)
    {
        suma+=a[i];
        while(suma>t)
        {
            suma-=a[j];
            j++;
        }
        maxim=max(maxim,i-j+1);
    }
    return maxim;
}

void afisare(ll x)
{
    cout<<x;
//    FOR(i,1,n)
//    {
//        cout<<'\n'<<i<<"="<<sum[i];
//    }
}

int main()
{
    citire();

    afisare(numara_carti());

    return 0;
}
