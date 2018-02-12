//Se dă o rețea cu n>2 noduri numerotate 1, 2, …, n prin numărul de noduri n și perechile de noduri
//între care există legături directe prin care se pot trimite mesaje. Printr-o legătură directă pot
//comunica în ambele sensuri. Între oricare două noduri ale rețelei se pot trimite mesaje direct sau
//prin puncte intermediare (rețeaua este conexă).
//O legătură directă în rețea este considerată critică dacă după defectarea sa există cel puțin două
//noduri ale rețelei între care nu se mai pot trimite mesaje. Să se determine toate legăturile critice ale
//rețelei. Dacă nu există astfel de legături se va afișa mesajul “retea 2 muchie-conexa” O(n+m)

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

void DFS(int i)
{
    viz[i] = 1;
    ciclu_min[i] = niv[i];
    for(int j = 0; j < g[i].size(); j++)
    {
        if(viz[g[i][j]]==0)
        {
            niv[g[i][j]] = niv[i]+1;
            DFS(g[i][j]);
            ciclu_min[i]=min(ciclu_min[i], ciclu_min[g[i][j]]);
            if (ciclu_min[g[i][j]] > niv[i])
                cout<<i<<" "<<g[i][j]<<'\n';
        }
        else
            if(niv[g[i][j]] <= niv[i] - 2) //deoarece nu exista cicluri cu <3 componente
                ciclu_min[i] = min(ciclu_min[i], ciclu_min[g[i][j]]);
    }
}

int main()
{
    citire();

    niv[1] = 1;

    DFS(1);

    FOR(i,1,n)
    cout<<i<<" ";
    cout<<'\n';
    FOR(i,1,n)
    cout<<niv[i]<<" ";
    cout<<'\n';
    FOR(i,1,n)
    cout<<ciclu_min[i]<<" ";
    cout<<'\n';

    return 0;
}
