#include <iostream>
#include <fstream>
#include <vector>

int n, m, k;
std::vector<std::vector<int>> matrix, copie;

std::ofstream fout(
        R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab PD\3-PD\date.out)");

void citire() {

    std::ifstream fin(
            R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab PD\3-PD\date.in)");

    fin >> n >> m;
    std::vector<int> a;
    matrix.assign(n, a);
    copie.assign(n, a);
    int x;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            fin >> x;
            matrix[i].push_back(x);
            if (x == 1)
                copie[i].push_back(0);
            else
                copie[i].push_back(-1);
        }
    }
    fin >> k;
    fin.close();
}

void PD() {

    for (int j = 0; j < m; j++) {
        copie[n - 1][j] = matrix[n - 1][j] ? 0 : 1;
    }
    for (int i = 0; i < n; i++) {
        copie[i][m - 1] = matrix[i][m - 1] ? 0 : 1;
    }
    for (int i = n - 2; i >= 0; i--) {
        for (int j = m - 2; j >= 0; j--) {
            if (copie[i][j]) {
                if (copie[i + 1][j] && copie[i][j + 1] && copie[i + 1][j + 1]) {
                    if (copie[i + 1][j] == copie[i][j + 1] && copie[i][j + 1] == copie[i + 1][j + 1])
                        copie[i][j] = copie[i + 1][j] + 1;
                    else {
                        copie[i][j] = std::min(copie[i + 1][j], std::min(copie[i][j + 1], copie[i + 1][j + 1])) + 1;
                    }
                } else {
                    copie[i][j] = 1;
                }
            }
        }
    }
    int max = 0, ii, jj, count = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if(copie[i][j] > max) {
                max = copie[i][j];
                ii = i;
                jj = j;
            }
            if(copie[i][j] >= k)
                count+=(copie[i][j]-k +1);
        }
    }
    fout << max << '\n' << ii+1 << " " << jj+1 << '\n' << count <<'\n';
}

void afisare() {

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            std::cout << copie[i][j] << " ";
        }
        std::cout << '\n';
    }
}

int main() {

    citire();

    PD();

    afisare();

    return 0;
}