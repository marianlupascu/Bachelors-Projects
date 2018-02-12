#include <bits/stdc++.h>
#define DIMMAX 30005
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

int N, s[DIMMAX], sol[DIMMAX], aib[4 * DIMMAX];

void citire()
{
    ifstream in("schi.in");
    in >> N;
    for(int i = N; i >= 1; i--)
        in >> s[i];
    in.close();
}

int fiu_st(int f)
{
    return 2 * f;
}
int fiu_dr(int f)
{
    return 2 * f + 1;
}

void update(int nod, int st, int dr, int poz, int valoare)
{
        if(st == dr)
        {
            aib[nod] = valoare;
            return;
        }
        int mij = (st + dr) / 2;
        if(poz <= mij)
            update(fiu_st(nod), st, mij, poz, valoare);
        else
            update(fiu_dr(nod), mij + 1, dr, poz, valoare);

        aib[nod] = aib[fiu_st(nod)] + aib[fiu_dr(nod)];
}

int query(int nod, int st, int dr, int valoare)
{
        if (st == dr)
            return st;
        int mij = (st + dr) / 2;
        if (valoare <= aib[fiu_st(nod)])
            return query(fiu_st(nod), st, mij, valoare);
        else
            return query(fiu_dr(nod), mij + 1, dr, valoare - aib[fiu_st(nod)]);
}

void afisare()
{
    ofstream out("schi.out");

    FOR(i, 1, N)
        update(1, 1, N, i, 1);

    FOR(i, 1, N)
    {
        int aux = query(1, 1, N, s[i]);
        sol[aux] = N - i + 1;
        update(1, 1, N, aux, 0);
    }

    FOR(i, 1, N)
        out << sol[i] <<'\n';
    out.close();
}

int main()
{
    citire();

    afisare();

    return 0;
}
