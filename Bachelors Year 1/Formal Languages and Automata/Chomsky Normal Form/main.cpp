#include <iostream>
#include <fstream>
#include "grammar.h"

using namespace std;

int main()
{
    ifstream fin("grammar.in");
    ofstream fout("grammar.out");

    gramatica G;

    fin >> G;

    cout << "Initial:" << '\n' << G << '\n';

    G.Transform_into_Chomsky_Normal_Form();

    fout << G;

    cout << "la final:" << '\n' << G << '\n';

    return 0;
}
