#include <iostream>
#include <fstream>
#include <iomanip>
#include "polinom.h"

using namespace std;

int main()
{
    ifstream fin("date.in");
    pair_polinom a;
    fin>>a;

    cout<<a;

    //pair_polinom b(a, 4.5);
    cout<<'\n'<<a.verif_radacina()<<'\n';

    cout<<'\n'<<a;

    fin.close();
    return 0;
}
