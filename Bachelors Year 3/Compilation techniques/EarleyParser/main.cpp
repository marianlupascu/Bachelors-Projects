#include <iostream>
#include <fstream>
#include <set>
#include <vector>
#include <unordered_map>
#include <string>
#include <tuple>

using namespace std;

unordered_map<char , set<string>> grammarSet;
unordered_map<char , vector<string>> grammar;
unordered_map<char , bool> nullable;
string word;

string trim(const string &str) {
    size_t first = str.find_first_not_of (' ');
    if (string::npos == first) {
        return str;
    }
    size_t last = str.find_last_not_of (' ');
    return str.substr (first , (last - first + 1));
}

bool fileRead() {
    std::ifstream f (
            R"(C:\Users\Marian Lupascu\Documents\Documente\FMI\III\SEM II\Tehnici de compilare\EarleyParser\Grammar.txt)");
    f >> word;
    f.get ();
    string production;
    while (!f.eof ()) {
        getline (f , production);
        if (production.length () == 0)
            continue;
        char firstNonterminal = production[ 0 ];
        nullable[firstNonterminal] = false;
        if (firstNonterminal < 'A' || firstNonterminal > 'Z') {
            cerr << "WARNING: First character from production must be a upper letter\n";
        }

        int pos = production.find ("->");
        if (pos == ::string::npos) {
            cerr << "The production " << production << " no contains '->'\n";
            return false;
        }
        production = trim (production.substr (static_cast<unsigned int>(pos) + 2));
        if(production == "_"){
            nullable[firstNonterminal] = true;
            production = "";
        }
        grammarSet[firstNonterminal].insert(production);
    }

    for(const auto &i : grammarSet)
        for(const auto &j : i.second)
            grammar[i.first].push_back(j);

    return true;
}

vector<set<tuple<char, string , unsigned , unsigned >>> S;

void init(){
    set<tuple<char, string , unsigned , unsigned >> empty;
    for(int i = 0; i <= word.size (); i++) {
        S.push_back (empty);
    }
}

void SCANNER(tuple<char, string , unsigned , unsigned > production, int index){
    char letter = get<1>(production)[get<2>(production)];
    if (letter == word[index]) {
        S[index + 1].insert (make_tuple (get<0>(production), get<1>(production), get<2>(production) + 1, get<3>(production)));
    }
}

void NULLABLE(tuple<char, string , unsigned , unsigned > production, int index){
    if(nullable[get<1>(production)[get<2>(production)]]){
        S[index].insert (make_tuple (get<0>(production), get<1>(production), get<2>(production) + 1, get<3>(production)));
    }
}

void PREDICTOR(tuple<char, string , unsigned , unsigned > production, int index){
    char nonTerminal = get<1>(production)[get<2>(production)];
    for (const auto& i : grammar[nonTerminal]){
        S[index].insert (make_tuple (nonTerminal, i, 0, index));
    }
}

void COMPLETER(tuple<char, string , unsigned , unsigned > production, int index){
    for(auto el: S[get<3>(production)]) {
        if(get<1>(el)[get<2>(el)] == get<0>(production)){
            S[index].insert (make_tuple (get<0>(el), get<1>(el), get<2>(el) + 1, get<3>(el)));
        }
    }
}

void seeS(int index) {
    cout << "S[" << index << "]\n";
    for(auto i : S[index])
        cout << get<0>(i) << " " << get<1>(i) << " " <<get<2>(i) << " " << get<3>(i)<<'\n';
}

bool FINISHED(tuple<char, string , unsigned , unsigned > production) {
    return get<2> (production) == get<1> (production).size ();
}

bool EarleyParser(){
    init ();

    S[0].insert (make_tuple ('F', grammar['F'][0], 0, 0));
    for (int i = 0; i < word.size (); i++) {
        while(true){
            int size = S[i].size ();
            for(auto el: S[i]){
                if(!FINISHED (el)){
                    if(get<1>(el)[get<2>(el)] >= 'A' && get<1>(el)[get<2>(el)] <= 'Z') { //is a nonterminal
                        PREDICTOR (el, i);
                    } else {
                        SCANNER (el, i);
                    }
                } else {
                    COMPLETER (el, i);
                }
                NULLABLE (el, i);
            }
            if(size == S[i].size ())
                break;
        }
        seeS (i);
    }

    int i = word.size ();
    while(true){
        int size = S[i].size ();
        for(auto el: S[i]){
            if(!FINISHED (el)){
                if(get<1>(el)[get<2>(el)] >= 'A' && get<1>(el)[get<2>(el)] <= 'Z') { //is a nonterminal
                    PREDICTOR (el, i);
                } else {
                    SCANNER (el, i);
                }
            } else {
                COMPLETER (el, i);
            }
            NULLABLE (el, i);
        }
        if(size == S[i].size ())
            break;
    }
    seeS (i);

    for(auto e : S[i]) {
        if(get<0>(e) == 'F'){
            cout << "ACCEPT";
            return true;
        }
    }
    cout << "NU ACCEPT";
    return false;
}

int main() {
    fileRead ();

    EarleyParser ();

    return 0;
}

/*
2+3*4
F -> S
S -> S+M
S -> M
M -> M*M
M -> T
T -> 1
T -> 2
T -> 3
T -> 4

aacb
F -> S
S -> aSB
S -> aAAc
A -> cA
A -> _
B -> b

aqswe
F -> S
S -> A
S -> C
A -> B
B -> P
B -> A
A -> N
C -> V
C -> A
C -> B
N -> a
N -> e
P -> w
N -> s
V -> q
N -> t
 */