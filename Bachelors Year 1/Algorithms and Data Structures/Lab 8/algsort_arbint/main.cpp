#include <bits/stdc++.h>
#define DIMMAX 300005
#define FOR(i, a, b) for(int i = a; i <= b; i++)
#define INFINIT INT_MAX

using namespace std;

ifstream in("algsort.in");
ofstream out("algsort.out");
int N;
int aib[DIMMAX * 4];

int fiu_st(int f)
{
    return 2 * f;
}
int fiu_dr(int f)
{
    return 2 * f + 1;
}

void update(int nod, int st, int dr, int pozitie, int valoare)
{
    if(st == dr)
    {
        aib[nod] = valoare;
        return;
    }
    int mij = (st + dr) / 2;
    if(pozitie <= mij)
        update(fiu_st(nod), st, mij, pozitie, valoare);
    else
        update(fiu_dr(nod), mij + 1, dr, pozitie, valoare);

    aib[nod] = min(aib[fiu_st(nod)], aib[fiu_dr(nod)]);
}

int query(int nod, int st, int dr, int valoare)
{
    if (st == dr)
        return st;
    else
    {
        int mij = (st + dr) / 2;
        if(valoare == aib[fiu_st(nod)])
            return query(fiu_st(nod), st, mij, valoare);
        else
            return query(fiu_dr(nod), mij + 1, dr, valoare);
    }
}

int main()
{
    in >> N;
    int aux;
    FOR(i, 1, N)
    {
        in >> aux;
        update(1, 1, N, i, aux);
    }

    while(aib[1] != INFINIT)
    {
        out << aib[1] << " ";
        aux = query(1, 1, N, aib[1]);
        update(1, 1, N, aux, INFINIT);
    }

    in.close();
    out.close();
    return 0;
}

