#include <bits/stdc++.h>
#include <time.h>
#define DIMMAX 500005

using namespace std;

long vect[DIMMAX];
long N;

void QUICKSORT(long inf, long sup)
{
    long x, i, j, t;
    i = inf;
    j = sup;
    x=vect[rand()%(sup-inf)+inf];
    do
    {
        while ( (i < sup) && (vect[i] < x) ) i++;
        while ( (j > inf) && (vect[j] > x) ) j--;
        if ( i<= j )
        {
            t = vect[i];
            vect[i] = vect[j];
            vect[j] = t;
            i++;
            j--;
        }
    } while ( i <= j );
    if ( inf < j ) QUICKSORT(inf, j);
    if ( i < sup ) QUICKSORT(i, sup);
}

void citire()
{
    ifstream f("algsort.in");
    f>>N;
    for(long i=0; i<N; i++)
        f>>vect[i];
    f.close();
}

void afisare()
{
    ofstream g("algsort.out");
    for(long i=0; i<N; i++)
        g<<vect[i]<<" ";
    g.close();
}

int main()
{
    srand(time(NULL));

    citire();

    QUICKSORT(0,N-1);

    afisare();

    return 0;
}
