#include <iostream>
#include <fstream>
#include <math.h>       /* acos */
#include <stdlib.h>
#define PI 3.14159265
#define EPS 0.0000000000000001

using namespace std;

pair<double, double> A[5];

void citire() {

    ifstream fin("date.in");
    for(int i = 1; i <= 4; i++) {
        fin >> A[i].first >> A[i].second;
    }

    fin.close();
}

double produs_scalar(pair<double, double> a, pair<double, double> b) {
    return a.first * b.first + a.second * b.second;
}

double lungime(pair<double, double> a) {
    return sqrt(a.first * a.first + a.second * a.second);
}

pair<double, double> conversie_vector(pair<double, double> a, pair<double, double> b) {
    return std::make_pair(b.first - a.first, b.second - a.second);
}

void procesare_insc() {
    double cosA2 = produs_scalar(conversie_vector(A[2], A[1]), conversie_vector(A[2], A[3]));
    cosA2 /= lungime(conversie_vector(A[2], A[1])) * lungime(conversie_vector(A[2], A[3]));

    double cosA4 = produs_scalar(conversie_vector(A[4], A[1]), conversie_vector(A[4], A[3]));
    cosA4 /= lungime(conversie_vector(A[4], A[1])) * lungime(conversie_vector(A[4], A[3]));

    double acosA2 = acos (cosA2) * 180.0 / PI;
    double acosA4 = acos (cosA4) * 180.0 / PI;

    if(abs(acosA2 + acosA4 - 180) < EPS )
        cout << acosA2 << " deg " << acosA4 << " deg \n" << "A4 apartine C\n";
    else
        if(acosA2 + acosA4 > 180)
            cout << acosA2 << " deg " << acosA4 << " deg \n" << "A4 in interiorul lui C\n";
        else
             cout << acosA2 << " deg " << acosA4 << " deg \n" << "A4 in exeriorul lui C\n";
}

procesare_circumscs() {
    if(lungime(conversie_vector(A[1], A[2]))+ lungime(conversie_vector(A[3], A[4])) == lungime(conversie_vector(A[1], A[4]))+lungime(conversie_vector(A[3], A[2])))
        cout << "Patrulaterul este circumscriptibil\n";
    else
        cout << "Patrulaterul NU este circumscriptibil\n";
}

int main()
{
    citire();

    procesare_insc();

    procesare_circumscs();

    return 0;
}
