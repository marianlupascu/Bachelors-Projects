#include <bits/stdc++.h>
#define DIMMAX 100005
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

ifstream in("arbint.in");
ofstream out("arbint.out");
int N, M;
int ai[DIMMAX*5];
int maxim;

void update(int nod, int st, int dr, int valoare, int pozitie)
{
    if(st == dr)
    {
        ai[nod] = valoare;
        return;
    }
    int mij = (st + dr) / 2;
    if(pozitie <= mij)
        update(2 * nod, st, mij, valoare, pozitie);
    else
        update(2 * nod + 1, mij + 1, dr, valoare, pozitie);

    ai[nod] = max(ai[2 * nod], ai[2 * nod + 1]);
}

void query(int nod, int st, int dr, int a, int b)
{
    if (a <= st && dr <= b)
    {
        if (maxim < ai[nod])
            maxim = ai[nod];
        return;
    }

    int mij = (st + dr) / 2;
    if (a <= mij)
        query(2 * nod, st, mij, a, b);
    if (mij < b)
        query(2 * nod + 1, mij + 1, dr, a, b);
}

int main()
{
    in >> N >> M;
    int aux;
    FOR(i, 1, N)
    {
        in >> aux;
        update(1, 1, N, aux, i);
    }

    int op, a, b;
    FOR(i, 1, M)
    {
        in >> op >> a >> b;
        if(op == 1)
        {
            update(1, 1, N, b, a);
        }
        else
        {
            maxim = -1;
            query(1, 1, N, a, b);
            out << maxim << '\n';
        }
    }

    in.close();
    out.close();
    return 0;
}
