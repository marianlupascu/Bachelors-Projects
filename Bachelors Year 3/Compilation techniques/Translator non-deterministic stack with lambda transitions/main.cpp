/*
 * 4.Program care simuleaza functionarea unui translator stiva nedeterminist cu lambda-tranzitii. Programul citeste
 * (dintr-un fisier sau de la consola) elementele unui translator stiva nedeterminist cu lambda-tranzitii oarecare
 * (starile, starea initiala, starile finale, alfabetul de intrare, alfabetul de iesire, alfabetul stivei, simbolul
 * initial al stivei, tranzitiile). Programul permite citirea unui nr oarecare de siruri peste alfabetul de intrare
 * al translatorului. Pentru fiecare astfel de sir se afiseaza toate iesirile (siruri peste alfabetul de iesire)
 * corespunzatoare (Atentie! pot exista 0, 1 sau mai multe iesiri pt acelasi sir de intrare).
 */


#include <iostream>
#include <fstream>
#include <set>
#include <vector>
#include <string>
#include <unordered_map>
#include <tuple>
#include <stack>
#include <ctime>

const int tipAcceptare = 2;
/*
 * 1 - stari finale
 * 2 - stiva vida
 * 3 - ambele
 */

std::set<int> states;
std::set<char> inputSymbols;
std::set<char> outputSymbols;
std::set<char> stackSymbols;
int initialState;
std::set<int> finalStates;
char stackinitialSymbol;
std::stack<char> translatorStack;
std::vector<std::tuple<int , char , char , std::string , std::string , int>> transitionVector;
std::unordered_map<int , std::set<int>> lambdaClosure;
std::unordered_map<int , bool> hasCycles;

std::vector<std::string> split(std::string text , std::string delimiter = " ") {
    std::vector<std::string> rez;
    size_t pos = 0;
    std::string token;
    while ((pos = text.find (delimiter)) != std::string::npos) {
        token = text.substr (0 , pos);
        rez.push_back (token);
        text.erase (0 , pos + delimiter.length ());
    }
    rez.push_back (text);
    return rez;
}

bool verifyString(std::string input , std::set<char> symbols) {
    std::set<char> stringSymbols;
    for (auto const &ch : input) {
        stringSymbols.insert (ch);
    }
    //in continuare trebuie sa vedem ca stringSymbols este inclusa in symbols
    for (char symbol : symbols) {
        stringSymbols.erase (symbol);
    }
    return stringSymbols.empty ();
}

bool equalsOnDim(std::unordered_map<int , std::set<int>> a , std::unordered_map<int , std::set<int>> b) {
    if (a.size () != b.size ())
        return false;
    for (auto const &elem : a) {
        auto got = b.find (elem.first);
        if (got == b.end ())
            return false;
        if (elem.second.size () != got->second.size ())
            return false;
    }
    return true;
}

