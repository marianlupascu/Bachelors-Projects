#include <iostream>
#include <fstream>
#include <vector>

int n;
std::vector<int> v;

void citire() {

    std::ifstream fin(
            R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab Divide\1-divide\date.in)");
    fin >> n;

    int x;
    for (int i = 1; i <= n; i++) {
        fin >> x;
        v.push_back(x);
    }

    fin.close();
}

int divide(int s, int d) {
    if (s > d)
        return -1;
    else {
        int m = (s + d) / 2;
        if (m >= 1 && m <= v.size() - 2) {
            if (v[m] > v[m - 1] && v[m] > v[m + 1]) {
                return v[m];
            }
        }
        if (m == 0) {
            if (v[m] > v[m + 1])
                return v[m];
        }
        if (m == v.size() - 1) {
            if (v[m] > v[m - 1])
                return v[m];
        }
        if (v[m - 1] < v[m] && v[m] < v[m + 1])
            return divide(m + 1, d);
        else
            return divide(s, m - 1);
    }
}

int main() {

    citire();

    std::ofstream out(
            R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab Divide\1-divide\date.out)");

    out << divide(0, v.size() - 1);

    out.close();

    return 0;
}