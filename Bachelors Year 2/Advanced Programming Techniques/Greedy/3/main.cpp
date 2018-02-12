#include <iostream>
#include <fstream>
#include <queue>
#include <utility>
#include <algorithm>

int n;
int h;
std::vector<std::pair<int, int>> inter;
std::vector<std::pair<int, int>> prog;
std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, std::greater<std::pair<int, int>>> pq;

bool cmp(std::pair<int, int> i, std::pair<int, int> j) { return (i.first < j.first); }

void citire() {

    std::ifstream fin(
            R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab Greedy\3\date.in)");

    fin >> n;

    std::pair<int, int> aux;
    for (int i = 1; i <= n; i++) {
        fin >> aux.first >> aux.second;
        inter.push_back(aux);
    }

    fin.close();
}

void afisare() {

    std::ofstream out(
            "C:\\Users\\Maryan\\Documents\\Documents\\FMI\\II\\SEM I\\Tehnici Avansate de Programare\\Laboratoare\\Lab Greedy\\3\\date.out");

    out << h << '\n';
    std::vector<int> sch[h + 1];
    for (auto i:prog) {
        sch[i.second].push_back(i.first);
    }

    for (int i = 1; i <= h; i++) {
        out << i << " : ";
        for (auto j:sch[i])
            out << j << " ";
        out << '\n';
    }

    out.close();
}

int main() {

    citire();

    std::sort(inter.begin(), inter.end(), cmp);

    pq.push(std::make_pair(inter[0].second, 1));
    prog.push_back(std::make_pair(1, 1));
    h++;

    for (int i = 1; i < inter.size(); i++) {
        std::cout << pq.top().first << " " << h << '\n';
        if (inter[i].first >= pq.top().first) {
            prog.push_back(std::make_pair(i + 1, pq.top().second));
            std::pair<int, int> aux = pq.top();
            pq.pop();
            aux.first = inter[i].second;
            pq.push(aux);
        } else {
            h++;
            pq.push(std::make_pair(inter[i].second, h));
            prog.push_back(std::make_pair(i + 1, h));
        }
    }

    afisare();

    return 0;
}
