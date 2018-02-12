//Se citesc din fișierul date.in următoarele informații: un număr natural 
//n urmat de n numere naturale d1, d2, …, dn. Să se verifice dacă există 
//un graf G cu secvența gradelor s(G) = { d1, d2, ... , dn } și, în caz 
//afirmativ, să se afișeze muchiile grafului G. Se vor considera pe rând 
//cazurile în care G este arbore O(n)

#include <bits/stdc++.h>
#define DIMMAX 1000
#define DEGMAX 500
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

vector <int> g[DIMMAX];
int n;
vector < pair <int, int> > d;

stack < pair <int, int> > s1, sn;

int citire()
{
    int sum = 0;
    ifstream fin("graf.in");

    fin >> n;
    int x;
    FOR(i, 1, n)
    {
        fin>>x;
        sum += x;
        d.push_back(make_pair(x,i));
        if(x == 0)
            return 0;
        else
            if (x == 1)
                s1.push(make_pair(x,i));
            else
                sn.push(make_pair(x,i));
    }

    fin.close();
    if(sum == 2*(n-1))
        return 1;
    else
        return 0;
}

void afisare()
{
    FOR(i, 1, n)
    {
        sort(g[i].begin(), g[i].end());
    }
    FOR(i, 1, n)
    {
        cout<<setw(3)<<i<<": ";
        for(int j=0; j<g[i].size();j++)
            cout<<g[i][j]<<" ";
        cout<<'\n';
    }
}

int HH()
{
    while(!s1.empty() && !sn.empty())
    {
        g[s1.top().second].push_back(sn.top().second);
        g[sn.top().second].push_back(s1.top().second);//cout<<sn.top().second << "  "<<s1.top().second<<'\n';
        s1.pop();
        pair <int, int> aux = sn.top();
        sn.pop();
        aux.first--;
        if(aux.first == 1)
            s1.push(aux);
        else
            sn.push(aux);
    }
    if(!sn.empty())
        return 0;
    if(s1.size() > 2 || s1.size() == 1)
        return 0;
    if(s1.size() == 2)
    {
        pair <int, int> aux = s1.top();
        s1.pop();
        pair <int, int> aux2 = s1.top();
        g[aux.second].push_back(aux2.second);
        g[aux2.second].push_back(aux.second);
    }
    return 1;
}

int main()
{
    if(!citire())
    {
        cout<<"NU";
        return 0;
    }

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
