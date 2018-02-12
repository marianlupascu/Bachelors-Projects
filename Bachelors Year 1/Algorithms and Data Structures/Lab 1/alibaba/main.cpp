#include <iostream>
#include <fstream>
#include <string.h>
#define DIMMAX 10005
#define ll long long
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

int N, M;
char init[DIMMAX];
char stiva[DIMMAX];
ll top = -1;
void pop()
{
    top--;
}
void push(char c)
{
    top++;
    stiva[top]=c;
}
bool empty()
{
    if(top < 0)return 1;
    else return 0;
}

void citire()
{
    ifstream f("alibaba.in");
    f >> N >> M;
    f.get();
    f.getline(init, DIMMAX);
    f.get();
    f.close();
}

void afisare()
{
    ofstream g("alibaba.out");
    if(top>M)
    {
        FOR(i,0,M-1)g<<stiva[i];
    }
    else
    FOR(i, 0, top)
    {
        g<<stiva[i];
    }
    g.close();
}

int k = 0;

void prelucrare()
{
    push(init[k]);
    while(N-k-1+top+1 > M && top<=M)
    {
        k++;
        while(init[k] > stiva[top] && !empty() && N-k-1+top+1 >= M && top<=M)
        {
            pop();
        }
        push(init[k]);
    }
    if(top<M)
    {
        FOR(i,top,N)
        {
            push(init[++k]);
        }
    }
}

int main()
{
    citire();
    M=N-M;;
    prelucrare();
    afisare();

    return 0;
}
