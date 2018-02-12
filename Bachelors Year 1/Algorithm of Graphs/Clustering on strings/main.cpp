//Fişierul cuvinte.in conţine cuvinte separate prin spaţiu. Se citeşte de 
//la tastatură un număr natural k. Se consideră distanţa Levenshtein între
//două cuvinte https://en.wikipedia.org/wiki/Levenshtein_distance, calculată 
//prin subprogramul distanta definit mai jos (detalii la cursul de Tehnici 
//de programare).
//Să se împartă cuvintele din fişier în k clase (categorii) nevide astfel 
//încât gradul de separare al claselor să fie maxim ( = distanţa minimă între
//două cuvinte din clase diferite) - v. curs; se vor afişa pe câte o linie 
//cuvintele din fiecare clasă și pe o altă linie gradul de separare al 
//claselor. O(n^2 log n)

#include<bits/stdc++.h>
#define DIMMAX 1000
#define LEN_MAX 10000
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

int radacina[DIMMAX];
int frst[DIMMAX], scnd[DIMMAX], cost[DIMMAX];
int k, n, m, ind_muchie[DIMMAX];
vector <string> cuv;
vector <int> arbore;
ofstream fout("clustering.out");

void citire()
{
    ifstream fin("cuvinte.in");
    fin >> k;
    char aux[LEN_MAX];
    while ( fin >> aux )
    {
        string S = aux;
        cuv.push_back(S);
    }
    fin.close();
}

int distanta_levenshtein(string s1, string s2)
{
    int n1 = s1.length();
    int n2 = s2.length();
    int *ci1 = new int[n2 + 1];
    int *ci = new int[n2 + 1];
    for(int j = 0; j <= n2; j++)
        ci1[j] = j;
    for(int i = 1; i <= n1; i++)
    {
        ci[0] = i;
        for(int j = 1; j <= n2; j++)
            if(s1[i - 1] == s2[j - 1])
                ci[j] = ci1[j - 1];
            else
                ci[j] = 1 + min(min(ci1[j], ci[j - 1]), ci1[j - 1]);
    for(int j = 0; j <= n2; j++)
        ci1[j] = ci[j];
    }
    return ci[n2];
}

void constructie_muchii()
{
    m = 0;
    n = cuv.size();
    for(int i = 0; i < cuv.size(); i++)
    {
        for(int j = i + 1; j < cuv.size(); j++)
        {
            frst[m] = i;
            scnd[m] = j;
            cost[m] = distanta_levenshtein(cuv[i], cuv[j]);
            ind_muchie[m] = m++;
        }
    }
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

bool marc[DIMMAX];
int ramas;

void afisare()
{
    FOR(i, 0, n)
        marc[i] = false;
    for(int i = 0; i < cuv.size(); ++i)
    {
        cout<<cuv[i]<<"  "<<cuv[grupa(i)]<<'\n';
        marc[grupa(i)] = true;
    }
}

void afisare_fin()
{
    int aux = 0;
    FOR(j, 1, k)
    {
        while(!marc[aux] && aux < n)
            aux++;
        for(int i = 0; i < cuv.size(); ++i)
            if(cuv[grupa(i)] == cuv[grupa(aux)])
                fout<<cuv[i]<<"  ";
        fout<<'\n';
        aux++;
    }
    fout<<cost[ramas];

    fout.close();
}

int main()
{
    citire();

    constructie_muchii();

    FOR(i, 0, m - 1)
        cout<<i<<": "<<frst[i]<<"  "<<scnd[i]<<"  "<<cost[i]<<'\n';
    cout<<'\n';

    FOR(i, 0, n - 1)
        radacina[i] = i; // initial fiecare nod este in grupa sa

    sort(ind_muchie, ind_muchie + m + 1, comparator); // sortare muchii

    FOR(i, 0, m - 1)
        cout<<ind_muchie[i]<<" ";
    cout<<'\n'<<'\n';

    int aux = n - k;

    for(int i = 0; i < m  && aux; ++i) //repcurg in ordine muchiile sortate
        if (grupa(frst[ind_muchie[i]]) != grupa(scnd[ind_muchie[i]])) // daca nu sunt in acceiasi grupa/ componenta
        {
            reuniune(frst[ind_muchie[i]], scnd[ind_muchie[i]]); // se reunesc primul nod cu al doilea nod din
            //muchia cu indicele ind_muchie[i]
            arbore.push_back(ind_muchie[i]); // se adauga in arbore indicele muchiei din ordinea citirii
            aux--;
            afisare();
            cout<<'\n'<<'\n';
            ramas = ind_muchie[i];
        }

    afisare_fin();

    return 0;
}
