//Se citesc din fişierul graf.in următoarele informaţi despre un graf neorientat bipartit 
//conex: numărul de vârfuri n>2, numărul de muchii m şi lista muchiilor (o muchie fiind 
//dată prin extremităţile sale). Să se determine un cuplaj de cardinal maxim în acest 
//graf reducând problema la o problemă de flux maxim şi folosind apoi algoritmul 
//*Ford-Fulkerson. Se vor afişa muchiile cuplajului maxim obţinut (vârfurile sunt 
//numerotate 1..n, dar nu este neapărat ca vârfurile de aceeaşi culoare să fie numerotate 
//consecutiv) O(nm)

#include <bits/stdc++.h>

using namespace std;

const int DIMMAX = 1005;

int N, M, C[DIMMAX][DIMMAX], tata[DIMMAX], S, T, copie[DIMMAX][DIMMAX];
vector < int > v;
int flux;
vector < int > G[DIMMAX];
ofstream fout ("retea.out");

void citire()
{
    ifstream fin ("retea.in");
    fin >> N;
    fin >> M;
    for (int i = 1; i <= M; i++)
    {
        int  x, y;
        fin >> x >> y;
        G[x+1].push_back(y+1);//pun cu unu in plus sa pun nodul de start cu indice 1
        G[y+1].push_back(x+1);
        C[x+1][y+1] = 1;
        copie[x+1][y+1] = 1;
    }
    fin.close();
}

int culoare[DIMMAX];

void partitionare_BF(int start) //O(m+n)
{
    int viz[DIMMAX]={0};
    int nod;
    queue <int> c;
    c.push(start);
    viz[start] = 1;
    culoare[start] = 1;
    while(!c.empty())
    {
        nod = c.front();
        c.pop();
        for(int i = 0; i < G[nod].size(); i++)
            if(!viz[G[nod][i]])
            {
                c.push(G[nod][i]);
                culoare[G[nod][i]] = !culoare[nod];
                viz[G[nod][i]] = 1;

            }
    }
}

void constructie()
{
    S=1;
    T=N+2;
    for (int i = 2; i <= N+1; i++)
        if(culoare[i])
        {
            C[S][i] = 1;
            copie[S][i] = 1;
            G[S].push_back(i);
            G[i].push_back(S);
        }
        else
        {
            C[i][T] = 1;
            copie[i][T] = 1;
            G[T].push_back(i);
            G[i].push_back(T);
            v.push_back(i);
        }
    N+=2;
}

int BFS()
{
    queue < int > Q;
    Q.push(S);

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
    return tata[N-1];
}

void afisare()
{
    for(int i = 2; i < N; i++)
        for(int j = 2; j < N; j++)
            if(copie[i][j] - C[i][j] == 1)
                fout << i-1 << " " << j-1 <<'\n';//afisez cu 1 in minus deoarece am pus initial fiecare nod ca fiind el +1
}

int main()
{
    citire();

    partitionare_BF(2);

    constructie();

    while (BFS())
    {
        for (int j = 0; j < v.size(); j++)
        {
            int x = v[j];
            int w = C[x][N];
            for (int i = x; i != S; i = tata[i])
                w = min(w, C[tata[i]][i]);

            for (int i = x; i != S; i = tata[i])
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
    cout << flux << '\n';

    afisare();

    fout.close();

    return 0;
}
