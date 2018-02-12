//Se citesc din fișierul grafpond.in informații despre un graf neorientat ponderat 
//și de la tastatură un număr k, o listă de k puncte de control ale grafului şi un 
//vârf s. Determinați cel mai apropiat punct de control de vârful s şi afişaţi un 
//lanț minim până la acesta, folosind algoritmul lui Dijkstra (problema B.1. din 
//laboratorul 1 pentru cazul ponderat) - O(m log(n)).

#include<bits/stdc++.h>
#define INFINIT INT_MAX/2

using namespace std;

typedef pair < int, int > iPair;
vector < int > control;

class Graf
{
private:
    int V;
    list< pair < int, int > > *adj;
    int start;

public:
    Graf( int V );
    void AdaugaMuchie( int, int, int );
    void Dijkstra( int ) const;
    inline void set_start( int param ){
        start = param;
    }
    inline int get_start( ){
        return start;
    }
};

Graf::Graf( int V )
{
    this -> V = V;
    adj = new list <iPair> [V];
}

void Graf::AdaugaMuchie( int a, int b, int c )
{
    adj[a].push_back( make_pair( b, c ) );
    adj[b].push_back( make_pair( a, c ) );
}

void Graf::Dijkstra( int src ) const
{
    priority_queue< iPair, vector <iPair> , greater<iPair> > pq;

    vector <int> dist(V, INFINIT);

    pq.push( make_pair( 0, src ) );
    dist[src] = 0;

    while (!pq.empty())
    {
        int u = pq.top().second;
        pq.pop();

        list < pair<int, int> >::iterator i;
        for (i = adj[u].begin(); i != adj[u].end(); ++i)
        {
            int v = (*i).first;
            int lungime = (*i).second;

            if (dist[v] > dist[u] + lungime)
            {
                dist[v] = dist[u] + lungime;
                pq.push( make_pair( dist[v], v ) );
            }
        }
    }

    ofstream out( "date.out" );

    int minim = INFINIT + 1;
    int nod_min;
    for (int i = 0; i < control.size(); ++i)
    {
        if(minim > dist[control[i]])
        {
            minim = dist[control[i]];
            nod_min = control[i];
        }
        if(dist[control[i]] == INFINIT)
            out <<"distanta "<<src<<" - "<<control[i]<< " inaccesibil \n";
        else
            out <<"distanta "<<src<<" - "<<control[i]<<" = "<< dist[control[i]] <<'\n';
    }

    if(minim == INFINIT + 1)
        out<<"Nu se poate ajunge in nici un punct de control\n";
    else
        out<<"Punctul de control cel mai apropiat este "<<nod_min<<'\n';

    out.close( );
}

void citire()
{
    ifstream fin( "date.in" );
    int V, E, K, a, b, c;
    fin >> a;
    fin >> V >> E >> K;
    Graf g( V + 1 );
    g.set_start(a);

    for(int i = 1; i <= K; i++)
    {
        fin >> a;
        control.push_back(a);
    }

    for(int i = 1; i <= E; i++)
    {
        fin >> a >> b >> c;
        g.AdaugaMuchie( a, b, c );
    }
    g.Dijkstra( g.get_start() );
    fin.close( );
}

int main( )
{

    citire( );

    return 0;
}
