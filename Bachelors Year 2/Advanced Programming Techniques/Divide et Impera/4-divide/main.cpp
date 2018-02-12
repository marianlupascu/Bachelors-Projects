#include <iostream>
#include <fstream>
#include <algorithm>
#include <vector>
#include <cmath>
#include <iomanip>

std::ifstream fin(
        R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab Divide\4-divide\cmap.in)");

std::ofstream fout(
        R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab Divide\4-divide\cmap.out)");

int n;
std::vector<std::pair<int, int>> V;

void interclasare(int, int, int);

void citire() {
    fin >> n;
    int x, y;
    for (int i = 1; i <= n; i++) {
        fin >> x >> y;
        V.emplace_back(x, y);
    }
}

bool cmp(const std::pair<int, int> &p1, const std::pair<int, int> &p2) {
    return (p1.second < p2.second);
}

long long distanta_euclidiana_la_patrat(const std::pair<int, int> &p1, const std::pair<int, int> &p2) {
    return (long long) (p1.first - p2.first) * (long long) (p1.first - p2.first) +
           (long long) (p1.second - p2.second) * (long long) (p1.second - p2.second);
}

long long Solve(int st, int dr) {

    if (dr - st == 1) {
        if (V[st].second > V[dr].second)
            std::swap(V[st], V[dr]);
        return distanta_euclidiana_la_patrat(V[st], V[dr]);
    } else if (dr - st == 2) {
        std::sort(V.begin() + st, V.begin() + dr + 1, cmp);
        return std::min(distanta_euclidiana_la_patrat(V[st], V[st + 1]),
                        std::min(distanta_euclidiana_la_patrat(V[st], V[st + 2]),
                                 distanta_euclidiana_la_patrat(V[st + 1], V[st + 2])));
    }

    int mij = (st + dr) / 2;
    int mij_x = V[mij].first;
    long long d = std::min(Solve(st, mij), Solve(mij + 1, dr));
    auto delta = static_cast<int>(std::ceil(std::sqrt(d)));
    interclasare(st, mij, dr);

    std::vector<std::pair<int, int>> A;
    for (int i = st; i <= dr; i++) {
        if (std::abs((V[i].first - mij_x)) <= delta)
            A.push_back(V[i]);
    }
    for (int i = 0; i < A.size(); i++)
        for (int j = i + 1; j <= i + 7 && j < A.size(); j++)
            d = std::min(d, distanta_euclidiana_la_patrat(A[i], A[j]));

    return d;
}

void interclasare(int start, int m, int end) {
    std::vector<std::pair<int, int>> Aux;
    int i = start, j = m + 1;

    while ((i <= m) && (j <= end))
        if (V[i].second <= V[j].second)
            Aux.push_back(V[i++]);
        else
            Aux.push_back(V[j++]);

    while (i <= m)
        Aux.push_back(V[i++]);

    while (j <= end)
        Aux.push_back(V[j++]);

    for (i = start; i <= end; i++)
        V[i] = Aux[i - start];
}

int main() {
    citire();

    sort(V.begin(), V.end());

    fout << std::fixed << std::setprecision(6) << std::sqrt(Solve(0, n - 1)) << '\n';

    return 0;
}