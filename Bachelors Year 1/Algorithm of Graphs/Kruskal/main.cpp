#include<bits/stdc++.h>
#define DIMMAX 1000
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

int radacina[DIMMAX];
int frst[DIMMAX], scnd[DIMMAX], cost[DIMMAX];
int n, m, ind_muchie[DIMMAX];
vector <int> arbore;
ofstream fout("grafpond.out");

void citire()
{
    ifstream fin("grafpond.in");
    fin >> n >> m;
    FOR(i, 1, m)
    {
        fin >> frst[i] >> scnd[i] >> cost[i];
        ind_muchie[i] = i;
    }
    fin.close();
}

int grupa(int i)
{
    if(radacina[i] == i)
        return i;
    radacina[i] = grupa(radacina[i]);
    return radacina[i];
}

void reuniune(int i,int j)
{
    radacina[grupa(i)] = grupa(j);
}

bool comparator(int i, int j)
{
    return (cost[i] < cost[j]);
}

void afisare()
{
    fout << n - 1 << '\n';

    for(int i = 0; i < n - 1; ++i)
        fout << frst[arbore[i]] << " " << scnd[arbore[i]] << '\n';

    fout.close();
}

int main()
{
    citire();

    FOR(i, 1, n)
        radacina[i] = i; // initial fiecare nod este in grupa sa

    sort(ind_muchie + 1, ind_muchie + m + 1, comparator); // sortare muchii

    FOR(i, 1, m)
        cout<<ind_muchie[i]<<" ";

    for(int i = 1;i <= m; ++i) //mercurg in ordine muchiile sortate
        if (grupa(frst[ind_muchie[i]]) != grupa(scnd[ind_muchie[i]])) // daca nu sunt in acceiasi grupa/ componenta
        {
            reuniune(frst[ind_muchie[i]], scnd[ind_muchie[i]]); // se reunesc primul nod cu al doilea nod din
            //muchia cu indicele ind_muchie[i]
            arbore.push_back(ind_muchie[i]); // se adauga in arbore indicele muchiei din ordinea citirii
        }

    afisare();

    return 0;
}
