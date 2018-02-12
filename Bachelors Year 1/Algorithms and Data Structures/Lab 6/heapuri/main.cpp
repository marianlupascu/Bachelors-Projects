#include <bits/stdc++.h>
#define DIMMAX 200000
#define ll long long

using namespace std;

ifstream f("heapuri.in");
ofstream g("heapuri.out");

ll N;
typedef ll Heap[DIMMAX];
Heap HP, Ord;
ll indice[DIMMAX];
ll len;

void swp(ll &a, ll &b)
{
    ll aux = a;
    a = b;
    b = aux;
}

void down(ll N, ll k)
{
    ll son;
    do
    {
        son = 0;
        if (2 * k <= N)
        {
            son = 2 * k;
            if (2 * k + 1 <= N && HP[son] > HP[2 * k + 1])
                son = 2 * k + 1;
            if (HP[k] <= HP[son])
                son = 0;
        }
        if (son)
        {
            swp(HP[k], HP[son]);
            swp(Ord[k], Ord[son]);
            swp(indice[Ord[k]], indice[Ord[son]]);
            k = son;
        }
    }while(son);
}

void up(ll N, ll k)
{
    ll element = HP[k];
    ll ordin = Ord[k];
    while (k > 1 && HP[k / 2] > element)
    {
        HP[k] = HP[k / 2];
        Ord[k] = Ord[k / 2];
        indice[Ord[k]] = k;
        k = k / 2;
    }
    HP[k] = element;
    Ord[k] = ordin;
    indice[ordin] = k;
}
void sterge(ll &N, ll k)
{
    swp(HP[k], HP[N]);
    swp(Ord[k], Ord[N]);
    swp(indice[Ord[k]], indice[Ord[N]]);
    N--;
    if (k > 1 && HP[k] < HP[k / 2])
        up(N, k);
    else
        down(N, k);
}

void insereaza(ll &N, ll element, ll intrare)
{
    N++;
    HP[N] = element;
    Ord[N] = intrare;
    up(N, N);
}

int main()
{
    f>>N;
    ll nrIntrare=0;
    for(ll i = 1; i <= N; i++)
    {
        ll ind;
        ll x;
        f>>ind;
        switch(ind)
        {
            case 1: {f>>x; indice[++nrIntrare] = len + 1; insereaza(len, x, nrIntrare); break;}
            case 2: {f>>x; sterge(len, indice[x]); break;}
            case 3: {g<<HP[1]<<'\n'; break;}
        }
    }
    f.close();
    g.close();
    return 0;
}
