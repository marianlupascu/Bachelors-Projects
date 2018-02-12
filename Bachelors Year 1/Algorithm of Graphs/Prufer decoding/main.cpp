#include <bits/stdc++.h>
#define DIMMAX 1000
#define FOR(i, a, b) for(int i = a; i <= b; i++)
#define INFINIT INT_MAX

using namespace std;

int n, m;
int tata[DIMMAX];
int aparitie[DIMMAX];
queue <int> cod;
int len;

void citire()
{
    ifstream fin("graf.in");

    int x;
    while(fin >> x)
    {
         cod.push(x);
         aparitie[x]++;
    }
    len = cod.size();
    n = len + 2;

    fin.close();
}

void decod_prufer(int i)
{
        if(aparitie[i] == 0)
        {
            tata[i] = cod.front();
            cod.pop();
            aparitie[i] = INFINIT;
            aparitie[tata[i]]--;
            if(aparitie[tata[i]] == 0 && i > tata[i])
                decod_prufer(tata[i]);
        }
        return;
}

void afisare()
{
    FOR(i,1,n-1)
    {
        cout<<tata[i]<<" "<<i<<'\n';
    }
}

int main()
{
    citire();

    FOR(i, 1, n)
        decod_prufer(i);

    for(int i = 1; i <= n; i++)
        if(!tata[i])
           {tata[i] = n; break;}

    afisare();

    return 0;
}
