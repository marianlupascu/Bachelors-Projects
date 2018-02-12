//Se consideră o reţea de transport (care verifică ipotezele din curs) şi un flux în această reţea. 
//Se citesc din fişierul retea.in următoarele informaţi despre această reţea: numărul de vârfuri n 
//(numerotate 1…n), două vârfuri s şi t reprezentând sursa şi destinaţia, numărul de arce m şi pe 
//câte o linie informaţii despre fiecare arc: extremitatea iniţială, extremitatea finală, 
//capacitatea arcului şi fluxul deja trimis pe arc.
//a) Să se verifice dacă fluxul dat este corect (respectă constrângerile de mărginire şi conservare) 
//şi să se afişeze un mesaj corespunzător. (2p)
//b) Să se determine un flux maxim în reţea pornind de la acest flux, prin revizuiri succesive ale 
//fluxului pe s-t lanţuri nesaturate (Algoritmul Ford - Fulkerson va porni de la fluxul dat, nu de 
//la fluxul vid). Se vor afişa
//- Valoarea fluxului obţinut şi fluxul pe fiecare arc
//- Capacitatea minimă a unei tăieturi în reţea şi arcele directe ale unei tăieturi 
//minime O(mL), L= capacitatea minimă a unei tăieturi / O(nm2)

#include <bits/stdc++.h>

using namespace std;

const int DIMMAX = 1005;

int N, M, C[DIMMAX][DIMMAX], F[DIMMAX][DIMMAX], tata[DIMMAX], S, T, copie[DIMMAX][DIMMAX];
vector < int > v;
int flux;
vector < int > G[DIMMAX], GO[DIMMAX];
ofstream fout ("retea.out");

void citire()
{
    ifstream fin ("retea.in");
    fin >> N;
    fin >> S >> T;
    fin >> M;
    for (int i = 1; i <= M; i++)
    {
        int  x, y, c, f;
        fin >> x >> y >> c >> f;
        GO[x].push_back(y);
        G[x].push_back(y);
        G[y].push_back(x);
        if (y == N)
            v.push_back(x);
        C[x][y] = c;
        copie[x][y] = c;
        F[x][y] = f;
    }
    fin.close();
}

bool viz[DIMMAX] = {false};

bool verificare( int nod )
{
    viz[nod] = 1;
    for (int i = 0; i < G[nod].size(); i++)
    {
        if (!viz[G[nod][i]])
            if (F[nod][G[nod][i]] > C[nod][G[nod][i]])
                return false;
            else
                return verificare( G[nod][i] );
        else
            if (F[nod][G[nod][i]] > C[nod][G[nod][i]])
                return false;
            else;
    }
    return true;
}

int BFS()
{
    queue < int > Q;
    Q.push(1);

    while (!Q.empty())
    {
        int nod = Q.front();
        Q.pop();

        for (int i = 0; i < G[nod].size(); i++)
            if (!tata[G[nod][i]] && C[nod][G[nod][i]] > 0)
            {
                tata[G[nod][i]] = nod;
                Q.push(G[nod][i]);
            }
    }
    return tata[N];
}

void taietura(int nod)
{
    viz[nod] = true;
    for(int i = 0; i < GO[nod].size(); i++)
    {
        if(!viz[GO[nod][i]])
            if(copie[i][GO[nod][i]] - C[i][GO[nod][i]])
                taietura(GO[nod][i]);
            else
                fout << nod << " " << GO[nod][i] << '\n';
    }
}

int main()
{
    citire();

    if (!verificare(S))
    {
        fout << "NU\n";
        return 0;
    }

    fout << "DA\n";

    for(int i = 1; i <= N; i++)
        for(int j = 1; j <= N; j++)
            C[j][i] -= F[i][j];

    while (BFS())
    {
        for (int j = 0; j < v.size(); j++)
        {
            int x = v[j];
            int w = C[x][N];
            for (int i = x; i != 1; i = tata[i])
                w = min(w, C[tata[i]][i]);

            for (int i = x; i != 1; i = tata[i])
            {
                C[tata[i]][i] -= w;
                C[i][tata[i]] += w;
            }
            C[x][N] -= w;
            C[N][x] += w;

            flux += w;
        }
        for (int i = 1; i <= N; i++)
            tata[i] = 0;
    }
    fout << flux << '\n';

    for(int i = 1; i <= N; i++)
    {
        for(int j = 1; j <= N; j++)
        {
            if(copie[i][j])
                fout << i << " " << j << " " << copie[i][j] - C[i][j] <<'\n';
        }
    }

    fout << flux << '\n';

    for(int i = 0; i < DIMMAX; i++)
        viz[i] = false;
    taietura(S);

    fout.close();

    return 0;
}
