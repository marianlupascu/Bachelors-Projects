#include <bits/stdc++.h>
#define ll long long
#define FOR(i, a, b) for(ll i = a; i < b; i++)

using namespace std;

int prim() // genereaza primul numar prim dupa anul ales aleator
{
    srand(time(NULL));
    int prim = rand();
    while(prim < 9000 || prim > 10000)
        prim = rand();

    while(1)
    {
        int aux = 1;
        for(int i = 2; i <= sqrt(prim) && aux; i++)
        {
            if(prim % i == 0)
                aux = 0;
        }
        if(aux)
            return prim;
        else
            prim++;
    }
}

ll N;
int M;
vector <ll> v[10000];

void inserare(ll x)
{
    v[x % M].push_back(x);
}

void stergere(ll x)
{
    FOR(i, 0, v[x % M].size())
    {
        if(v[x % M][i] == x)
            v[x % M][i] = -1;
    }
}

int cautare(ll x)
{
    FOR(i, 0, v[x % M].size())
        if(v[x % M][i] == x)
            return 1;
    return 0;
}

int main()
{
    ifstream in("hashuri.in");
    ofstream out("hashuri.out");

    M = prim();

    in >> N;
    ll op, x;
    FOR(i, 0, N)
    {
        in >> op >> x;
        switch(op)
        {
        case 1:{inserare(x); break;}
        case 2:{stergere(x); break;}
        case 3:{out << cautare(x) << "\n"; break;}
        }
    }

    in.close();
    out.close();
    return 0;
}
