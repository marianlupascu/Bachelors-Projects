#include <bits/stdc++.h>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
#define STARI_Max 1000
#define ALFABET_Max 200
#define DIMMAX 10000000

using namespace std;

vector <int> finale;
int m[STARI_Max][ALFABET_Max];
int start;
char cuvant[DIMMAX];

void init()
{
    FOR(i, 0, STARI_Max - 1)
        FOR(j, 0, ALFABET_Max - 1)
            m[i][j] = -1;
}

void citire()
{
    ifstream fin("DFA.in");
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
    while(fin >> x >> s >> y)
    {
        m[x][(int)s] = y;
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
    cout<<"Cuvantul de analizat este: ";
    cin >> cuvant;
}

int evolutie()
{
    int len = strlen(cuvant);
    int nod_curent = start;
    FOR(i, 0, len - 1)
    {
        nod_curent = m[nod_curent][(int)cuvant[i]];
        if(nod_curent < 0)
            return 0;
    }
    for(int i = 0; i < finale.size(); i++)
        if(nod_curent == finale[i])
            return 1;
    return 0;
}

int main()
{
    init();
    citire();
    if(evolutie())
        cout<<"DA";
    else
        cout<<"NU";
    return 0;
}
