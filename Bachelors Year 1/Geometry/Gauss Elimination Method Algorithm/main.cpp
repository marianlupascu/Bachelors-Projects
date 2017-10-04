#include <iostream>
#include <fstream>
#include "Gauss.h"

using namespace std;

//programul merge doar pe cazul in care exista x1 patrat si x2, patrat (la pasul 2), etc, (adica doar pe cazul I :))

int main()
{
    ifstream fin("Gauss_method.txt");

    FormaPatratica Q;

    cin>>Q;
    cout<<Q;

    Q.Afisare_forma_Canonica( cout );

    return 0;
}
