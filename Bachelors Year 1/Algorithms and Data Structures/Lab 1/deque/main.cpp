#include <iostream>
#include <fstream>
#define DIMMAX 5000002
#define ll long long
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

int N, K, A[DIMMAX], deque[DIMMAX], stanga=1, dreapta=0; //deque retine pozitiiile elementelor din A[]
ll suma;

void citire()
{
    ifstream f("deque.in");
    f >> N >> K;
    FOR(i, 1, N)
    {
        f >> A[i];
    }
    f.close();
}

void afisare()
{
    ofstream g("deque.out");
//    FOR(i, 1, N)
//    {
//        g << deque[i]<< " ";
//    }
    g<<suma;
    g.close();
}

void calcul_suma()
{
    deque[1] = 10000001;
    FOR(i, 1, N)
    {
        while (stanga <= dreapta && A[deque[dreapta]] >= A[i]) --dreapta;
        deque[++dreapta] = i;
        while (stanga <= dreapta && i - deque[stanga] >= K) ++stanga;
        if (i >= K) suma += (ll)A[deque[stanga]];
    }
}

int main()
{
    citire();
    calcul_suma();
    afisare();
    return 0;
}
