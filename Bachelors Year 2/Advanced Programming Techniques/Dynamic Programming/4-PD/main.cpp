#include <iostream>
#include <fstream>
#include <vector>
#include <limits>

const int INFINIT = INT8_MAX;

std::string cuv;
int nr_palindroame, nr_taieturi;
std::vector <int> cut;
std::vector <std::string> mem;

std::ofstream fout("date.out");

void citire() {

    std::ifstream fin("date.in");

    fin >> cuv;
    cut.assign(cuv.length(), false);
    fin.close();
}

void PD() {

    int matrix[cuv.length()][cuv.length()];
    bool P[cuv.length()][cuv.length()];
    for (int i = 0; i < cuv.length(); i++) {
        for (int j = 0; j < cuv.length(); j++) {
            matrix[i][j] = 0;
            P[i][j] = false;
        }
    }

    for (int i = 0; i < cuv.length(); i++)
        P[i][i] = true;

    for (int i = 0; i < cuv.length() - 1; i++) {
        if (cuv[i] == cuv[i + 1]) {
            P[i][i + 1] = true;
            matrix[i][i + 1] = 1;
        }
    }

    for (int diag = 2; diag < cuv.length(); diag++) {
        for (int i = 0; i < cuv.length() - diag; i++) {
            int j = diag + i;
            if (cuv[i] == cuv[j] && P[i + 1][j - 1])
                P[i][j] = true;
        }
    }

    for (int diag = 2; diag < cuv.length(); diag++) {
        for (int i = 0; i < cuv.length() - diag; i++) {
            int j = diag + i;
            if (P[i][j])
                matrix[i][j] = matrix[i][j - 1] + matrix[i + 1][j] + 1 - matrix[i + 1][j - 1];
            else
                matrix[i][j] = matrix[i][j - 1] + matrix[i + 1][j] - matrix[i + 1][j - 1];
        }
    }
//    for (int i = 0; i < cuv.length(); i++) {
//        for (int j = 0; j < cuv.length(); j++) {
//            std::cout << matrix[i][j] << " ";
//        }
//        std::cout << '\n';
//    }
    nr_palindroame = matrix[0][cuv.length() - 1];
}

void PD_min_cut_palind() {

    bool P[cuv.length()][cuv.length()];
    for (int i = 0; i < cuv.length(); i++) {
        for (int j = 0; j < cuv.length(); j++) {
            P[i][j] = false;
        }
    }

    for (int i = 0; i < cuv.length(); i++)
        P[i][i] = true;

    for (int i = 0; i < cuv.length() - 1; i++) {
        if (cuv[i] == cuv[i + 1]) {
            P[i][i + 1] = true;
        }
    }

    for (int diag = 2; diag < cuv.length(); diag++) {
        for (int i = 0; i < cuv.length() - diag; i++) {
            int j = diag + i;
            if (cuv[i] == cuv[j] && P[i + 1][j - 1])
                P[i][j] = true;
        }
    }
    int nr_taiet_min_sub_i[cuv.length()];
    for (int i = 0; i < cuv.length(); i++) {
        if (P[0][i])
            nr_taiet_min_sub_i[i] = 0;
        else {
            nr_taiet_min_sub_i[i] = INFINIT;
            for (int j = 0; j < i; j++) {
                if (P[j + 1][i] && 1 + nr_taiet_min_sub_i[j] < nr_taiet_min_sub_i[i]) {
                    nr_taiet_min_sub_i[i] = 1 + nr_taiet_min_sub_i[j];
                    cut[i] = j;
                }
            }
        }
    }
//    for (int i=0; i<cuv.length(); i++)
//        std::cout << C[i] << "  ";
    nr_taieturi = nr_taiet_min_sub_i[cuv.length() - 1];
}

void afisare() {
    fout << "Numarul de palindroame este = " << nr_palindroame << '\n';
    fout << "Numarul minim de taieturi pentru palindroame este = " << nr_taieturi << '\n';
    for(int i = 0; i < cuv.length(); i++)
        fout << i << " ";
    fout <<'\n';
    for(int i = 0; i < cuv.length(); i++)
        fout << cut[i] << " ";
    int i = cuv.length() - 1;
    for(int j = nr_taieturi; j>0; j--) {
        std::string s;

        s = cuv.substr(cut[i]+1 ,i - cut[i] );

        mem.push_back(s);
        std::cout << cut[i]+1 << " " << i - cut[i]<<" " << s <<'\n';
        i = cut[i];
    }
    std::string s;
    s = cuv.substr(0 ,i-cut[0]+1 );
    std::cout << 0 << " " << i-cut[1]+1<<" " << s <<'\n';
    std::cout << i;
    mem.push_back(cuv.substr(0, i+1));
    for(int j = mem.size() - 1; j >= 0; j--) {
        fout << mem[j] << " ";
    }
}

int main() {

    citire();

    PD();

    PD_min_cut_palind();

    afisare();

    return 0;
}
