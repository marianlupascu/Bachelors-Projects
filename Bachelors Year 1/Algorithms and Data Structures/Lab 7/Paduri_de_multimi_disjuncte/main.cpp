#include <bits/stdc++.h>
#define DIMMAX 100005
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

int n, m;
struct noduri
{
    int valoare;
    int tata;
}nod[DIMMAX];

int det_radacina(int x)
{
    if(nod[x].tata == -1)
        return x;
    else
        return det_radacina(nod[x].tata);
}

int main()
{
    ifstream f("disjoint.in");
    ofstream g("disjoint.out");
    f >> n >> m;

    FOR(i, 1, n)
    {
        nod[i].valoare = i;
        nod[i].tata = -1;
    }

    FOR(i, 1, m)
    {
        int tip, x, y;
        f >> tip >> x >> y;
        int radacina_x = det_radacina(x);
        int radacina_y = det_radacina(y);

        if(tip == 1)
            nod[radacina_x].tata = radacina_y;
        else
            if(tip == 2)
            {
                int aux;
                while(nod[x].tata != -1)
                {
                    aux = x;
                    x = nod[x].tata;
                    nod[aux].tata = radacina_x;
                }
                //compresia drumurilor
                while(nod[y].tata != -1)
                {
                    aux = y;
                    y = nod[y].tata;
                    nod[aux].tata = radacina_y;
                }
                //compresia drumurilor
                if(radacina_x == radacina_y)
                    g << "DA\n";
                else
                    g << "NU\n";
            }
    }
    f.close();
    g.close();
    return 0;
}
