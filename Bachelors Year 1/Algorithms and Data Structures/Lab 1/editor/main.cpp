#include <iostream>
#include <fstream>
#include <string.h>
#include <iomanip>
#define DIMMAX 60005
#define ll long long
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

int T,len[31];
char init[31][DIMMAX];
char stiva[DIMMAX],aux[DIMMAX];
bool sol[DIMMAX];
ll top = -1, top_aux=-1;

void reinitializare()
{
    top = -1;
    top_aux = -1;
}

void pop()
{
    top--;
}
void push(char c)
{
    stiva[++top] = c;
}
bool empty()
{
    if(top < 0)return 1;
    else return 0;
}

void pop_aux()
{
    top_aux--;
}
void push_aux(char c)
{
    aux[++top_aux] = c;
}
bool empty_aux()
{
    if(top_aux < 0)return 1;
    else return 0;
}

void citire()
{
    ifstream f("editor.in");
    f>>T;
    f.get();
    FOR(i,0,T-1)
    {
        f.getline(init[i],DIMMAX);
    }
    FOR(i,0,T-1)
    {
        int j=-1;
        while(init[i][j]!='E')++j;
        len[i]=j;
    }
    f.close();
}

ofstream g("editor.out");

void afisare()
{

        FOR(i,0,top_aux)
        {
            cout<<aux[i];
        }
    cout<<'\n';
    FOR(i,0,T-1)
    {
        g<<len[i]<<" ";
    }

}

void executare_ste(int i)  //ste==*
{
    FOR(j,0,len[i])
    {
        if(init[i][j]!='*' && init[i][j]!='E')
        {
            push(init[i][j]);
        }
        if(init[i][j]=='*' && !empty())
        {
            pop();
        }
    }
}

bool analizare_caz_particualar(int i)  // existenta ****....*******E (n stelute apoi E)
{
    if(init[i][0]=='E')return 1;
    else
    {
        for(int j=0;j<len[i];j++)
        {
            if(init[i][j]!='*')
            {
                if(init[i][j]!='E')return 0;
                else return 1;
            }
        }
    }
}

void solutie(int i)
{
    push_aux(stiva[0]);
    FOR(i,1,top)
    {
        push_aux(stiva[i]);
        while((aux[top_aux] == ')' && aux[top_aux-1] == '(') || (aux[top_aux] == ']' && aux[top_aux-1] == '[') && !empty_aux())
        {
            pop_aux();
            pop_aux();
        }
    }

    int ok=analizare_caz_particualar(i);

    if(empty_aux() || ok || top==-1)g<<":)";
        else g<<":(";
    g<<'\n';
}

int main()
{
    citire();
    FOR(i,0,T-1)
    {
        executare_ste(i);
        solutie(i);
        //afisare();
        reinitializare();
    }
    g.close();
    return 0;
}
