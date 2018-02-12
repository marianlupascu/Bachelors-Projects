#include <bits/stdc++.h>
#include <time.h>
#define DIMMAX 3000005
#define ll long long

using namespace std;

int vect[DIMMAX];
int N, K;

ofstream g("sdo.out");

int QUICKSORT_SDO(int inf, int sup, int K)
{
    if(inf==sup)
        return vect[inf];
    int pivot=vect[rand()%(sup-inf+1)+inf],i=inf,j=sup;
    while(i<=j)
    {
        while(vect[i]<pivot) ++i;
        while(vect[j]>pivot) --j;
        if(i<=j)
        {
            swap(vect[i],vect[j]);
            ++i;
            --j;
        }
    }
    if(K<=j-inf+1)
        return QUICKSORT_SDO(inf,j,K);
    else
        return QUICKSORT_SDO(j+1,sup,K-(j-inf+1));
}

void citire()
{
    ifstream f("sdo.in");
    f>>N>>K;
    for(int i=1; i<=N; ++i)
        f>>vect[i];
    f.close();
}

int main()
{
    //srand(time(NULL));

    citire();

    g<<QUICKSORT_SDO(1,N,K);

    g.close();

    return 0;
}
