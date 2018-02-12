//Dat un graf neorientat (nu neapărat conex), să se verifice dacă graful 
//conţine un ciclu elementar (nu este aciclic). În caz afirmativ să se 
//afişeze un astfel de ciclu.

#include <bits/stdc++.h>
#define DIMMAX 1000
#define FOR(i,a,b) for(int i = a; i <= b; i++)

using namespace std;

vector <int> g[DIMMAX];
int x[DIMMAX];
int n, m;

void citire()
{
    ifstream fin("graf.in");
    fin >> n >> m;
    int a, b;
    FOR(i,1,m)
    {
        fin>>a>>b;
        g[a].push_back(b);
        g[b].push_back(a);
    }
    fin.close();
}

ofstream fout("graf.out");
int viz[DIMMAX]={0};

void afisare(int pas)
{
    FOR(i, 1, pas)
        fout<< x[i]<<" ";
    fout<<'\n';
}

void solve(int k, int pas)
{
    for(int i = 0; i < g[x[pas-1]].size(); i++)
    if(!viz[g[x[pas-1]][i]])
    {
        x[pas]=g[x[pas-1]][i];
        viz[g[x[pas-1]][i]]=1;
        if(x[pas]==k && pas>3)
            afisare(pas);
        else
            solve(k, pas + 1);
        viz[g[x[pas-1]][i]]=0;
    }
}

int main()
{
    citire();

    FOR(k, 1, n)
    {
        x[1] = k;
        solve(k, 2);
        fout<<'\n';
    }


    fout.close();

    return 0;
}
