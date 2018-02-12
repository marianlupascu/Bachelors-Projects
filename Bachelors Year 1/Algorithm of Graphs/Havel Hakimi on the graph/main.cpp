//Se citesc din fișierul date.in următoarele informații: un număr natural n urmat de 
//n numere naturale d1, d2, …, dn. Să se verifice dacă există un graf G cu secvența 
//gradelor s(G) = { d1, d2, ... , dn } și, în caz afirmativ, să se afișeze muchiile 
//grafului G. Se vor considera pe rând cazurile în care G este graf neorientat O(n^2)

#include <bits/stdc++.h>
#define DIMMAX 1000
#define DEGMAX 500
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

vector <int> g[DIMMAX];
int n, suma = 0, deg_max = -1;
vector < pair <int, int> > d;

bool myfunction(pair <int, int> i, pair <int, int> j)
{
    return (i.first > j.first);
}

void citire()
{
    ifstream fin("graf.in");

    fin >> n;
    int x;
    FOR(i, 1, n)
    {
        fin>>x;
        suma += x;
        deg_max = max(deg_max, x);
        d.push_back(make_pair(x,i));
    }
    fin.close();
}

void afisare()
{
    FOR(i, 1, n)
    {
        sort(g[i].begin(), g[i].end());
    }
    FOR(i, 1, n)
    {
        //cout<<setw(3)<<i<<": ";
        for(int j=0; j<g[i].size();j++)
            if(g[i][j] > i)
                cout<<g[i][j]<<" "<<i<<'\n';
        //cout<<'\n';
    }
}

int HH()
{
    queue < int > Q[DIMMAX];

    for(int i = 0; i < d.size(); i++)
        Q[d[i].first].push(d[i].second);
    int granita1 =0, granita2 = 0;
//    for(int i = 0; i <= n; i++)
//    {
//        cout<<i<<":";
//        for(;!Q[i].empty(); Q[i].pop())
//            cout<<Q[i].front()<<" ";
//        cout<<'\n';
//    }

    if(suma % 2)
        return 0;
    if(deg_max > n - 1)
        return 0;
    int nod_curent = deg_max;
    FOR(i, 1, n)
    {
        while(Q[nod_curent].empty())
            nod_curent--;
        int nod = Q[nod_curent].front(), aux = 0, deg = nod_curent;
        Q[nod_curent].pop();
        while(aux < deg)
        {
            if(Q[nod_curent].empty() || Q[nod_curent].size() - granita2 == 0)
            {
                nod_curent--;
                granita2 = 0;
            }
            else
            {
                if(!nod_curent)
                    return 0;
                Q[nod_curent-1].push(Q[nod_curent].front());
                granita1++;
                g[nod].push_back(Q[nod_curent].front());
                g[Q[nod_curent].front()].push_back(nod);
                Q[nod_curent].pop();
                aux++;
            }
        }
        granita2 = granita1;
    }
    return 1;
}

int main()
{
    citire();

    if(HH())
    {
        cout<<"DA";
        cout<<'\n';
        afisare();
    }

    else
        cout<<"NU";

    printf("\n");

    return 0;
}
