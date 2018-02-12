//Se dă o matrice n*m (n,m <= 1000), cu p <= 100 puncte marcate cu 1 
//(restul valorilor din matrice vor fi 0). Distanța dintre 2 puncte 
//ale matricei se măsoară în locații străbătute mergând pe orizontală 
//și pe verticală între cele 2 puncte (distanța Manhattan). Se dă o 
//mulțime M de q puncte din matrice (q <= 1000000). Să se calculeze 
//cât mai eficient pentru fiecare dintre cele q puncte date, care 
//este cea mai apropiată locație marcată cu 1 din matrice.
//Datele de intrare:
//Pe prima linie a fișierului „graf.in” se afla valorile n și m 
//separate printr-un spațiu.
//Următoarele n linii reprezintă matricea cu valori 1 și 0. În 
//final, pe câte o linie a fișierului, se află câte o pereche de 
//numere, reprezentând coordonatele punctelor din M.
//Date de ieșire:
//Fișierul ”graf.out” va conține q = |M| linii; pe fiecare linie i 
//va fi scrisă distanța de la al i-lea punct din M la cel mai apropiat
//element marcat cu 1 în matrice, precum și coordonatele acelui 
//element cu valoarea 1.

#include <bits/stdc++.h>
#define DIMMAX 1000
#define FOR(i,a,b) for(int i = a; i <= b; i++)

using namespace std;

bool g[DIMMAX][DIMMAX] = {0};
int n, m, M;
vector < pair < pair <int, int>, int> > a;

void citire()
{
    ifstream fin("graf.in");
    fin >> n >> m;
    FOR(i,1,n)
    {
        FOR(j,1,m)
        {
            fin >> g[i][j];
        }
    }
    pair < pair <int, int>, int> p;
    pair <int, int> aux;
    while(!fin.eof())
    {
        fin >> aux.first >> aux.second;
        p.first = aux;
        p.second = 0;
        a.push_back(p);
    }
    a.pop_back();
    fin.close();
}

void distanta(pair < pair <int, int>, int> p)
{
    queue < pair < pair <int, int>, int> > c;
    c.push(p);
    int dx[4]={1,-1,0,0};
    int dy[4]={0,0,-1,1};
    pair < pair <int, int>, int> curent, aux2;
    pair <int, int> aux, hp;
    while(!c.empty())
    {
        curent = c.front();
        hp = curent.first;
        if(g[hp.first][hp.second])
        {
            cout<<curent.second<<" ";
            cout<<"["<<hp.first<<", "<<hp.second<<"]"<<'\n';
            return;
        }
        c.pop();
        FOR(i,0,3)
        {
            aux.first = hp.first + dx[i];
            aux.second = hp.second + dy[i];
            aux2.first = aux;
            aux2.second = curent.second + 1;
            if(aux.first >= 1 && aux.first <=n && aux.second >=1 && aux.second <=m)
                c.push(aux2);
        }
    }
}

int main()
{
    citire();

    for(int i = 0; i < a.size(); i++)
    {
        distanta(a[i]);
    }

    return 0;
}
