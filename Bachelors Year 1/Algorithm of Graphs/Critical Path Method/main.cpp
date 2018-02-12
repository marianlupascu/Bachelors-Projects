//Se citesc din fișerul activitati.in următoarele informații despre 
//activitățile care trebuie să se desfășoare în cadrul unui proiect:
//- n – numărul de activități (activitățile sunt numerotate 1,…, n)
//- d1, d2, …., dn durata fiecărei activități
//- m – număr natural
//- m perechi (i, j) cu semnificația: activitatea i trebuie să se 
//încheie înainte să înceapă j
//Activitățile se pot desfășura și în paralel.
//Să se determine timpul minim de finalizare a proiectului, știind 
//că acesta începe la ora 0 (echivalent – să se determine durata 
//proiectului) și o succesiune (critică) de activități care determină 
//durata proiectului (un drum critic – v. curs) O(m + n).
//Să se afișeze pentru fiecare activitate un interval posibil de desfășurare 
//(!știind că activitățile se pot desfășura în paralel) O(m + n).

#include<bits/stdc++.h>
#define INFINIT INT_MAX/2

const int DIMMAX = 1000;

using namespace std;

typedef pair < int, int > iPair;
int cost[DIMMAX];

class Graf
{
private:
    int V;
    list< pair < int, int > > *adj;
public:
    vector <int> deg_minus;
    vector <int> deg_plus;

public:
    Graf( int V );
    void AdaugaMuchie( int, int, int );
    std::vector<int> TopSort( );
    void afisare( );
    void Drum(int);
};

Graf::Graf( int V )
{
    this -> V = V;
    adj = new list <iPair> [V];
    for(int i = 0; i <= V; i++)
    {
        deg_minus.push_back(0);
        deg_plus.push_back(0);
    }

}

void Graf::AdaugaMuchie( int a, int b, int c )
{
    adj[a].push_back( make_pair( b, c ) );
    //adj[b].push_back( make_pair( a, c ) );
    deg_minus[b]++;
    deg_plus[a]++;
}

std::vector<int> Graf::TopSort( )
{
    std::vector <int> topologic;
    queue <int> C;

    C.push(0);

    while(!C.empty())
    {
        int u = C.front();
        cout<<u<<"  ";
        C.pop();
        topologic.push_back(u);
        list < pair<int, int> >::iterator i;
        for (i = adj[u].begin(); i != adj[u].end(); ++i)
        {
            int v = (*i).first;
            deg_minus[v]--;
            if(deg_minus[v]==0)
                C.push(v);
        }
    }
    return topologic;
}

void Graf::afisare( )
{
    ofstream out( "activitati.out" );
    for (int u = 0; u < V; ++u)
    {
        list < pair<int, int> >::iterator i;
        for (i = adj[u].begin(); i != adj[u].end(); ++i)
        {
            int v = (*i).first;
            int lungime = (*i).second;
            out<<u<<" "<<v<<"    "<<lungime<<'\n';
        }
    }
    out.close( );
}

void Graf::Drum( int src )
{
    vector <int> dist(V, -INFINIT);
    vector <int> tata(V, 0);
    dist[src] = 0;

    vector <int> SortTop = TopSort();

    for(int k = 0; k < SortTop.size(); k++)
    {
        int u = SortTop[k];

        list < pair<int, int> >::iterator i;
        for (i = adj[u].begin(); i != adj[u].end(); ++i)
        {
            int v = (*i).first;
            int lungime = (*i).second;

            if (dist[v] < dist[u] + lungime)
            {
                dist[v] = dist[u] + lungime;
                tata[v] = u;
            }
        }
    }

    cout<<'\n';
    for (int i = 0; i < V; ++i)
        cout << setw(4) << i;

    cout<<'\n';
    for (int i = 0; i < V; ++i)
        cout << setw(4) << dist [i];

    cout<<'\n';
    for (int i = 0; i < V; ++i)
        cout << setw(4) << tata [i];

    ofstream fout("activitati.out");
    fout<<"Timp minim "<<dist[V-1]<<'\n';

    fout<<"Activitati critice: ";
    int i = tata[V-1];
    while(i)
    {
        fout<<i<<" ";
        i = tata[i];
    }
    fout<<'\n';
    for(i = 1; i<V-1; i++)
        fout<<i<<" : "<<dist[i]<<" - "<<dist[i]+cost[i]<<'\n';

    fout.close();
}

void citire()
{
    ifstream fin( "activitati.in" );
    int V, E, a, b, c;
    fin >> V;
    Graf g( V + 2 );
    for(int i = 1; i <= V; i++)
        fin>>cost[i];
    fin>>E;
    for(int i = 1; i <= E; i++)
    {
        fin >> a >> b;
        c = cost[a];
        g.AdaugaMuchie( a, b, c );
    }

    for(int i = 1; i <= V; i++)
        if(!g.deg_minus[i])
            g.AdaugaMuchie(0, i, 0);
    for(int i = 1; i <= V; i++)
        if(!g.deg_plus[i])
            g.AdaugaMuchie(i, V+1, cost[i]);

    g.Drum(0);

    fin.close( );
}

int main( )
{
    citire( );

    return 0;
}
