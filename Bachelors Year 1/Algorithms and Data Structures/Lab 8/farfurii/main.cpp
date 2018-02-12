#include <bits/stdc++.h>
#define DIMMAX 100005
#define ll long long
#define FOR(i, a, b) for(ll i = a; i <= b; i++)

using namespace std;

int main()
{
    ifstream in("farfurii.in");
    ofstream out("farfurii.out");

    ll N, K;
    in >> N >> K;

    ll p = 1;
    while(p * (p - 1) / 2 < K)
        p++;
    FOR(i, 1, N - p)
        out << i <<" ";
    K = N + K - p * (p - 1) / 2;
    out << K << " ";
    for(ll i = N; i >= N - p + 1; i--)
        if(i != K)
            out << i << " ";

    in.close();
    out.close();
    return 0;
}
