#include <bits/stdc++.h>

using namespace std;

const int DIMMAX = 1005;

int N, M, C[DIMMAX][DIMMAX], tata[DIMMAX];
vector < int > v;
int flux;
vector < int > G[DIMMAX];

void citire()
{
    ifstream fin ("maxflow.in");
    fin >> N >>  M;
    for (int i = 1; i <= M; i++)
    {
        int  x, y, c;
        fin >> x >> y >> c;
        G[x].push_back(y);
        G[y].push_back(x);
        if (y == N)
            v.push_back(x);
        C[x][y] = c;
    }
    fin.close();
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

int main()
{
    citire();

    ofstream fout ("maxflow.out");

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
    fout << flux;

    fout.close();

    return 0;
}
