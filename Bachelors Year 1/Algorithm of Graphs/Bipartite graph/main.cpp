//Se citesc din fişierul graf.in următoarele informaţi despre un graf neorientat 
//(neponderat): numărul de vârfuri n, numărul de muchii m şi lista muchiilor 
//(o muchie fiind dată prin extremităţile sale). Să se verifice dacă graful este
//sau nu bipartit. În caz afirmativ să se afișeze o bipartiție și să se studieze
//dacă graful este bipartit complet. În cazul în care graful nu este bipartit, 
//să se afișeze un ciclu elementar impar al acestuia. O(n+m)

#include <bits/stdc++.h>
#define DIMMAX 1000
#define FOR(i,a,b) for(int i = a; i <= b; i++)

using namespace std;

vector <int> g[DIMMAX];
int n, m;
int culoare[DIMMAX];
int poz1, poz2;

void citire() //O(m)
{
    ifstream fin("grafpond.in");
    fin >> n >> m;
    int a, b;
    FOR(i,1,m)
    {
        fin>>a>>b;
        g[a].push_back(b);
        g[b].push_back(a);
    }
    fin.close();
}

int tata[DIMMAX];
int BFS(int start) //O(m+n)
{
    int viz[n+1]={0};
    int nod;
    queue <int> c;
    c.push(start);
    viz[start] = 1;
    culoare[start] = 1;
    while(!c.empty())
    {
        nod=c.front();
        c.pop();
        for(int i = 0; i < g[nod].size(); i++)
        {
            if(!viz[g[nod][i]])
            {
                c.push(g[nod][i]);
                culoare[g[nod][i]] = !culoare[nod];
                viz[g[nod][i]] = 1;
                tata[g[nod][i]] = nod;

            }
            else
            {
                if(culoare[g[nod][i]] == culoare[nod])
                {
                    poz1 = g[nod][i];
                    poz2 = nod;
                    return 0;
                }
            }
        }
    }
    return 1;
}

int main()
{
    citire();

    if(BFS(1))
    {
        cout<<"Partitia 1: \n";
        FOR(i, 1, n)
            if(culoare[i])
                cout<<setw(3)<<i;
        cout<<'\n';
        cout<<"Partitia 2: \n";
        FOR(i, 1, n)
            if(!culoare[i])
                cout<<setw(3)<<i;
    } //O(n)
    else
    {
        cout<<"Ciclu elementar impar :";
        vector <int> desc1;
        while(poz1)
        {
            desc1.push_back(poz1);
            poz1 = tata[poz1];
        }
        vector <int> desc2;
        while(poz2)
        {
            desc2.push_back(poz2);
            poz2 = tata[poz2];
        }
        while(desc1[desc1.size() - 1] == desc2[desc2.size() - 1] && desc1[desc1.size() - 2] == desc2[desc2.size() - 2])
        {
            desc1.pop_back();
            desc2.pop_back();
        }
        for(int i = desc1.size() - 1 ; i >= 0; i--)
            cout<<desc1[i]<<"  ";
        for(int i = 0; i < desc2.size(); i++)
            cout<<desc2[i]<<"  ";
    } //O(n)

    cout<<'\n';
    FOR(i, 1, n)
    cout<<setw(4)<<i;
    cout<<'\n';
    FOR(i, 1, n)
    cout<<setw(4)<<culoare[i];

    return 0;
}
