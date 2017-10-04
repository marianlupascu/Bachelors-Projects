#include <bits/stdc++.h>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
#define STARI_Max 100
#define ALFABET_Max 150

using namespace std;

int n;
vector <int> finale;

int start;

struct DFA
{
    int nod;
    int tranz_a = -1, tranz_b = -1;
    bool accept = 0;
    bool srv = true;
}m[STARI_Max];

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
    while(fin >> x >> s >> y)
    {
        n = max(max(n, x), y);
        if(s == 'a')
            m[x].tranz_a = y;
        if(s == 'b')
            m[x].tranz_b = y;
        m[x].nod = x;
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

int indis[STARI_Max][STARI_Max] = {0};

void Tabel_Indistinguishability()
{
    FOR(i, 1, n)
        FOR(j, 0, i - 1)
            if(m[i].accept != m[j].accept)
                indis[i][j] = 1;
    FOR(i, 1, n)
        FOR(j, 0, i - 1)
            if(indis[i][j] == 0)
                if(m[i].tranz_a >= 0 && m[j].tranz_a >= 0 && m[i].tranz_b >= 0 && m[j].tranz_b >= 0)
                    if(indis[m[i].tranz_a][m[j].tranz_a] == 1 || indis[m[i].tranz_b][m[j].tranz_b] == 1)
                        indis[i][j] = 1;
                    else
                        indis[i][j] = 2;
                else
                    indis[i][j] = 1;
}

vector <set <int> > stari;
int pozitie[STARI_Max] = {0};

void Combining_States()
{
    FOR(i, 1, n)
        FOR(j, 0, i - 1)
            indis[j][i] = indis[i][j];

    int viz[STARI_Max] = {0};

    FOR(i, 0, n)
    {
        if(!viz[i])
        {
            int ok = 0;
            for(int j = 0; j <= n && !ok; j++)
                if(indis[i][j] == 2)
                    ok = 1;
            if(ok)
            {
                set <int> aux;
                aux.insert(i);
                viz[i] = 1;
                FOR(j, 0, n)
                    if(indis[i][j] == 2)
                    {
                        aux.insert(j);
                        viz[j] = 1;
                    }
                stari.push_back(aux);
            }
            else
            {
                set <int> aux;
                aux.insert(i);
                stari.push_back(aux);
            }
        }
    }
    for(int i = 0 ; i < stari.size(); i++)
    {
        for (std::set<int>::iterator it=stari[i].begin(); it!=stari[i].end(); ++it)
            pozitie[*it] = i;
    }
}

DFA nou[STARI_Max];

void Det_Tranzitions()
{
    for(int i = 0 ; i < stari.size(); i++)
    {
        std::set<int>::iterator it=stari[i].begin();
        nou[i].nod = i;
        if(m[*it].tranz_a >= 0)
            nou[i].tranz_a = pozitie[m[*it].tranz_a];
        else
            nou[i].tranz_a = -1;
        if(m[*it].tranz_b >= 0)
            nou[i].tranz_b = pozitie[m[*it].tranz_b];
        else
            nou[i].tranz_b = -1;
        nou[i].accept = m[*it].accept;
    }
}

int graf[STARI_Max][STARI_Max];
int viz[STARI_Max];

int DFS1(int nod)
{
    if(nou[nod].accept)
        return 1;
    for(int i = 0 ; i < stari.size(); i++)
        if(graf[nod][i])
            return DFS1(i);
    return 0;
}

void Dead_End_States()
{
    for(int i = 0 ; i < stari.size(); i++)
    {
        if(nou[i].tranz_a >= 0)
            graf[i][nou[i].tranz_a] = 1;
        if(nou[i].tranz_b >= 0)
            graf[i][nou[i].tranz_b] = 1;
        graf[i][i] = 0;
    }
//    FOR(i, 0, stari.size() - 1)
//    {
//        FOR(j, 0, stari.size() - 1)
//            cout<<graf[i][j]<<" ";
//        cout<<'\n';
//    }
    for(int i = 0 ; i < stari.size(); i++)
        if(!DFS1(i))
            nou[i].srv = false;

}

void DFS2(int nod)
{
    viz[nod] = 1;
    for(int i = 0 ; i < stari.size(); i++)
        if(graf[nod][i])
            DFS2(i);
}

void Unreachable_States()
{
    DFS2(start);
//    for(int i = 0 ; i < stari.size(); i++)
//        cout<<i<<" ";
//    cout<<'\n';
//    for(int i = 0 ; i < stari.size(); i++)
//        cout<<viz[i]<<" ";
    for(int i = 0 ; i < stari.size(); i++)
        if(!viz[i])
            nou[i].srv = false;
}

void afisare()
{
    for(int i = 0 ; i < stari.size(); i++)
        if(nou[i].srv)
        {
            if(nou[nou[i].tranz_a].srv)
                cout<<i<<" a "<<nou[i].tranz_a<<'\n';
            if(nou[nou[i].tranz_b].srv)
                cout<<i<<" b "<<nou[i].tranz_b<<'\n';
        }
}

int main()
{
    citire();

    Tabel_Indistinguishability();

    Combining_States();

    Det_Tranzitions();

    Dead_End_States();

    Unreachable_States();

    afisare();

//    FOR(i, 0, n)
//    {
//        FOR(j, 0, n)
//            cout<<indis[i][j]<<" ";
//        cout<<'\n';
//
//    }
//
//    for(int i = 0 ; i < stari.size(); i++)
//    {
//        for (std::set<int>::iterator it=stari[i].begin(); it!=stari[i].end(); ++it)
//            cout<<*it<<" ";
//        cout<<'\n';
//    }
//    FOR(i, 0, n)
//        cout<<pozitie[i]<<" ";
//    cout<<'\n'<<'\n';
//
//    for(int i = 0 ; i < stari.size(); i++)
//    {
//        cout<<i<<" : ";
//        cout<<nou[i].tranz_a<<"  "<<nou[i].tranz_b<<"  "<<nou[i].accept<<'\n';
//    }

    return 0;
}
