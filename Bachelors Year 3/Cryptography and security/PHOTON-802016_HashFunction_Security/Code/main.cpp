#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#define N 100000000

using  namespace std;

void generate() {
    ofstream f(R"(/Users/lupascu/Downloads/Reference-Implementation/Code/input.txt)");
    for(long long i = 0; i < N; i++){
        f << "PropozitieRandom" << i << '\n';
        if(i % 100000)
            cout << float(i * 100) / N << "%\n";
    }
}

void duplicate() {
    vector<string> photon;
    photon.emplace_back("6c2bf8cad416a071d11e");
    photon.emplace_back("9cdcc99b9e68cbb273d5");
    photon.emplace_back("22a5a77ccc941ea042cf");
    photon.emplace_back("8e0368802e8a1d1f4c82");
    photon.emplace_back("f41198894e0d8b74a0e8");
    photon.emplace_back("a62e7dea24ac2eb9fee6");
    photon.emplace_back("5d06b6668377b1f656a1");
    photon.emplace_back("ee7276c10429a02deda9");
    photon.emplace_back("eb64cbee5d53640eafc9");
    photon.emplace_back("03ac754af5f6e6072798");
    photon.emplace_back("f9d99e0b5fcb2083a6b9");

    ifstream f(R"(/Users/lupascu/Downloads/Reference-Implementation/Code/output.txt)");
    ofstream o(R"(/Users/lupascu/Downloads/Reference-Implementation/Code/result.txt)");
    string line, lineHash;
    int pos;
    long long i = 0;

    getline(f, line);
    while (!f.eof()) {
        getline(f, line);
        if (line.empty())
            break;
        pos = line.find(":::::");
        lineHash = line.substr(pos + 6);
        //cout << lineHash << '\n';
        for(const auto& str : photon){
            if(str == lineHash){
                o << line << '\n';
            }
        }

        if(i%10000 == 0)
            cout << float(i) / N * 100 << "%\n";
        i++;
    }
}

int main() {
    //generate();
    duplicate();
    return 0;
}