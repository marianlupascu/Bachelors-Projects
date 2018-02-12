#include <bits/stdc++.h>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
#define DIMMAX 500001

using namespace std;

int N;
int srd[DIMMAX], rsd[DIMMAX], e[DIMMAX];
ofstream out("curatenie.out");

void citire()
{
    ifstream in("curatenie.in");
    in >> N;
    FOR(i, 1, N)
    {
        in >> srd[i];
        e[srd[i]] = i;
    }
    FOR(i, 1, N)
    {
        in >> rsd[i];
    }
    in.close();
}

struct nod
{
	int inf;
	nod *st, *dr;
}ARB;

int len;
void construct(int st, int dr, nod* &rad)
{
    if (st>dr)
    {
        rad = new ARB;
        rad->inf=0;
        rad->st=NULL;
        rad->dr=NULL;
        return ;
    }
    int mij = e[rsd[++len]];
    rad = new ARB;
    rad->inf=srd[mij];
    construct(st, mij-1, rad->st);
    construct(mij + 1,dr, rad->dr);
}

void afisare(ARB *rad, int i)
{
    if(rad)
    {
        if(i==rad->inf)
        {
            out<<rad->st->inf<<" "<<rad->dr->inf<<'\n';
        }
        else
        {
            if(e[rad->inf] > e[rad->st->inf] && rad->st->inf)
                afisare(rad->st, i);
            if(e[rad->inf] < e[rad->dr->inf] && rad->dr->inf)
                afisare(rad->dr, i);
        }
    }
    else
        return ;

}


int main()
{
    citire();
    ARB *rad;
    construct(1, N, rad);
    FOR(i, 1, N)
        afisare(rad, i);

    out.close();
    return 0;
}
