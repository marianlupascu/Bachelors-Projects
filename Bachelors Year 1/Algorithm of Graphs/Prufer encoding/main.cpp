#include <bits/stdc++.h>
#define DIMMAX 1000
#define FOR(i, a, b) for(int i = a; i <= b; i++)
#define INFINIT INT_MAX

using namespace std;

int n, m;
vector <int> g[DIMMAX];
pair <int, int> tata[DIMMAX];
vector <int> cod;
int len = 1;

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
int niv[DIMMAX];

void DFS(int i)
{
    viz[i] = 1;
    for(int j = 0; j < g[i].size(); j++)
    {
        if(viz[g[i][j]]==0 && g[i][j] >0)
        {
            niv[g[i][j]] = niv[i]+1;
            tata[g[i][j]].first = i;
                tata[i].second++;
            DFS(g[i][j]);
        }
        else
            if(niv[g[i][j]] <= niv[i] - 2)
            {
                for(int k = 0; k < g[g[i][j]].size(); k++)
                    if(g[g[i][j]][k] == i)
                        g[g[i][j]][k] = -1;
                g[i][j] = -1;
            }
    }
}

void prufer(int i)
{
    if(tata[i].second == 0 && cod.size()< n-2)
    {
        cod.push_back(tata[i].first);
        tata[tata[i].first].second--;
        tata[i].second = INFINIT;
        if(i > tata[i].first && tata[tata[i].first].second == 0)
            prufer(tata[i].first);
    }
    return;
}

int main()
{
    citire();

    int radacina = n;
    tata[radacina].first = 0;
    niv[radacina] = 1;

    DFS(radacina);

    for(int i = 1; i <= n && cod.size()< n-2; i++)
        prufer(i);


    for(int i=0;i<cod.size();i++)
    cout<<cod[i]<<" ";
    cout<<'\n';


    return 0;
}
