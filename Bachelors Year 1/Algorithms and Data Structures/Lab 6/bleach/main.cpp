#include <bits/stdc++.h>
#define DIMMAX 1005
#define ll long long

using namespace std;

struct comparator
{
    bool operator()(long long i, long long j)
    {
        return i > j;
    }
};

priority_queue<long long, std::vector<long long>, comparator> minHeap;

ll sumaInitiala, sumaCurenta; // sau puterea curenta

int main()
{
    ifstream f("bleach.in");
    ofstream g("bleach.out");

    ll N, K;
    ll x;

    f>>N>>K;
    for(ll i = 1; i <= K +1; i++)
    {
        f >> x;
        minHeap.push(x);
    }

    sumaInitiala=minHeap.top();
    sumaCurenta=sumaInitiala * 2;

    for(ll i=K+2; i <= N; i++)
    {
        f>>x;
        minHeap.pop();
        minHeap.push(x);
        ll aux = minHeap.top() - sumaCurenta;
        if(aux > 0)
        {
            sumaInitiala += aux;
            sumaCurenta += aux;
        }
        sumaCurenta +=minHeap.top();
    }
    while(!minHeap.empty())
    {
        minHeap.pop();
        ll aux = minHeap.top() - sumaCurenta;
        if(aux > 0)
        {
            sumaInitiala += aux;
            sumaCurenta += aux;
        }
        sumaCurenta +=minHeap.top();
    }

    g<<sumaInitiala;

    f.close();
    g.close();
    return 0;
}
