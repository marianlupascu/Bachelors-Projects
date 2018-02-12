#include <iostream>
#include <fstream>
#include <ctime>
#include <algorithm>

const int DIMMAX = 1000;

int n;
int v[2 * DIMMAX];
int scor1;
int scor2;
std::string jucator1;
std::string jucator2;

std::ofstream out("date.out");

void citire() {

    std::ifstream fin(
            R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab Greedy\1\cmake-build-debug\date.in)");
    fin >> n;
    for (int i = 1; i <= n; i++) {
        fin >> v[i];
    }

    fin.close();
}

void afisare_random() {

    out << "Joc in care jucatorul 2 alege random pe tehnica 1\n";
    out << "Scor jucator 1 = " << scor1 << '\n';
    for (char &it : jucator1)
        out << it << " ";
    out << '\n';
    out << "Scor jucator 2 = " << scor2 << '\n';
    for (char &it : jucator2)
        out << it << " ";

}

void afisare_max() {

    out << "\n\nJoc in care jucatorul 2 alege maxime pe tehnica 1\n";
    out << "Scor jucator 1 = " << scor1 << '\n';
    for (char &it : jucator1)
        out << it << " ";
    out << '\n';
    out << "Scor jucator 2 = " << scor2 << '\n';
    for (char &it : jucator2)
        out << it << " ";

}

void afisare_random_tehnica2() {

    out << "\n \n \n \n";
    out << "Joc in care jucatorul 2 alege random pe tehnica 2\n";
    out << "Scor jucator 1 = " << scor1 << '\n';
    for (char &it : jucator1)
        out << it << " ";
    out << '\n';
    out << "Scor jucator 2 = " << scor2 << '\n';
    for (char &it : jucator2)
        out << it << " ";

}

void afisare_max_tehnica2() {

    out << "\n\nJoc in care jucatorul 2 alege maxime pe tehnica 2\n";
    out << "Scor jucator 1 = " << scor1 << '\n';
    for (char &it : jucator1)
        out << it << " ";
    out << '\n';
    out << "Scor jucator 2 = " << scor2 << '\n';
    for (char &it : jucator2)
        out << it << " ";

}

void bucla_de_joc_random() {

    srand(static_cast<unsigned int>(time(nullptr)));
    int start;
    start = 1;
    int end;
    end = n;
    while (start < end) {

        //tura jucatorului 1
        if (v[start] == v[end]) {
            if (v[start + 1] == v[end - 1]) {
                int alegere;
                alegere = rand() % 2;
                if (alegere == 0) {
                    scor1 += v[start];
                    start++;
                    jucator1 += 'S';
                } else {
                    scor1 += v[end];
                    end--;
                    jucator1 += 'D';
                }
            } else {
                if (v[start + 1] < v[end - 1]) {
                    scor1 += v[start];
                    start++;
                    jucator1 += 'S';
                } else {
                    scor1 += v[end];
                    end--;
                    jucator1 += 'D';
                }
            }
        } else {
            if (v[start] - v[start + 1] == v[end] - v[end - 1]) {
                if (v[start] > v[end]) {
                    scor1 += v[start];
                    start++;
                    jucator1 += 'S';
                    std::cout << " 1S ";
                } else {
                    scor1 += v[end];
                    end--;
                    jucator1 += 'D';
                    std::cout << " 1D ";
                }
            } else {
                if (v[start] - v[start + 1] > v[end] - v[end - 1]) {
                    scor1 += v[start];
                    start++;
                    jucator1 += 'S';
                    std::cout << " 1S ";
                } else {
                    scor1 += v[end];
                    end--;
                    jucator1 += 'D';
                    std::cout << " 1D ";
                }
            }
        }


        //tura jucatorului 2
        int alegere;
        alegere = rand() % 2;
        if (alegere == 0) {
            scor2 += v[start];
            start++;
            jucator2 += 'S';
            std::cout << " 2S ";
        } else {
            scor2 += v[end];
            end--;
            jucator2 += 'D';
            std::cout << " 2D ";
        }
    }
}