bool fileRead() {
    std::ifstream f (
            R"(C:\Users\Marian Lupascu\Documents\Documente\FMI\III\SEM II\Tehnici de compilare\Translator stiva nedeterminist cu lambda-tranzitii\LNFA.definition)");

    //citire stari
    std::string statesString;
    getline (f , statesString);
    std::vector<std::string> statesVector = split (statesString);
    for (const auto &state : statesVector) {
        ::states.insert (std::stoi (state));
    }

    //citire alfabet de intrare
    std::string inputSymbolsString;
    getline (f , inputSymbolsString);
    std::vector<std::string> inputSymbols = split (inputSymbolsString);
    for (const auto &inputSymbol : inputSymbols) {
        ::inputSymbols.insert (inputSymbol.at (0));
    }
    ::inputSymbols.insert ('_');

    //citire alfabet de iesire
    std::string outputSymbolsString;
    getline (f , outputSymbolsString);
    std::vector<std::string> outputSymbols = split (outputSymbolsString);
    for (const auto &outputSymbol : outputSymbols) {
        ::outputSymbols.insert (outputSymbol.at (0));
    }
    ::outputSymbols.insert ('_');

    //citire alfabetul stivei
    std::string stackSymbolsString;
    getline (f , stackSymbolsString);
    std::vector<std::string> stackSymbols = split (stackSymbolsString);
    for (const auto &stackSymbol : stackSymbols) {
        ::stackSymbols.insert (stackSymbol.at (0));
    }
    ::stackSymbols.insert ('_');

    //citire starea initiala
    f >> initialState;
    f.get ();

    //verific ca starea initiala sa fie in lista de stari
    auto it = states.find (initialState);
    if (it == states.end ()) {
        std::cout << "Starea initiala nu se gaseste in lista de stari\n";
        return false;
    }

    //citire starile finale
    std::string finalStatesString;
    getline (f , finalStatesString);
    std::vector<std::string> finalStates = split (finalStatesString);
    for (const auto &finalState : finalStates) {
        ::finalStates.insert (std::stoi (finalState));
    }

    //verific ca starile finale sa se gaseasca in lista de stari
    for (const auto &finalState : finalStates) {
        auto it = states.find (std::stoi (finalState));
        if (it == states.end ()) {
            std::cout << "Starea finala " << finalState << " nu se gaseste in lista de stari\n";
            return false;
        }
    }

    //citire sibolul initial al stivei
    f >> stackinitialSymbol;
    ::stackSymbols.insert (stackinitialSymbol);
    translatorStack.push (stackinitialSymbol);
    f.get ();

    //citire functie de tranzitie
    int iState , fState;
    char symbolIn , stackSymbol;
    std::string stringSymbolOut , stringStackOut;
    while (f >> iState >> symbolIn >> stackSymbol >> stringStackOut >> stringSymbolOut >> fState) {
        transitionVector.emplace_back (iState , symbolIn , stackSymbol , stringStackOut , stringSymbolOut , fState);
    }

    //verific ca functia de tranzitie sa fie in regula
    for (const auto &el : transitionVector) {
        auto iState = ::states.find (std::get<0> (el));
        auto symbolIn = ::inputSymbols.find (std::get<1> (el));
        auto stackSymbol = ::stackSymbols.find (std::get<2> (el));
        auto fState = ::states.find (std::get<5> (el));

        if (iState == ::states.end ()) {
            std::cout << "Functia de tranzitie nu este buna. Starea " << std::get<0> (el)
                      << " nu exista in definitia masinii.\n";
            return false;
        }
        if (fState == ::states.end ()) {
            std::cout << "Functia de tranzitie nu este buna. Starea " << std::get<5> (el)
                      << " nu exista in definitia masinii.\n";
            return false;
        }
        if (symbolIn == ::inputSymbols.end ()) {
            std::cout << "Functia de tranzitie nu este buna. Simbolul " << std::get<1> (el)
                      << " nu exista in definitia masinii.\n";
            return false;
        }
        if (stackSymbol == ::stackSymbols.end ()) {
            std::cout << "Functia de tranzitie nu este buna. Simbolul " << std::get<2> (el)
                      << " nu exista in definitia masinii.\n";
            return false;
        }
        if (!verifyString (std::get<3> (el) , ::stackSymbols)) {
            std::cout << "Functia de tranzitie nu este buna. Stringul " << std::get<3> (el)
                      << " contine caractere care nu se afla in definitia masinii.\n";
            return false;
        }
        if (!verifyString (std::get<4> (el) , ::outputSymbols)) {
            std::cout << "Functia de tranzitie nu este buna. Stringul " << std::get<4> (el)
                      << " contine caractere care nu se afla in definitia masinii.\n";
            return false;
        }
    }
    return true;
}

void setHasCycles() {
    for (auto &x: states) {
        hasCycles[ x ] = false;
    }
    for (auto &x: transitionVector) {
        if (std::get<0> (x) == std::get<5> (x))
            hasCycles[ std::get<0> (x) ] = true;
    }
}

std::stack<char> completeStack(std::stack<char> input , std::string str) {
    if (str[ 0 ] == '_') return input;
    for (const auto &ch : str) {
        input.push (ch);
    }
    return input;
}

std::string completeString(std::string input , std::string str) {
    if (str[ 0 ] == '_') return input;
    return input += str;
}

std::unordered_map<int , std::set<int>> getLambdaClosure() {
    std::unordered_map<int , std::set<int>> closure;

    //pun in inchidere nodul curent
    for (int state : states) {
        closure[ state ].insert (state);
    }

    //pun in inchidere nodulurile la care are muchii cu lambda directe
    for (auto &x: transitionVector) {
        if (std::get<1> (x) == '_')
            closure[ std::get<0> (x) ].insert (std::get<5> (x));
    }

    std::unordered_map<int , std::set<int>> closure2;
    while (true) {
        for (auto const &elem : closure) {
            for (auto it = elem.second.begin (); it != elem.second.end (); ++it) {
                auto oppositeSet = closure.find (*it);
                for (int x : oppositeSet->second) {
                    closure2[ elem.first ].insert (x);
                }
            }
        }
        if (equalsOnDim (closure , closure2))
            break;
        closure = closure2;
        closure2.clear ();
    }

    std::cout << "Lambda inchiderea este:\n";
    for (auto &x: closure) {
        std::cout << x.first << ": ";
        for (int it : x.second) {
            std::cout << it << " ";
        }
        std::cout << '\n';
    }

    return closure;
}

