#include <bits/stdc++.h>
#define ll long long
#define FOR(i,a,b) for(ll i=a;i<=b;i++)
#define DIMMAX 100005
#define MOD(a) ((a<0) ? (-a) : (a))
#define FOR(i,a,b) for(ll i=a;i<=b;i++)

using namespace std;

ll n,d;
pair<ll, ll> p[DIMMAX];
void citire()
{
    //ifstream f("input.in");
    cin>>n>>d;
    FOR(i,0,n-1)
    {
        cin>>p[i].first>>p[i].second;
    }
    sort(p,p+n);
}

ll numara_s()
{
    ll j=0,sum=0,maxim=0;
    FOR(i,0,n-1)
    {
        while(p[i].first + d > p[j].first)
        {
            if(j==n)return maxim;
            sum+=p[j].second;
            maxim=max(sum,maxim);
            j++;
        }
        sum-=p[i].second;
    }
    return maxim;
}
void afisare(ll x)
{
    cout<<x;
//    FOR(i,0,n-1)
//    {
//        cout<<'\n'<<p[i].first<<" "<<p[i].second;
//    }
}

int main()
{
    citire();

    afisare(numara_s());

    return 0;
}
