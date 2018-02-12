#include <iostream>
#include <fstream>
#include <algorithm>
#include <vector>
#include <queue>
#include <iomanip>

const int DIMMAX = 1000;

std::vector<int> g[DIMMAX];
int n;
int tata[DIMMAX];
int culoare[DIMMAX];

std::ofstream out(
        R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab Greedy\2\date.out)");

int citire() {

    std::ifstream fin(
            R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab Greedy\2\date.in)");
    fin >> n;

    int verif[n+1] = {0};

    int a, b;
    for (int i = 1; !fin.eof(); i++) {
        fin >> a >> b;
        g[a].push_back(b);
        g[b].push_back(a);
        verif[a]++;
        verif[b]++;
        tata[b] = a;
    }

    for (int i = 1; i <= n; i++) {
        if(!verif[i]) {
            std::cerr << "Oh dear, something went wrong :( . Please check again the input.\n";
            return errno;
        }
    }

    fin.close();
}

int BFS(int start) /*O(m+n) -> O(n)*/{

    int viz[n + 1] = {0};
    int nod;
    std::queue<int> c;
    c.push(start);
    viz[start] = 1;
    culoare[start] = 1;
    while (!c.empty()) {
        nod = c.front();
        c.pop();
        for (int i = 0; i < g[nod].size(); i++) {
            if (!viz[g[nod][i]]) {
                c.push(g[nod][i]);
                culoare[g[nod][i]] = !culoare[nod];
                viz[g[nod][i]] = 1;
                tata[g[nod][i]] = nod;

            } else {
                if (culoare[g[nod][i]] == culoare[nod]) {
                    return 0;
                }
            }
        }
    }
    return 1;
}

int afisare_cu_colorare() /*O(n)*/{

    int partitia1 = 0, partitia2 = 0;

    if (BFS(1)) {
        std::cout << "Partitia 1: \n";
        for (int i = 1; i <= n; i++)
            if (culoare[i]) {
                std::cout << std::setw(3) << i;
                partitia1++;
            }
        std::cout << '\n';
        std::cout << "Partitia 2: \n";
        for (int i = 1; i <= n; i++)
            if (!culoare[i]) {
                std::cout << std::setw(3) << i;
                partitia2++;
            }
    } //O(n)
    else {
        std::cerr << "Oh dear, something went wrong :( . Please check again the input.\n";
        return errno;
    }

    if(partitia1 > partitia2) {
        out << std::setw(3) << partitia1 << '\n';
        for (int i = 1; i <= n; i++)
            if (culoare[i])
                out << std::setw(3) << i;
    }
    else {
        out << std::setw(3) <<partitia2 <<'\n';
        for (int i = 1; i <= n; i++)
            if (!culoare[i])
                out << std::setw(3) << i;
    }

}

bool viz[DIMMAX] = {false};
bool marcat[DIMMAX] = {false};
std::vector <int> list;
int card =0 ;

void DFS(int start) {
    viz[start] = true;

    for (int j : g[start]) {
        if (!viz[j]) {
            DFS(j);
        }
    }

    if(!marcat[start]) {
        list.push_back(start);
        marcat[tata[start]] = true;
        marcat[start] = true;
        card ++;
    }
}

void afisare_cu_subarbori() {
    out<<"\n\n\n";
    DFS(1);
    out <<"Multimea realizata pe cazul 2 are cardinal = " << list.size() <<" si este :\n";
    for (int i : list)
        out<< std::setw(3) << i;
    out << '\n';
}

int main() {

    citire();

    afisare_cu_colorare();

    afisare_cu_subarbori();

    out.close();

    return 0;
}