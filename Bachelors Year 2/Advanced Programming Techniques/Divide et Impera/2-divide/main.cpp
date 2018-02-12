#include <iostream>
#include <fstream>
#include <cmath>

int n, k;
long long int x, y;
long long int nr;

long long divide(long long int, long long int, long long int, long long int, long long int, long long int);

void procesare() {

    std::ifstream fin(
            R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab Divide\2-divide\z.in)");
    std::ofstream out(
            R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab Divide\2-divide\z.out)");

    fin >> n >> k;
    for (int i = 1; i <= k; i++) {
        fin >> x >> y;
        nr = 1;
        out << divide(x, y, 1, 1, static_cast<long long int>(std::pow(2, n)),
                      static_cast<long long int>(std::pow(2, n))) << '\n';
    }
    fin.close();
    out.close();
}

long long
divide(long long int x, long long int y, long long int sus, long long int st, long long int jos, long long int dr) {
    if (sus == jos && st == dr)
        return nr;
    else {
        if (x <= (jos + sus - 1) / 2 && y <= (dr + st - 1) / 2) {
            divide(x, y, sus, st, (jos + sus - 1) / 2, (dr + st - 1) / 2);
        } else if (x <= (jos + sus - 1) / 2 && y >= (dr + st - 1) / 2) {
            nr += ((jos - sus + 1) * (dr - st + 1)) / 4;
            divide(x, y, sus, (dr + st - 1) / 2 + 1, (jos + sus - 1) / 2, dr);
        } else if (x >= (jos + sus - 1) / 2 && y <= (dr + st - 1) / 2) {
            nr += ((jos - sus + 1) * (dr - st + 1)) / 2;
            divide(x, y, (jos + sus - 1) / 2 + 1, st, jos, (dr + st - 1) / 2);
        } else if (x >= (jos + sus - 1) / 2 && y >= (dr + st - 1) / 2) {
            nr += (3 * ((jos - sus + 1) * (dr - st + 1))) / 4;
            divide(x, y, (jos + sus - 1) / 2 + 1, (dr + st - 1) / 2 + 1, jos, dr);
        }
    }
}

int main() {

    procesare();

    return 0;
}