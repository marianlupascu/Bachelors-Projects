#include <bits/stdc++.h>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
#define STARI_Max 100
#define ALFABET_Max 150

using namespace std;

int n;
vector <int> finale;
struct NFA
{
    set <int> tranz_a;
    set <int> tranz_b;
    bool accept = 0;
} m[STARI_Max];

int start;

struct DFA
{
    set <int> stare;
    set <int> tranz_a;
    set <int> tranz_b;
    bool accept = 0;
};
vector <DFA> d;

struct DFA2
{
    int stare = -1;
    int tranz_a = -1;
    int tranz_b = -1;
    bool accept = 0;
};
DFA2 d2[STARI_Max];

void citire()
{
    ifstream fin("date.in");
    char stari_finale[STARI_Max];
    fin.getline(stari_finale, STARI_Max);
    int len_stari_finale = strlen(stari_finale);
    int start = 0;
    FOR(i, 0, len_stari_finale)
    {
        if(stari_finale[i] == ' ' || stari_finale[i] == '\0')
        {
            char aux[STARI_Max];
            strncpy(aux, stari_finale + start, i - start);
            aux[i - start] = '\0';
            start = i + 1;
            int numar;
            sscanf(aux, "%d", &numar);
            finale.push_back(numar);
        }
    }
    int x, y;
    char s;
    int viz[CHAR_MAX] = {0};
    while(fin >> x >> s >> y)
    {
        n = max(max(n, x), y);
        if(s == 'a')
            m[x].tranz_a.insert(y);
        if(s == 'b')
            m[x].tranz_b.insert(y);
    }
    fin.close();
    cout<<"Starea initiala este     : ";
    int aux, ok;
    char aj[20];
    do {
        ok = 1;
        cin >> aj;
        FOR(i, 0, strlen(aj) - 1)
        {
            if(!isdigit(aj[i]))
            {
                ok = 0;
                break;
            }
        }
        if(!ok)
            cout<<"Numar invalid. \nDati alt numar           :";
    } while(!ok);
    sscanf(aj, "%d", &start);
    for(int i = 0; i < finale.size(); i++)
        m[finale[i]].accept = 1;
}

void tipar(int k, int n, int c, int aux[])
{
//    FOR(i, 0, c)
//        cout<<aux[c]<<" ";
//    cout<<'\n';
    set <int> S(aux, aux + c + 1);
    DFA hp;
    for (std::set<int>::iterator it=S.begin(); it!=S.end(); ++it)
        for (std::set<int>::iterator it2=m[*it].tranz_a.begin(); it2!=m[*it].tranz_a.end(); ++it2)
            hp.tranz_a.insert(*it2);
    for (std::set<int>::iterator it=S.begin(); it!=S.end(); ++it)
        for (std::set<int>::iterator it2=m[*it].tranz_b.begin(); it2!=m[*it].tranz_b.end(); ++it2)
            hp.tranz_b.insert(*it2);
    for (std::set<int>::iterator it=S.begin(); it!=S.end(); ++it)
        if(m[*it].accept == 1)
            { hp.accept = 1; break; }
    hp.stare = S;
    d.push_back(hp);
}

int valid(int k, int aux[])
{
    if(k==0)
        return 1;
    else
        if(aux[k]>aux[k-1])
            return 1;
    return 0;
}

void back(int k, int n, int c, int aux[])
{
    int i;
    if(k==c+1)tipar(k, n, c, aux);
    else
    for(i=0;i<=n;i++)
    {
        aux[k]=i;
        if(valid(k, aux)) back(k+1, n, c, aux);
    }
}

void convert()
{
    for(int i = 0; i < d.size(); i++)
        if(d[i].accept)
            d2[i].accept = 1;
    for(int i = 0; i < d.size(); i++)
    {
        for(int j = 0; j < d.size(); j++)
        {
            if(d[j].tranz_a == d[i].stare)
                d2[j].tranz_a = i;
            if(d[j].tranz_b == d[i].stare)
                d2[j].tranz_b = i;
        }
        d2[i].stare = i;
    }
}

void afisare()
{
    for(int i = 0 ; i < d.size(); i++)
    {
        if(d2[i].tranz_a >= 0)
            cout<<d2[i].stare<<" a "<< d2[i].tranz_a<<'\n';
        if(d2[i].tranz_b >= 0)
            cout<<d2[i].stare<<" b "<< d2[i].tranz_b<<'\n';
    }
    cout<<'\n';
    for(int i = 0 ; i < d.size(); i++)
        if(d2[i].accept)
            cout<<d2[i].stare<<"  ";
}

int main()
{
    citire();

    int aux[STARI_Max] = {0};
    FOR(i, 0, n)
        back(0, n, i, aux);

    convert();

    afisare();

    return 0;
}
