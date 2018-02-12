//În cadrul unui proiect trebuie realizate n activități, numerotate 
//1,…,n. Activitățile nu se pot desfășura în orice ordine, ci sunt 
//activități care nu pot începe decât după terminarea altora. Date 
//m perechi de activități (a, b) cu semnificația că activitatea 
//trebuie să se desfășoare înainte de activitatea b, să se testeze 
//dacă proiectul este realizabil, adică nu există dependențe circulare
//între activitățile sale. În cazul în care proiectul nu se poate 
//realiza să se afișeze o listă de activități între care există 
//dependențe circulare.
//Datele de intrare: 
//Pe prima linie a fișierului „graf.in” se afla valorile n și m separate
//printr-un spațiu. Pe fiecare dintre următoarele m linii sunt două
//numere a și b cu semnificația din enunț
//Date de ieșire:
//Fișierul ”graf.out” va conține o listă de activități între care 
//există dependențe circulare, separate prin spațiu, dacă astfel de
//activități există sau mesajul REALIZABIL altfel.

#include <bits/stdc++.h>
#define DIMMAX 1000
#define FOR(i,a,b) for(int i = a; i <= b; i++)

using namespace std;

vector <int> g[DIMMAX];
int x[DIMMAX];
int n, m, ok=1;

void citire()
{
    ifstream fin("graf.in");
    fin >> n >> m;
    int a, b;
    FOR(i,1,m)
    {
        fin>>a>>b;
        g[a].push_back(b);
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
    ok = 0;
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
        if(ok)
        solve(k, 2);
    }

    if(ok)
        fout<<"REALIZABIL";


    fout.close();

    return 0;
}
