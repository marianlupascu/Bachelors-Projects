#include <bits/stdc++.h>
#define FOR(i, a, b) for(unsigned i = a; i < b; i++)
#define M 319993 // nr.prim circular :)
using namespace std;

vector<unsigned> h[M];

int cautare(unsigned x)
{
    unsigned aux = x % M;
    FOR(i, 0, h[aux].size())
        if(h[aux][i] == x)
            return 1;
    return 0;
}

void inserare(unsigned x)
{
    unsigned aux = x % M;
    h[aux].push_back(x);
}

char s[10000001], c[30];
unsigned p[30], aux = 0;
unsigned n, len, sol;

int main()
{
    ifstream in("abc2.in");
    ofstream out("abc2.out");

    p[0] = 1;

    FOR(i, 1, 21)
        p[i] = p[i-1] * 3;

    in >> s;
    n = strlen(s);
    while(in >> c)
    {
        if(!len)
            len = strlen(c);
        aux = 0;
        FOR(i, 0, len)
            aux += p[i] * (c[i] - 'a');
        inserare(aux);
    }
    aux = 0;
    FOR(i, 0, len)
        aux += p[i] * (s[i] - 'a');
    if(cautare(aux))
        sol++;
    FOR(i, len, n)
    {
        aux /= 3;
        aux += p[len - 1] * (s[i] - 'a');
        if(cautare(aux))
            sol++;
    }
    out << sol;

    out.close();

    return 0;
}
