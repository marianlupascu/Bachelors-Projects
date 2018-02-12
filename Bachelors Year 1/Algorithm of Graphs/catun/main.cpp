//Intr-un regat feudal exista mai multe asezari omenesti, numerotate de la 1 la N, 
//intre care sunt construite drumuri de diverse lungimi. Dintre aceste asezari, o 
//parte sunt fortarete, iar restul sunt simple catune. Fiecare fortareata trebuie 
//sa aprovizioneze trupele stationate in ea, deci are nevoie de feude. In calitate 
//de mare sfetnic al monarhului, vi se cere sa indicati feudele aservite fiecarei 
//fortarete, respectiv toate acele catune care se afla mai aproape de fortareata 
//in discutie decat de oricare alta. Daca un catun este la distanta egala de doua 
//fortarete, se va considera ca apartine fortaretei cu numarul de identificare minim.
//Sa se determine pentru fiecare catun carei fortarete apartine.
//Date de Intrare
//In fisierul de intrare catun.in se vor afla numarele N, M, K, indicand, in aceasta 
//ordine, numarul de asezari, numarul de drumuri si numarul de fortarete. Cea de a doua 
//linie a fisierului va contine K numere naturale distincte indicand numerele de ordine 
//ale fortaretelor. Pe urmatoarele M linii, pana la sfarsitul fisierului, se vor gasi 
//triplete de forma (x y z), semnificand faptul ca exista un drum bidirectional intre 
//asezarile x si y de lungime z, exprimata in unitatea de masura pentru lungimi a Evului 
//Mediu.
//Date de Iesire
//Fisierul de iesire catun.out va contine o singura linie pe care se afla N numere naturale, 
//al i-lea numar fiind 0, daca asezarea a i-a este o fortareata sau este un catun de la care 
//nu se poate ajunge la nici o fortareata din cele K, sau numarul fortaretei de care se leaga 
//asezarea a i-a, in caz contrar.

#include<bits/stdc++.h>
#define INFINIT INT_MAX

using namespace std;

typedef pair < int, int > iPair;
vector <int> fortarete;

class Graf
{
private:
    int V;
    list< pair < int, int > > *adj;

public:
    Graf( int V );
    void AdaugaMuchie( int, int, int );
    void Dijkstra( int );
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

void Graf::Dijkstra( int src )
{
    priority_queue< iPair, vector <iPair> , greater<iPair> > pq;

    vector <int> dist(V, INFINIT);
    vector <int> apartenenta(V, 0);

    pq.push( make_pair( 0, src ) );
    dist[src] = 0;
    apartenenta[src] = -1;
    for(int i = 0; i < fortarete.size(); i++)
        apartenenta[fortarete[i]] = fortarete[i];

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
                if(u && v)
                    apartenenta[v] = apartenenta[u];//( u ? u : -1 );
                pq.push( make_pair( dist[v], v ) );
            }
            else
                if(dist[v] == dist[u] + lungime)
                {
                    if(u && v && apartenenta[v] > apartenenta[u])
                    apartenenta[v] = apartenenta[u];//( u ? u : -1 );
                }
        }
    }

    for(int i = 0; i < fortarete.size(); i++)
        apartenenta[fortarete[i]] = 0;

    ofstream out( "catun.out" );
    for (int i = 1; i < V; ++i)
        if(dist[i] == INFINIT)
            out << 0 << " ";
        else
            out << apartenenta [i] <<" ";
    out.close( );
}

void citire()
{
    ifstream fin( "catun.in" );
    int V, E, K, a, b, c;
    fin >> V >> E >> K;
    Graf g( V + 1 );
    for(int i = 1; i <= K; i++)
    {
        fin>>a;
        fortarete.push_back(a);
        g.AdaugaMuchie( 0, a, 0 );
    }

    for(int i = 1; i <= E; i++)
    {
        fin >> a >> b >> c;
        g.AdaugaMuchie( a, b, c );
    }
    g.Dijkstra( 0 );
    fin.close( );
}

int main( )
{

    citire( );

    return 0;
}
