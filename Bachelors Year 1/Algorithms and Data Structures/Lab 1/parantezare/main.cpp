#include <iostream>
#include <fstream>
#include <string.h>
#include <iomanip>
#define DIMMAX 100005
#define ll long long
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

int N, M;
char init[DIMMAX];
int coada[DIMMAX];
int quest[DIMMAX],hp[2][DIMMAX];
ll top = -1;
void pop()
{
    top--;
}
void push(int c)
{
    top++;
    coada[top]=c;
}
bool empty()
{
    if(top < 0)return 1;
    else return 0;
}

void citire()
{
    ifstream f("parantezare.in");
    f.getline(init, DIMMAX);
    f>>M;
    FOR(i,1,M)
    {
        f>>quest[i];
    }
    f.close();
}

ll k=0;

    ofstream g("parantezare.out");


void afisare()
{
    FOR(i,0,1)
    {
        FOR(j,0,k)
        {
            g<<hp[i][j]<<setw(5);
        }
        g<<'\n';
    }
}

ll len;

void det_closer()
{
    len=strlen(init);
    FOR(i,0,len-1)
    {
        if(init[i]=='(')push(i);
        if(init[i]==')')
        {
            hp[0][k]=coada[top];
            hp[1][k]=i;
            pop();
            k++;
        }
    }
    k--;
}

void search_poz()
{
    FOR(i,1,M)
    {
        FOR(j,0,k)
        {
            if(hp[0][j]==quest[i])g<<hp[1][j]<<" ";
        }
    }
}

int main()
{
    citire();
    det_closer();
    search_poz();
    //g<<'\n';
    //afisare();
    g.close();
    return 0;
}
