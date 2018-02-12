#include <iostream>
#include <fstream>
#include <vector>
#include <limits>
#include <set>

const auto MINUSINFINIT = INT32_MIN;
int n, m;
std::vector<std::vector<int>> matrix, copie;

std::ofstream fout(
        R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab PD\2-PD\date.out)");

void citire() {

    std::ifstream fin(
            R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab PD\2-PD\date.in)");

    fin >> n >> m;
    std::vector<int> a;
    matrix.assign(n, a);
    copie.assign(n, a);
    int x;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            fin >> x;
            matrix[i].push_back(x);
            copie[i].push_back(x);
        }
    }

    fin.close();
}

int max = MINUSINFINIT;
std::set<int> linii_max;

void PD() {

    for (int j = m - 2; j >= 0; j--) {
        for (int i = 0; i < n; i++) {
            copie[i][j] += std::max(copie[i][j + 1], std::max(((i == 0) ? (MINUSINFINIT) : (copie[i - 1][j + 1])),
                                                              ((i == n - 1) ? (MINUSINFINIT) : (copie[i + 1][j + 1]))));
        }
    }
    for (int i = 0; i < n; i++) {
        if (max < copie[i][0])
            max = copie[i][0];
    }
    fout << max << '\n';

    for (int i = 0; i < n; i++) {
        if (max == copie[i][0])
            linii_max.insert(i);
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            std::cout << copie[i][j] << " ";
        }
        std::cout << '\n';
    }
    for (auto i : linii_max)
        std::cout << i << " ";
    std::cout << '\n';

}

long drumuri;

void reconstructie_recursiva(int linie, int coloana, int &index) {

    if (index == 1)
        fout << (linie + 1) << " " << (coloana + 1) << '\n';
    if (coloana == m - 1) {
        drumuri++;
        index++;
        return;
    }
    if (linie != 0)
        if (copie[linie][coloana] == matrix[linie][coloana] + copie[linie - 1][coloana + 1]) {
            reconstructie_recursiva(linie - 1, coloana + 1, index);
        }
    if (copie[linie][coloana] == matrix[linie][coloana] + copie[linie][coloana + 1]) {
        reconstructie_recursiva(linie, coloana + 1, index);
    }
    if (linie != n - 1)
        if (copie[linie][coloana] == matrix[linie][coloana] + copie[linie + 1][coloana + 1]) {
            reconstructie_recursiva(linie + 1, coloana + 1, index);
        }
}

void reconstructie_iterativa() {

    int reconstruct[n][m];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++)
            reconstruct[i][j] = 0;
    }
    for (auto it : linii_max)
        reconstruct[it][0] = 1;

    for (int j = 1; j < m; j++) {
        for (int i = 0; i < n; i++) {
            if (i != 0)
                if (copie[i][j] == copie[i - 1][j - 1] - matrix[i - 1][j - 1]) {
                    reconstruct[i][j] += reconstruct[i - 1][j - 1];
                }
            if (copie[i][j] == copie[i][j - 1] - matrix[i][j - 1]) {
                reconstruct[i][j] += reconstruct[i][j - 1];
            }
            if (i != n - 1)
                if (copie[i][j] == copie[i + 1][j - 1] - matrix[i + 1][j - 1]) {
                    reconstruct[i][j] += reconstruct[i + 1][j - 1];
                }
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++)
            std::cout << reconstruct[i][j] << " ";
        std::cout << '\n';
    }
    for (int i = 0; i < n; i++)
        drumuri += reconstruct[i][m - 1];
    for (auto i : linii_max) {
        for (int j = 0; j < m; j++)
            if (reconstruct[i][j]) {
                fout << (i + 1) << " " << (j + 1) << '\n';
                if (i == 0) {
                    if (reconstruct[i + 1][j + 1])
                        i++;
                }
                if (i == n - 1)
                    if (reconstruct[i - 1][j])
                        i--;
                if (i != 0 && i != n - 1) {
                    if (reconstruct[i - 1][j])
                        i--;
                    if (reconstruct[i + 1][j + 1])
                        i++;
                }
            }
        break;
    }
}

void afisare() {

    if (drumuri == 1)
        fout << "Traseu unic\n";
    else
        fout << "Numarul de drumuri este = " << drumuri << '\n';
    fout.close();
}

int main() {

    citire();

    PD();
/*
    int index = 1;
    for(auto it : linii_max)
        reconstructie_recursiva(it, 0, index);
*/
    reconstructie_iterativa();

    afisare();

    return 0;
}