#include <iostream>
#include <fstream>
#include <vector>
#include <limits>

const int DIMMAX = 1000;

int n;
std::vector<int> v;
int dp[DIMMAX][DIMMAX]; // diferenta cea mai pesimista cu care jucatorul 1 este in fata jucatorului 2, daca 2
// joaca prost atunci diferenta este mai mare decat de[i][j]

std::ofstream fout(
        R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab PD\5-PD\cmake-build-debug\date.out)");

void citire() {

    std::ifstream fin(
            R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab PD\5-PD\cmake-build-debug\date.in)");

    fin >> n;
    int x;
    v.push_back(0);
    for (int i = 0; i < n; i++) {
        fin >> x;
        v.push_back(x);
    }

    fin.close();
}

void PD() {

    for (int i = 1; i <= n; i++)
        dp[i][i] = v[i];

    for (int diag = 1; diag < n; diag++) {
        for (int i = 1; i <= n - diag; i++) {
            int j = diag + i;
            dp[i][j] = std::max(v[i] - dp[i+1][j], v[j] - dp[i][j-1]);
        }
    }
}

void start() {
    std::cout << "Vectorul de numere este : \n";
    for(int i = 1; i <=n; i++)
        std::cout << v[i] << " ";
    std::cout <<'\n';
    int count = n;
    int i=1, j=n;
    int scor1 = 0, scor2 = 0;
    bool  tura = true;
    while(count) {
        if(tura) {
            if(dp[i+1][j] > dp[i][j-1]) {
                std::cout << "Am ales right (" << v[j] << ")\n";
                scor1 += v[j];
                j--;
            } else {
                std::cout << "Am ales left (" << v[i] << ")\n";
                scor1 += v[i];
                i++;
            }
            std::cout << "Momentan sunt in fata ta cu: " << scor1 - scor2 << " puncte\n";
        }
        else {
            std::cout << "Este tura ta, te rog alege - ";
            char chs;
            std::cin >> chs;
            if(chs == 'r') {
                scor2 += v[j];
                std::cout << "Ai ales (" << v[j] << ")\n";
                j--;
            }
            if(chs == 'l') {
                scor2 += v[i];
                std::cout << "Ai ales (" << v[i] << ")\n";
                i++;
            }
        }
        tura = !tura;
        --count;
    }
    std::cout << "Momentan sunt in fata ta cu: " << scor1 - scor2 << " puncte\n";
    fout << '\n';
}

void afisare() {

    for(int i = 1; i <= n; i++) {
        for(int j = 1; j <=n; j++){
            fout << dp[i][j] << " ";
        }
        fout << '\n';
    }
}

int main() {

    citire();

    PD();

    afisare();

    start();

    return 0;
}







//problema joculet de pe infoarena http://www.infoarena.ro/problema/joculet

//#include <fstream>
//
//#define  DIMMAX 2001
//
//using namespace std;
//
//ifstream fin("joculet.in");
//ofstream fout("joculet.out");
//
//long long n, i, j, d[2][DIMMAX], v[DIMMAX];
//
//int main() {
//    fin >> n;
//    for (i = 1; i <= n; i++)
//        fin >> v[i];
//    ///D[i][j] = cea mai buna suma pe care la o mutare o poate obtine daca au mai ramas elementele intre i si j
//    d[0][n] = v[n];
//    for (i = n - 1; i > 0; i--) {
//        for (j = i; j <= n; j++) {
//            if (i == j)
//                d[1][i] = v[i];
//            else {
//                d[1][j] = max(max(v[i] - d[0][j], v[j] - d[1][j - 1]), v[i] + v[j] - d[0][j - 1]);
//            }
//        }
//        for (j = i; j <= n; j++)
//            d[0][j] = d[1][j];
//    }
//    fout << d[1][n];
//    return 0;
//}