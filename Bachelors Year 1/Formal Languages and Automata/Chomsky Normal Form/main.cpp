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

    G.Transform_into_Chomsky_Normal_Form();

    fout << G;

    return 0;
}
