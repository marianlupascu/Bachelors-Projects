#include <bits/stdc++.h>
#define DIMMAX 100005
#define LOGDIMMAX 20
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

int Rmq[LOGDIMMAX][DIMMAX];
int N,M;

ifstream f("lca.in");
ofstream g("lca.out");

vector<int> dad[DIMMAX];
vector<int> euler;
vector<int> lev_euler;

void citire()
{
    f>>N>>M;

    dad[0].push_back(1);

    for(int i=2;i<=N;++i)
    {
        int nod;
        f>>nod;
        dad[nod].push_back(i);
    }
}

int len=-1;
int aparitie[DIMMAX*4];

void parcurgere_euler(int nod, int nivel)
{
    len++;
    euler.push_back(nod);
    lev_euler.push_back(nivel);
    aparitie[nod] = len;

    for(int i = 0 ; i < dad[nod].size() ; ++i)
    {
        parcurgere_euler(dad[nod][i], nivel+1);

        len++;
        euler.push_back( nod);
        lev_euler.push_back(nivel);
    }
}

int Lg[DIMMAX];

void rmq()
{
//in Rmq[i][j] va fi nodul de nivel minim dintre pozitiile (j, j + 2^i - 1) din reprezentarea Euler a arborelui
    for(int i = 2; i <= len; ++i)
        Lg[i] = Lg[i >> 1] + 1;
    for(int i = 1; i <= len; ++i)
        Rmq[0][i] = i;

    for(int i = 1; (1 << i) < len; ++i)
        for(int j = 1; j <= len - (1 << i); ++j)
        {
            int l = 1 << (i - 1);

            Rmq[i][j] = Rmq[i-1][j];
            if(lev_euler[Rmq[i-1][j + l]] < lev_euler[Rmq[i][j]])
                Rmq[i][j] = Rmq[i-1][j + l];
        }
}

int lca(int x, int y)
{
//LCA-ul nodurilor x si y va fi nodul cu nivel minim din secventa (aparitie[x], aparitie[y]) din reprezentarea Euler a arborelui
    int lungime, sol;
    int a = aparitie[x], b = aparitie[y];

    if(a > b) { int aux = a; a = b ; b = aux; }

    lungime = Lg[b - a + 1];
    sol = Rmq[lungime][a];

    if(lev_euler[sol] > lev_euler[Rmq[lungime][b + 1 - (1 << lungime)]])
        sol = Rmq[lungime][b + 1 - (1 << lungime)];
    return euler[sol];
}

int main()
{
    citire();

    parcurgere_euler(1,0);

    rmq();

    FOR(i,1,M)
    {
        int x,y;
        f>>x>>y;
        g<<lca(x,y)<<'\n';
    }

    f.close();
    g.close();
    return 0;
}

