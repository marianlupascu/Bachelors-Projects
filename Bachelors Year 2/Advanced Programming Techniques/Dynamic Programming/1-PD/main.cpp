#include <iostream>
#include <fstream>
#include <unordered_map>
#include <vector>

std::vector<std::string> cuv;
std::vector<std::pair<int, int>> result;
std::vector<int> hash;

std::ofstream out(
        R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab PD\1-PD\date.out)");

int code(char c1, char c2) {
    return (c1 - 'a') * ('z' - 'a' + 1) + c2 - 'a';
}

std::string decode(int c) {
    std::string str;
    int second = (c % ('z' - 'a' + 1));
    int first = c - second;
    first = first / ('z' - 'a' + 1) + 'a';
    second += 'a';
    str.push_back(static_cast<char> (first));
    str.push_back(static_cast<char> (second));
    return str;
}

void citire() {
    std::fstream fin(
            R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab PD\1-PD\date.in)");

    while (!fin.eof()) {
        std::string aux;
        fin >> aux;
        if (aux.length() < 2)
            throw (static_cast<std::string> ("Exista cuvinte de lungime mai mica ca 2."));
        cuv.push_back(aux);
    }

    fin.close();
}

void procesare() {
    int i = 0;
    for (const auto &it : cuv) {
        std::string str = (std::string) it;
        int cod_start = code(str[0], str[1]);
        int cod_end = code(str[str.length() - 2], str[str.length() - 1]);
        if (hash[cod_start] >= 0) {
            std::string aux = cuv[hash[cod_start]];
            //std::cout <<str << " " << aux <<'\n';
            char fisrt = aux[0];
            char second = aux[1];
            result[cod_start] = std::make_pair(result[code(fisrt, second)].first + 1, hash[cod_start]);
            hash[cod_end] = i;
        } else {
            result[cod_start] = std::make_pair(1, -1);
            hash[cod_end] = i;
        }
        i++;
    }
    int max = 0, index = 0;
    for (int i = 0; i < result.size(); i++) {
        if (result[i].first > max) {
            max = result[i].first;
            index = i;
        }
    }
    int salt = result[index].second;
    std::vector<int> inv;
    for (int i = salt; i < cuv.size(); i++) {
        std::string str = (std::string) cuv[i];
        int cod = code(str[0], str[1]);
        if (cod == index) {
            inv.push_back(i);
            break;
        }
    }
    inv.push_back(salt);
    while (salt >= 0) {
        salt = result[code(cuv[salt][0], cuv[salt][1])].second;
        inv.push_back(salt);
    }
    for (int i = inv.size() - 2; i >= 0; i--) {
        out << cuv[inv[i]] << " ";
    }
}

void afisare() {

    for (int i = 0; i < result.size(); i++) {
        if (result[i].first) {
            std::cout << i << " " << decode(i) << " " << result[i].first << " " << result[i].second << '\n';
        }
    }
}

int main() {

    try {
        citire();

        result.assign(static_cast<unsigned int>(code('z', 'z') + 1), std::make_pair(0, 0));
        hash.assign(static_cast<unsigned int>(code('z', 'z') + 1), -1);

        procesare();

        afisare();
    }
    catch (std::string s) {

        std::cerr << s << '\n';
    }
    catch (...) {
        std::cerr << "Defaul error\n";
    }

    return 0;
}