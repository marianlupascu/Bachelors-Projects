#include <iostream>
#include <fstream>
#define DIMMAX 30005
#define FOR(i,a,b) for(int i=a;i<=b;i++)

using namespace std;

int N, b[DIMMAX];

void citire()
{
    ifstream f("nrtri.in");

    f>>N;
    FOR(i,1,N)
    {
        f>>b[i];
    }

    f.close();
}

void afisare(int x)
{
    ofstream g("nrtri.out");

    g<<x;

    g.close();
}

int aux[DIMMAX];

void merge_sort(int s, int d)
{
    int m = (s + d) >> 1, i, j, k;
    if (s == d) return;
    merge_sort(s, m);
    merge_sort(m + 1, d);
    for (i=s, j=m+1, k=s; i<=m || j<=d; )
        if (j > d || (i <= m && b[i] < b[j]))
            aux[k++] = b[i++];
        else
            aux[k++] = b[j++];
    for (k = s; k <= d; k++) b[k] = aux[k];
}

int cautBin(int s, int d, int val)
{
    int m;
    while (s<d)
    {
        m=(d+s)/2;
        if(b[m]<=val)
            s=m+1;
        else
            d=m;
    }
    m=(s+d)/2;
    if(b[m]>val)--m;
    return m;
}

int sum=0;

int main()
{
    citire();

    merge_sort(1,N);

    FOR(i,1,N-2)
    {
        FOR(j,i+1,N-1)
        {
            int aux=cautBin(j+1,N,b[i]+b[j]);
            if(aux>j)sum+=aux-j;
        }
    }

    afisare(sum);

    return 0;
}
