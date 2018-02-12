#include <iostream>
#include <fstream>
#include <iomanip>
#include <math.h>
#define DIMMAX 100005
#define sqrt_DIMMAX 320
#define ll long long
#define FOR(i, a, b) for(ll i = a; i <= b; i++)

using namespace std;

ll A[DIMMAX];
ll N, M, rad;
ll smen[sqrt_DIMMAX];

void init()
{
    FOR(i, 0, DIMMAX-5)
    {
        A[i] = -2;
    }
    FOR(i, 0, sqrt_DIMMAX-2)
    {
        smen[i] = -3;
    }
}

int main()
{
    ifstream f("arbint.in");
    ofstream g("arbint.out");
    f>>N>>M;

    init();

    ll rad = (ll)sqrt(N) + 1;

    FOR(i,1,N)
    {
        f>>A[i];
        smen[i/rad]=max(smen[i/rad],A[i]);
    }

    FOR(i, 1, M)
    {
        ll a, b, ind;
        f>>ind>>a>>b;
        if(ind == 0)
        {
            ll maxim = -5;
            ll k = a;

            for(k ; k % rad != 0 && k <= b; k++)
                maxim = max(maxim, A[k]);

            for(k ; b - k > rad; k += rad)
                maxim = max(maxim, smen[k / rad]);

            for(k ; k <= b; k++)
                maxim = max(maxim, A[k]);

            g << maxim << '\n';
        }
        else
        {
            A[a] = b;
                smen[a / rad] = -5;
            ll first = (a / rad) * rad;
            ll last = (a / rad + 1) * rad;
            for(ll k = first; k <= N && k < last; k++)
                smen[a / rad] = max(smen[a / rad], A[k]);
        }
    }
    f.close();
    g.close();
    return 0;
}