std::string stackToString(std::stack<char> stack) {
    std::string str = "";
    while (!stack.empty ()) {
        str += stack.top ();
        stack.pop ();
    }
    return str;
}

void seePosibleStates(std::set<std::tuple<int , std::stack<char> , std::string> > setOfPossibleStates) {
    std::cout << '\n';
    for (const auto &el : setOfPossibleStates) {
        std::cout << std::get<0> (el) << ": " << stackToString (std::get<1> (el)) << "  " << std::get<2> (el) << '\n';
    }
}

std::set<std::tuple<int , std::stack<char> , std::string> >
simulateWithLambda(std::set<std::tuple<int , std::stack<char> , std::string> > setOfPossibleStates) {
    std::set<std::tuple<int , std::stack<char> , std::string> > newSetOfPossibleStates = setOfPossibleStates;
    for (const auto &setOfPossibleState : setOfPossibleStates) {
        for (const auto &el : transitionVector) {
            if (std::get<0> (el) == std::get<0> (setOfPossibleState) && std::get<1> (el) == '_' &&
                std::get<2> (el) == '_') {
                newSetOfPossibleStates.insert (std::make_tuple (std::get<5> (el) ,
                                                                completeStack (std::get<1> (setOfPossibleState) ,
                                                                               std::get<3> (el)) ,
                                                                completeString (std::get<2> (setOfPossibleState) ,
                                                                                std::get<4> (el))));
            } else if (!(std::get<1> (setOfPossibleState).empty ())) {
                if (std::get<0> (el) == std::get<0> (setOfPossibleState) && std::get<1> (el) == '_' &&
                    std::get<2> (el) == std::get<1> (setOfPossibleState).top ()) {
                    std::stack<char> newStack = std::get<1> (setOfPossibleState);
                    if (!newStack.empty ()) {
                        newStack.pop ();
                        newSetOfPossibleStates.insert (std::make_tuple (std::get<5> (el) ,
                                                                        completeStack (newStack , std::get<3> (el)) ,
                                                                        completeString (
                                                                                std::get<2> (setOfPossibleState) ,
                                                                                std::get<4> (el))));
                    }
                }
            }
        }
    }
    return newSetOfPossibleStates;
}

std::set<std::tuple<int , std::stack<char> , std::string> >
simulateWithChar(std::set<std::tuple<int , std::stack<char> , std::string> > setOfPossibleStates , char ch) {
    std::set<std::tuple<int , std::stack<char> , std::string> > newSetOfPossibleStates;
    for (const auto &setOfPossibleState : setOfPossibleStates) {
        for (const auto &el : transitionVector) {
            if (std::get<0> (el) == std::get<0> (setOfPossibleState) && std::get<1> (el) == ch &&
                std::get<2> (el) == '_') {
                newSetOfPossibleStates.insert (std::make_tuple (std::get<5> (el) ,
                                                                completeStack (std::get<1> (setOfPossibleState) ,
                                                                               std::get<3> (el)) ,
                                                                completeString (std::get<2> (setOfPossibleState) ,
                                                                                std::get<4> (el))));
            } else if (!(std::get<1> (setOfPossibleState).empty ())) {
                if (std::get<0> (el) == std::get<0> (setOfPossibleState) && std::get<1> (el) == ch &&
                    std::get<2> (el) == std::get<1> (setOfPossibleState).top ()) {
                    std::stack<char> newStack = std::get<1> (setOfPossibleState);
                    if (!newStack.empty ()) {
                        newStack.pop ();
                        newSetOfPossibleStates.insert (std::make_tuple (std::get<5> (el) ,
                                                                        completeStack (newStack , std::get<3> (el)) ,
                                                                        completeString (
                                                                                std::get<2> (setOfPossibleState) ,
                                                                                std::get<4> (el))));
                    }
                }
            }
        }
    }
    return newSetOfPossibleStates;
}

