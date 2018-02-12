//Se dă o rețea cu n>2 noduri numerotate 1, 2, …, n prin numărul de noduri n și perechile de noduri
//între care există legături directe prin care se pot trimite mesaje. Printr-o legătură directă pot
//comunica în ambele sensuri. Între oricare două noduri ale rețelei se pot trimite mesaje direct sau
//prin puncte intermediare (rețeaua este conexă).
//Să se determine un număr maxim de noduri care determină o subrețea (formată păstrând doar
//legăturile directe între nodurile selectate) fără noduri vulnerabile. Se vor afișa nodurile acestei
//subrețele și legăturile directe dintre ele (în orice ordine). O(n+m)

#include <bits/stdc++.h>
#define DIMMAX 1000
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

int n, m;
vector <int> g[DIMMAX];

void citire()
{
    ifstream fin("graf.in");

    fin >> n >> m;
    int x, y;
    FOR(i, 1, m)
    {
        fin >> x >> y;
        g[x].push_back(y);
        g[y].push_back(x);
    }

    fin.close();
}

int viz[DIMMAX];
int ciclu_min[DIMMAX];
int niv[DIMMAX];
int radacina;
int nr_copii_radacina = 0;
vector <int> vf;

void DFS(int i)
{
    viz[i] = 1;
    ciclu_min[i] = niv[i];
    for(int j = 0; j < g[i].size(); j++)
    {
        if(!viz[g[i][j]])
        {
            if(i == radacina)
                nr_copii_radacina ++;
            niv[g[i][j]] = niv[i]+1;
            DFS(g[i][j]);
            ciclu_min[i]=min(ciclu_min[i], ciclu_min[g[i][j]]);
            if (ciclu_min[g[i][j]] >= niv[i] && i != radacina)
                vf.push_back(i);
        }
        else
            if(niv[g[i][j]] <= niv[i] - 2)
                ciclu_min[i] = min(ciclu_min[i], niv[g[i][j]]);
    }
}

void eliminare_duplicate()
{
    for(int i=0; i<vf.size();i++)
    {
        if(vf[i] == vf[i-1])
            vf[i]=-1;
    }
    for(int i=0; i<vf.size();i++)
    {
        if(vf[i]>0)
            cout<<vf[i]<<'\n';
    }
}

void init_viz()
{
    FOR(i, 0, DIMMAX - 1)
        viz[i] = 0;
}
bool critic[DIMMAX] = {false};
void DFS2(int i)
{
    cout<<i<<"  ";
    viz[i] = 1;
    if(!critic[i])
    for(int j = 0; j < g[i].size(); j++)
        if(!viz[g[i][j]] || critic[g[i][j]])
            DFS2(g[i][j]);
}

void subretea()
{
    init_viz();
    for(int k = 0; k < vf.size(); k++)
        if(vf[k] > 0)
            critic[vf[k]] = true;
    for(int k = 0; k < vf.size(); k++)
        if(vf[k] > 0){cout<<'\n';
            for(int i = 0; i < g[vf[k]].size(); i++)
            {
                if(!viz[g[vf[k]][i]])
                {

                    DFS2(g[vf[k]][i]);
                }

            }
        }
}

int main()
{
    citire();

    radacina = 5;

    niv[radacina] = 0;

    DFS(radacina);

    if(nr_copii_radacina >=2)
        vf.push_back(radacina);

    eliminare_duplicate();

    subretea();

    cout<<'\n';
    FOR(i, 1, n)
        cout<<i<<setw(5);
    cout<<'\n';
    FOR(i, 1, n)
        cout<<niv[i]<<setw(5);
    cout<<'\n';
    FOR(i, 1, n)
        cout<<ciclu_min[i]<<setw(5);

    return 0;
}
