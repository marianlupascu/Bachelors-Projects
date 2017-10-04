#include <bits/stdc++.h>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
#define STARI_Max 100
#define ALFABET_Max 150

using namespace std;

vector <int> finale;
vector <char> simboluri;
vector <int> m[STARI_Max][ALFABET_Max];
vector <int> fin[STARI_Max][ALFABET_Max];
vector <int> inchidere[ALFABET_Max];
vector <int> minimizat;
int start;
int nod_max;

void citire()
{
    ifstream fin("date.in");
    char stari_finale[STARI_Max];
    fin.getline(stari_finale, STARI_Max);
    int len_stari_finale = strlen(stari_finale);
    int start = 0;
    FOR(i, 0, len_stari_finale)
    {
        if(stari_finale[i]==' ' || stari_finale[i]=='\0')
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
        if(x > nod_max)
            nod_max = x;
        if(y > nod_max)
            nod_max = y;
        if(s == '_')
        {
            m[x][1].push_back(y);
            if(inchidere[x].empty())
                inchidere[x].push_back(x);
            inchidere[x].push_back(y);
        }
        else
        {
            m[x][(int)s].push_back(y);
            if(!viz[(int)s])
                simboluri.push_back(s);
        }

    }
    FOR(i, 0, nod_max)
        if(inchidere[i].empty())
            inchidere[i].push_back(i);
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
}

void actualizare_lambda_inchidere()//datorata tranzitivitatii
{
    FOR(i, 0, nod_max)
    {
        int aux[STARI_Max] = {0};
        int viz[STARI_Max] = {0};
        viz[i] = 1;
        queue <int> Q;
        for(int j = 0; j < inchidere[i].size(); j++)
            Q.push(inchidere[i][j]);
        while(!Q.empty())
        {
            if(!viz[Q.front()])
            {
                for(int j = 0; j < inchidere[Q.front()].size(); j++)
                    Q.push(inchidere[Q.front()][j]);
                viz[Q.front()] = 1;
            }
            else
            {
                aux[Q.front()]++;
                Q.pop();
            }
        }
        inchidere[i].clear();
        FOR(j, 0, nod_max)
            if(aux[j])
                inchidere[i].push_back(j);
    }
}

vector <int> tranzitie[STARI_Max][ALFABET_Max];

void functie_tranzitie()
{
    for(int k = 0; k < simboluri.size(); k++)
    {
        FOR(i, 0, nod_max)
        {
            for(int j = 0; j < inchidere[i].size(); j++)
            {
                if(!m[inchidere[i][j]][(int)simboluri[k]].empty())
                    for(int l = 0; l < m[inchidere[i][j]][(int)simboluri[k]].size(); l++)
                        tranzitie[i][(int)simboluri[k]].push_back(m[inchidere[i][j]][(int)simboluri[k]][l]);
            }
        }
    }
}

int gasire(int o)
{
    for(int i = 0; i < minimizat.size(); i++)
        if(minimizat[i]==o)
        return 1;
    return 0;
}

void functie_tranzitie_actualizare()
{
    for(int k = 0; k < simboluri.size(); k++)
    {
        FOR(i, 0, nod_max)
        {
            for(int j = 0; j < tranzitie[i][(int)simboluri[k]].size(); j++)
            {
                if(gasire(tranzitie[i][(int)simboluri[k]][j]))
                {
                    swap(tranzitie[i][(int)simboluri[k]][j], tranzitie[i][(int)simboluri[k]][tranzitie[i][(int)simboluri[k]].size()-1]);
                    tranzitie[i][(int)simboluri[k]].pop_back();
                }
            }
        }
    }
}

void minimizare()
{
    int viz[STARI_Max] = {0};
    FOR(i, 0, nod_max)
    {
        FOR(j, i+1, nod_max)
        {
            int aux = 0;
            for(int k = 0; k < simboluri.size(); k++)
                if(tranzitie[i][simboluri[k]]==tranzitie[j][simboluri[k]])
                    aux++;
            if(aux==simboluri.size() && !viz[j])
            {
                minimizat.push_back(j); //si nefinala.........?????????????????????
                viz[j] = 1;
            }
        }
    }
}

void constructie_NFA()
{
    FOR(i, 0, nod_max)
    {
        for(int  j = 0; j < simboluri.size(); j++)
        {
            int aux[STARI_Max][ALFABET_Max] = {0};
            for(int k = 0; k < tranzitie[i][(int)simboluri[j]].size(); k++)
            {
                //if(!gasire(tranzitie[i][(int)simboluri[j]][k]));
            }
        }




    }
}

int main()
{
    citire();

    actualizare_lambda_inchidere();

    FOR(i, 0, nod_max)
    {
        for(int j = 0; j<inchidere[i].size(); j++)
        cout<<inchidere[i][j]<<" ";
        cout<<'\n';
    }

    functie_tranzitie();

    FOR(i, 0, nod_max)
    {
        cout<<i<<". ";
        for(int j = 0; j<tranzitie[i][(int)'a'].size(); j++)
                cout<<tranzitie[i][(int)'a'][j]<<" ";
        cout<<'\n';
    }
    FOR(i, 0, nod_max)
    {
        cout<<i<<". ";
        for(int j = 0; j<tranzitie[i][(int)'b'].size(); j++)
                cout<<tranzitie[i][(int)'b'][j]<<" ";
        cout<<'\n';
    }

    minimizare();

    for(int i=0;i<minimizat.size();i++)
        cout<<minimizat[i]<<" ";
        cout<<'\n'<<'\n';

    //constructie_NFA();
    functie_tranzitie_actualizare();
    FOR(i, 0, nod_max)
    {
        cout<<i<<". ";
        for(int j = 0; j<tranzitie[i][(int)'a'].size(); j++)
                cout<<tranzitie[i][(int)'a'][j]<<" ";
        cout<<'\n';
    }
    FOR(i, 0, nod_max)
    {
        cout<<i<<". ";
        for(int j = 0; j<tranzitie[i][(int)'b'].size(); j++)
                cout<<tranzitie[i][(int)'b'][j]<<" ";
        cout<<'\n';
    }

    return 0;
}