std::set<std::tuple<int , std::stack<char> , std::string> > simulateLNFStackTranslator(std::string input) {
    std::set<std::tuple<int , std::stack<char> , std::string> > setOfPossibleStates;
    // setez starea initiala
    setOfPossibleStates.insert (std::make_tuple (initialState , translatorStack , ""));
    seePosibleStates (setOfPossibleStates);

    // fac fill cu funtia de tranzitie la lambdaclosure
    std::set<std::tuple<int , std::stack<char> , std::string> > setOfPossibleStates2 = simulateWithLambda (
            setOfPossibleStates);

    time_t past, now;
    time (&past);
    while (setOfPossibleStates.size () != setOfPossibleStates2.size ()) {
        setOfPossibleStates = setOfPossibleStates2;
        setOfPossibleStates2.clear ();
        setOfPossibleStates2 = simulateWithLambda (setOfPossibleStates);

        time (&now);
        if (difftime(now,past) > 2){
            std::cout << "!!! Atentie avetii cicluri lambda catre aceiasi stare !!!\n";
            break;
        }
    }

    seePosibleStates (setOfPossibleStates);

    for (auto ch:input) {
        setOfPossibleStates = simulateWithChar (setOfPossibleStates , ch);
        seePosibleStates (setOfPossibleStates);

        time (&past);
        setOfPossibleStates2 = simulateWithLambda (setOfPossibleStates);
        while (setOfPossibleStates.size () != setOfPossibleStates2.size ()) {
            setOfPossibleStates = setOfPossibleStates2;
            setOfPossibleStates2.clear ();
            setOfPossibleStates2 = simulateWithLambda (setOfPossibleStates);

            time (&now);
            if (difftime(now,past) > 2){
                std::cout << "!!! Atentie avetii cicluri lambda catre aceiasi stare !!!\n";
                break;
            }
        }

        seePosibleStates (setOfPossibleStates);
    }
    return setOfPossibleStates;
}

std::vector<std::string> getResult(std::set<std::tuple<int , std::stack<char> , std::string> > setOfPossibleStates) {
    std::vector<std::string> result;
    switch (tipAcceptare) {
        case 1:
            for (const auto &el :setOfPossibleStates) {
                if (finalStates.find (std::get<0> (el)) != finalStates.end ()) {
                    result.push_back (std::get<2> (el));
                }
            }
            break;
        case 2:
            for (const auto &el :setOfPossibleStates) {
                if (std::get<1> (el).empty ()) {
                    result.push_back (std::get<2> (el));
                }
            }
            break;
        case 3:
            for (const auto &el :setOfPossibleStates) {
                if (std::get<1> (el).empty () && finalStates.find (std::get<0> (el)) != finalStates.end ()) {
                    result.push_back (std::get<2> (el));
                }
            }
            break;
        default:;
    }
    return result;
}

void seeResult(std::vector<std::string> result) {
    std::cout << '\n' << "Rezulat: \n";
    if (result.empty ()) {
        std::cout << "Nu exista rezulate";
    } else
        for (const auto &el : result)
            std::cout << el << '\n';
}

int main() {
    if (fileRead ()) {
        setHasCycles ();
        lambdaClosure = getLambdaClosure ();
        std::set<std::tuple<int , std::stack<char> , std::string> > setOfPossibleStates = simulateLNFStackTranslator (
                "ababab");
        seeResult (getResult (setOfPossibleStates));
    }

    return 0;
}

/*
 Test#1
1 2 3 4
a b c
d e f
x y z
1
4
$
1 b $ $x de 2
1 a $ $xy f 2
1 b _ xx ff 3
2 _ _ x _ 1
2 a $ _ _ 4
2 _ x z _ 3
3 _ y xyy dd 4
3 a _ _ ee 4
4 b _ y fe 1
3 _ x yy e 3

 Test#2
0 1 2 3
a b c
e f
x y z
0
2 3
$
0 _ $ $x ff 1
0 a _ x f 3
1 _ y _ e 0
1 _ x _ e 1
2 b $ $ e 1
2 b _ yy ff 1
1 b x y f 2
1 a y yy e 2
2 _ _ _ _ 3
3 a x xx e 1

 Test#3
abb
0 1 2
a b
e f
x y
0
0
$
0 a $ $x e 1
0 _ _ _ _ 1
1 _ _ _ e 0
1 _ x _ f 2
2 b _ xx ee 1
2 _ x _ ff 0
 */