void bucla_de_joc_maxim() {

    srand(static_cast<unsigned int>(time(nullptr)));
    int start;
    start = 1;
    int end;
    end = n;
    scor1 = 0;
    scor2 = 0;
    jucator1 = "";
    jucator2 = "";
    while (start < end) {

        //tura jucatorului 1
        if (v[start] == v[end]) {
            if (v[start + 1] == v[end - 1]) {
                int alegere;
                alegere = rand() % 2;
                if (alegere == 0) {
                    scor1 += v[start];
                    start++;
                    jucator1 += 'S';
                } else {
                    scor1 += v[end];
                    end--;
                    jucator1 += 'D';
                }
            } else {
                if (v[start + 1] < v[end - 1]) {
                    scor1 += v[start];
                    start++;
                    jucator1 += 'S';
                } else {
                    scor1 += v[end];
                    end--;
                    jucator1 += 'D';
                }
            }
        } else {
            if (v[start] - v[start + 1] == v[end] - v[end - 1]) {
                if (v[start] > v[end]) {
                    scor1 += v[start];
                    start++;
                    jucator1 += 'S';
                    std::cout << " 1S ";
                } else {
                    scor1 += v[end];
                    end--;
                    jucator1 += 'D';
                    std::cout << " 1D ";
                }
            } else {
                if (v[start] - v[start + 1] > v[end] - v[end - 1]) {
                    scor1 += v[start];
                    start++;
                    jucator1 += 'S';
                    std::cout << " 1S ";
                } else {
                    scor1 += v[end];
                    end--;
                    jucator1 += 'D';
                    std::cout << " 1D ";
                }
            }
        }


        //tura jucatorului 2
        if (v[start] > v[end]) {
            scor2 += v[start];
            start++;
            jucator2 += 'S';
            std::cout << " 2S ";
        } else {
            scor2 += v[end];
            end--;
            jucator2 += 'D';
            std::cout << " 2D ";
        }
    }
}

void bucla_de_joc_random_tehnica2() {

    srand(static_cast<unsigned int>(time(nullptr)));
    int start;
    start = 1;
    int end;
    end = n;
    scor1 = 0;
    scor2 = 0;
    jucator1 = "";
    jucator2 = "";

    int poz_pare = 0;
    int poz_imp = 0;
    for (int i = 1; i <= n; i++)
        if (i % 2)
            poz_imp += v[i];
        else
            poz_pare += v[i];

    while (start < end) {

        if (poz_imp > poz_pare) {
            if (start % 2) {
                scor1 += v[start];
                start++;
                jucator1 += 'S';
            } else {
                scor1 += v[end];
                end--;
                jucator1 += 'D';
            }
        }
        else {
            if (end % 2) {
                scor1 += v[start];
                start++;
                jucator1 += 'S';
            } else {
                scor1 += v[end];
                end--;
                jucator1 += 'D';
            }
        }

        //tura jucatorului 2
        int alegere;
        alegere = rand() % 2;
        if (alegere == 0) {
            scor2 += v[start];
            start++;
            jucator2 += 'S';
            std::cout << " 2S ";
        } else {
            scor2 += v[end];
            end--;
            jucator2 += 'D';
            std::cout << " 2D ";
        }
    }
}

void bucla_de_joc_maxim_tehnica2() {

    srand(static_cast<unsigned int>(time(nullptr)));
    int start;
    start = 1;
    int end;
    end = n;
    scor1 = 0;
    scor2 = 0;
    jucator1 = "";
    jucator2 = "";

    int poz_pare = 0;
    int poz_imp = 0;
    for (int i = 1; i <= n; i++)
        if (i % 2)
            poz_imp += v[i];
        else
            poz_pare += v[i];

    while (start < end) {

        if (poz_imp > poz_pare) {
            if (start % 2) {
                scor1 += v[start];
                start++;
                jucator1 += 'S';
            } else {
                scor1 += v[end];
                end--;
                jucator1 += 'D';
            }
        }
        else {
            if (end % 2) {
                scor1 += v[start];
                start++;
                jucator1 += 'S';
            } else {
                scor1 += v[end];
                end--;
                jucator1 += 'D';
            }
        }

        //tura jucatorului 2
        if (v[start] > v[end]) {
            scor2 += v[start];
            start++;
            jucator2 += 'S';
            std::cout << " 2S ";
        } else {
            scor2 += v[end];
            end--;
            jucator2 += 'D';
            std::cout << " 2D ";
        }
    }
}


int main() {

    citire();

    bucla_de_joc_random();

    afisare_random();

    bucla_de_joc_maxim();

    afisare_max();

    bucla_de_joc_random_tehnica2();

    afisare_random_tehnica2();

    bucla_de_joc_maxim_tehnica2();

    afisare_max_tehnica2();

    out.close();

    return 0;
}