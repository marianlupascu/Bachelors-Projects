#include <bits/stdc++.h>
#define FOR(i,a,b) for(int i = a; i <= b; i++)
#define DIMMAX 1005

using namespace std;

char a[DIMMAX][DIMMAX];
int n, m;
struct punct
{
    int x, y;
};
punct Init, Fin;
punct drag[DIMMAX * DIMMAX];
long len_drag = 0;
char aux[DIMMAX][DIMMAX];

void citire();

void bordare_matrice();

void initializare();

void bordare_puncte(int);

void afisare();

int optimizare()
{
    if(aux[Fin.x][Fin.y] == -50)
        return 1;
    else
        return 0;
}

void fill(int l, int c)
{
    aux[l][c] = -50; //conventie: -50=pozitie sigura accesibila
    int dx[4] = {0, -1, 0, 1};
    int dy[4] = {-1, 0, 1, 0};
    FOR(k,0,3)
    {
        int x = l,y = c;
        x += dx[k];
        y += dy[k];
        if((x != 0 && x != n+1)&&(y != 0 && y != m+1) && aux[x][y] >= 0)
        {
            fill(x, y);
        }
    }
}

int R=INT_MIN;

void cautareBinara(int st, int dr)
{
    while(st <= dr)
    {
        int mij = (st + dr) / 2;
        initializare();
        bordare_puncte(mij);
        fill(Init.x, Init.y);
        if(optimizare())
        {
            if(mij > R)
                R = mij;
            st = mij + 1;
        }
        else
            dr = mij - 1;
    }
}

int main()
{
    citire();

    cautareBinara(1, min(n, m));

    ofstream g("barbar.out");

    if(R < 0)
        g<<"-1";
    else
        g<<R;//<<'\n';

    //afisare();

    g.close();

    return 0;
}

void citire()
{
    ifstream f("barbar.in");
    f >> n >> m;
    char x;
    FOR(i,1,n)
    {
        FOR(j,1,m)
        {
            f >> x;
            if(x == '.')
                a[i][j] = 0;
            if(x == 'D')
            {
                a[i][j] = -100;
                len_drag++;
                drag[len_drag].x = i;
                drag[len_drag].y = j;
            }
            if(x == '*')
                a[i][j] = -10;
            if(x == 'I')
            {
                Init.x = i;
                Init.y = j;
                a[i][j] = 0;
            }
            if(x == 'O')
            {
                Fin.x = i;
                Fin.y = j;
                a[i][j] = 0;
            }
        }
    }
    bordare_matrice();
    f.close();
}

void afisare()
{
    FOR(i,1,n)
    {
        FOR(j,1,m)
        {
            cout << (int)aux[i][j] << setw(3);
        }
        cout << '\n';
    }
}

void bordare_puncte(int raza)
{
    raza--;
    FOR(k,1,len_drag)
    {
        int dx = drag[k].x;
        int dy = drag[k].y;
        int dy1 = dy - raza;
        int dy2 = dy + raza;
        for(int i = dx - 1; i >= dx - raza; i--)
        {
            dy1++;
            dy2--;
            FOR(j,dy1,dy2)
            {
                aux[i][j] = -99;
            }
        }
        FOR(i,dy - raza,dy + raza)
        {
            aux[dx][i] = -99;
        }
        dy1 = dy - raza;
        dy2 = dy + raza;
        for(int i = dx + 1; i <= dx + raza; i++)
        {
            dy1++;
            dy2--;
            FOR(j,dy1,dy2)
            {
                aux[i][j] = -99;
            }
        }
    }
}

void bordare_matrice()
{
    FOR(i,0,n+1)
    {
        a[i][0] = -10;
        a[i][m+1] = -10;
    }
    FOR(i,0,m+1)
    {
        a[i][0] = -10;
        a[i][n+1] = -10;
    }
}

void initializare()
{
    FOR(i,0,n + 1)
    {
        FOR(j,0,m +1)
        {
            aux[i][j] = a[i][j];
        }
    }
}
