//Implementaţi un algoritm eficient pentru determinarea primilor doi arbori
//parţial cu cele mai mici costuri, pentru un graf conex ponderat, în ipoteza 
//că muchiile au costuri distincte (O(n2)). Graful se va citi din fişierul 
//grafpond.in. Pentru determinarea arborelui parţial de cost minim (primul) 
//se va folosi un algoritm de complexitate O(m log n)

#include<bits/stdc++.h>
#define DIMMAX 1000
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

int radacina[DIMMAX];
int frst[DIMMAX], scnd[DIMMAX], cost[DIMMAX];
int matrixcost[DIMMAX][DIMMAX];
int n, m, ind_muchie[DIMMAX], C;
vector <int> arbore;
bool mfolosit[DIMMAX * DIMMAX];
ofstream fout("grafpond.out");
int tata[DIMMAX];
int rad = 1;

void citire()
{
    ifstream fin("grafpond.in");
    fin >> n >> m;
    FOR(i, 1, m)
    {
        fin >> frst[i] >> scnd[i] >> cost[i];
        matrixcost[frst[i]][scnd[i]] = cost[i];
        matrixcost[scnd[i]][frst[i]] = cost[i];
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

void afisare_APM()
{
    fout << "Primul: " << '\n';
    fout << "Cost: "<< C << '\n';
    fout << "Muchii: ";
    fout << n - 1 << '\n';

    for(int i = 2; i <= n; ++i)
        fout << i << " " << tata[i] << '\n';

}

int viz[DIMMAX];

void APM(int nod)
{
    viz[nod] = 1;
    for(int i = 0; i < arbore.size(); i++)
    {
        if(frst[arbore[i]] == nod && !viz[scnd[arbore[i]]])
        {
            tata[scnd[arbore[i]]] = nod;
            APM(scnd[arbore[i]]);
        }
        if(scnd[arbore[i]] == nod && !viz[frst[arbore[i]]])
        {
            tata[frst[arbore[i]]] = nod;
            APM(frst[arbore[i]]);
        }
    }
}

vector <int> generare(int poz)
{
    vector <int> desc;
    while(poz)
    {
        desc.push_back(poz);
        poz = tata[poz];
    }
    return desc;
}

struct SecondAPM
{
    pair <int, int> de_inlocuit;
    pair <int, int> inlocuit;
    int diferenta;
};
vector <SecondAPM> SAPM;

void DAPM()
{
    FOR(i, 1, m)
    {
        if(!mfolosit[i])
        {
            cout<<frst[i]<<" "<<scnd[i]<<'\n';
            vector <int> aux1 = generare(frst[i]);
            vector <int> aux2 = generare(scnd[i]);
            while(aux1[aux1.size() - 1] == aux2[aux2.size() - 1] && aux1[aux1.size() - 2] == aux2[aux2.size() - 2])
            {
                aux1.pop_back();
                aux2.pop_back();
            }
            SecondAPM edge;
            edge.diferenta = INT_MIN;
            edge.de_inlocuit = make_pair(frst[i], scnd[i]);
            for(int j = 0; j <= aux1.size() - 2 && aux1.size() > 1; j++)
                if(matrixcost[aux1[j]][aux1[j + 1]] >= edge.diferenta)
                {
                    edge.diferenta = matrixcost[aux1[j]][aux1[j + 1]];
                    edge.inlocuit = make_pair(aux1[j], aux1[j + 1]);
                }
             for(int j = 0; j <= aux2.size() - 2 && aux2.size() > 1; j++)
                if(matrixcost[aux2[j]][aux2[j + 1]] >= edge.diferenta)
                {
                    edge.diferenta = matrixcost[aux2[j]][aux2[j + 1]];
                    edge.inlocuit = make_pair(aux2[j], aux2[j + 1]);
                }
            edge.diferenta = cost[i] - edge.diferenta;
            cout<<edge.diferenta<<" "<<edge.de_inlocuit.first<<" "<<edge.de_inlocuit.second<<"   "<<edge.inlocuit.first<<" "<<edge.inlocuit.second<<'\n';
            SAPM.push_back(edge);
        }
    }
}

void afisare_DAPM()
{
    fout << "Al doilea: " << '\n';
    fout << "Cost: "<< C + SAPM[0].diferenta << '\n';
    fout << "Muchii: ";
    fout << n - 1 << '\n';

    for(int i = 2; i <= n; ++i)
    {
         if((i == SAPM[0].inlocuit.first && tata[i] == SAPM[0].inlocuit.second)||(i == SAPM[0].inlocuit.second && tata[i] == SAPM[0].inlocuit.first))
            fout << SAPM[0].de_inlocuit.first << " " << SAPM[0].de_inlocuit.second << '\n';
        else
            fout << i << " " << tata[i] << '\n';
    }
}

void afisare_3APM()
{
    FOR(j, 1, SAPM.size() - 1)
    {
        fout << "Al "<< j + 2 <<" lea APM: " << '\n';
        fout << "Cost: "<< C + SAPM[j].diferenta << '\n';
        fout << "Muchii: ";
        fout << n - 1 << '\n';

        for(int i = 2; i <= n; ++i)
        {
             if((i == SAPM[j].inlocuit.first && tata[i] == SAPM[j].inlocuit.second)||(i == SAPM[j].inlocuit.second && tata[i] == SAPM[j].inlocuit.first))
                fout << SAPM[j].de_inlocuit.first << " " << SAPM[j].de_inlocuit.second << '\n';
            else
                fout << i << " " << tata[i] << '\n';
        }
    }
    fout.close();
}

bool myfunction (SecondAPM i, SecondAPM j) { return (i.diferenta < j.diferenta); }

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
            mfolosit[ind_muchie[i]] = true;
            C += cost[ind_muchie[i]];
        }

    APM(rad);

    afisare_APM();

    DAPM();

    sort(SAPM.begin(), SAPM.end(), myfunction);

    afisare_DAPM();

    afisare_3APM();

    return 0;
}
