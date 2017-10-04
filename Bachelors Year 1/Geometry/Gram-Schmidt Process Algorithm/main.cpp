#include <bits/stdc++.h>
#include "Gram-Schmidt.h"

using namespace std;

int main()
{
    ifstream fin ("date.txt");

    baza B;

    fin >> B;

    B.Ortonormalizare_Gram_Schmidt();

    cout << B;

    fin.close();
    return 0;
}
