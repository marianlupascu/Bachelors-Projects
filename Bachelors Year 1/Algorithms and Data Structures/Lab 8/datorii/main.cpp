#include <bits/stdc++.h>
#define DIMMAX 100005
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

ifstream in("datorii.in");
ofstream out("datorii.out");
int N, M;
int ai[DIMMAX*4];

int fiu_st(int f)
{
    return 2 * f;
}

int fiu_dr(int f)
{
    return 2 * f + 1;
}

void update(int nod, int st, int dr, int valoare, int pozitie)
{
    if(st == dr)
    {
        ai[nod] = valoare;
        return;
    }
    int mij = (st + dr) / 2;
    if(pozitie <= mij)
        update(fiu_st(nod), st, mij, valoare, pozitie);
    else
        update(fiu_dr(nod), mij + 1, dr, valoare, pozitie);

    ai[nod] = ai[fiu_st(nod)] + ai[fiu_dr(nod)];
}

int query(int nod, int st, int dr, int inf, int sup)
{
    if (inf <= st && sup >= dr)
    {
        return ai[nod];
    }

    int mij = (st + dr) / 2;
    int a = 0, b = 0;
    if (inf <= mij)
        a = query(fiu_st(nod), st, mij, inf, sup);
    if (mij < sup)
        b = query(fiu_dr(nod), mij + 1, dr, inf, sup);
    return a + b;
}

int main()
{
    in >> N >> M;
    int aux;
    int v[DIMMAX];
    FOR(i, 1, N)
    {
        in >> aux;
        v[i] = aux;
        update(1, 1, N, aux, i);
    }

    int op, a, b;
    FOR(i, 1, M)
    {
        in >> op >> a >> b;
        if(op == 0)
        {
            v[a] = v[a] - b;
            update(1, 1, N, v[a], a);
        }
        else
        {
            out << query(1, 1, N, a, b) << '\n';
        }
    }

    in.close();
    out.close();
    return 0;
}
