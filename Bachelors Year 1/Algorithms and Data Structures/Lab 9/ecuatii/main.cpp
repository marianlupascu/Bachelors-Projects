#include <bits/stdc++.h>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
#define M 99991

using namespace std;

int a[6];
int sol;

void citire()
{
    ifstream in("eqs.in");
    FOR(i, 1, 5)
        in >> a[i];
    in.close();
}

vector <int> h[M];

void inserare(long long x)
{
    int aux = abs(x) % M;
    h[aux].push_back(x);
}

int cautare(long long x)
{
    int aux = abs(x) % M;
    int s=0;
    for(int i = 0; i < h[aux].size(); i++)
        if(h[aux][i] == x)
            s++;
    return s;
}

void rezolvare()
{
    long long aux;

    FOR(i, -50, 50)
        FOR(j, -50, 50)
        {
            if(i&&j)
            {
                aux = a[1]*i*i*i + a[2]*j*j*j;
                inserare(-aux);
            }
        }

    FOR(i, -50, 50)
        FOR(j, -50, 50)
            FOR(k, -50, 50)
            {
                aux = a[3]*i*i*i + a[4]*j*j*j + a[5]*k*k*k;
                if(i&&j&&k)
                    sol+=cautare(aux);
            }
}

int main()
{
    ofstream g("eqs.out");
    citire();
    rezolvare();
    g <<sol;
    g.close();
    return 0;
}
