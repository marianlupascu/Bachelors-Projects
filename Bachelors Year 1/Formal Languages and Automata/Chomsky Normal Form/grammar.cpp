#include "grammar.h"

std::istream& operator>> (std::istream& in, gramatica& gram) {

    int nr_prod, poz_despartire;;
    in >> nr_prod;
    std::string linie;
    char mychar;
    std::set < std::string > myset;
    for (int i = 1; i <= nr_prod; i++) {
        in >> linie;
        mychar = linie[0];
        gram.alfabet.insert(mychar);
        poz_despartire = linie.find("->");
        linie = linie.substr(poz_despartire + 2, linie.length());
        for (int l = 0; l < linie.length(); l++)
            if (linie[l]!='|')
                gram.alfabet.insert(linie[l]);
        int poz;

        while (linie.length()) {
            poz = linie.find("|");
            if (poz > linie.length()) {
                myset.insert(linie);
                linie = "";
            }
            else {
                myset.insert(linie.substr(0, poz));
                linie = linie.substr(poz+1, linie.length());
            }
        }
        gram.G.push_back(std::make_pair(mychar, myset));
        myset.clear();
    }

    return in;
}

std::ostream& operator<< (std::ostream& out, const gramatica& gram) {

    for (int i = 0; i < gram.G.size(); i++) {
        out << gram.G[i].first << " -> " ;
        for (std::set< std::string >::iterator it=gram.G[i].second.begin(); it!=gram.G[i].second.end(); ++it) {
            if (it==gram.G[i].second.begin())
                out << *it;
            else
                out << " | " << *it;
        }
        out << '\n';
    }
    return out;
}

void gramatica::remove_null_productions() {

    for (int i = 0; i < G.size(); i++) {
        for (std::set< std::string >::iterator it=G[i].second.begin(); it!=G[i].second.end(); ++it) {
            if(*it == "_") {
                for (int j = 0; j < G.size(); j++) {
                    for (std::set< std::string >::iterator it2=G[j].second.begin(); it2!=G[j].second.end(); ++it2) {
                        std::string copie = *it2;
                        for (int k = 0; k < copie.length(); k++) {
                            if (copie[k] == G[i].first){
                                copie.erase(copie.find(G[i].first),1);
                                G[j].second.insert(copie);
                                k = 0;
                            }
                        }
                    }
                }
                G[i].second.erase(it);
                it=G[i].second.begin();
            }
        }
    }
}

void gramatica::remove_renaming_productions() {

    for (int i = 0; i < G.size(); i++) {
        for (std::set< std::string >::iterator it=G[i].second.begin(); it!=G[i].second.end(); ++it) {
            if ((*it).length()==1 && (*it)[0]<='Z' && (*it)[0]>='A') {
                for (int j = 0; j < G.size(); j++) {
                    if (G[j].first == (*it)[0]) {
                        for (std::set< std::string >::iterator it2=G[j].second.begin(); it2!=G[j].second.end(); ++it2) {
                            G[i].second.insert(*it2);
                        }
                    }
                }
                G[i].second.erase(it);
                it=G[i].second.begin();
            }
        }
    }
}

void gramatica::replace_long_productions() {

    for (int i = 0; i < G.size(); i++) {
        for (std::set< std::string >::iterator it=G[i].second.begin(); it!=G[i].second.end(); ++it) {
            if ((*it).length()>2) {
                std::string de_inlocuit = *it;
                char nou = generare_simbol();
                std::string inlocuiesc;
                inlocuiesc.push_back(de_inlocuit[0]);
                inlocuiesc.push_back(nou);
                alfabet.insert(nou);
                std::set <std::string> set_nou;
                set_nou.insert((*it).substr(1, (*it).length()));

                 for (int j = 0; j < G.size(); j++) {
                    for (std::set< std::string >::iterator it2=G[j].second.begin(); it2!=G[j].second.end(); ++it2) {
                        if(*it2 == de_inlocuit) {
                            G[j].second.insert(inlocuiesc);
                            G[j].second.erase(*it2);
                            it2=G[j].second.begin();
                        }
                    }
                 }
                G.push_back(std::make_pair(nou, set_nou));
                it=G[i].second.begin();
            }
        }
    }
}

bool continut_mixt(std::string str) { //verifica daca in stringul dat exista litere mari si mici

    for (int i = 1; i < str.length(); i++) {
        if ((str[i]>='A' && str[i]<='Z' && str[0]>='a' && str[0]<='z') || (str[i]>='a' && str[i]<='z' && str[0]>='A' && str[0]<='Z'))
            return true;
    }
    return false;
}

void gramatica::replace_combined_right_hand_sides() {

    for (int i = 0; i < G.size(); i++) {
        for (std::set< std::string >::iterator it=G[i].second.begin(); it!=G[i].second.end(); ++it) {
            if (continut_mixt(*it)) {
                for (int k = 0; k < (*it).length(); k++) {
                    int len = 0;
                    std::string str_nou;
                    while ((*it)[k]>='A' && (*it)[k]<='Z')
                        k++;
                    while ((*it)[k+len]>='a' && (*it)[k+len]<='z') {
                        str_nou.push_back((*it)[k+len]);
                        len++;
                    }
                    std::string de_inlocuit = *it;
                    char nou = generare_simbol();
                    alfabet.insert(nou);
                    std::string inlocuiesc = (*it).substr(0, k);
                    inlocuiesc.push_back(nou);
                    inlocuiesc+=((*it).substr(k+len, (*it).length()));

                    std::set <std::string> set_nou;
                    set_nou.insert((*it).substr(k, k+len));

                     for (int j = 0; j < G.size(); j++) {
                        for (std::set< std::string >::iterator it2=G[j].second.begin(); it2!=G[j].second.end(); ++it2) {
                            if(*it2 == de_inlocuit) {
                                G[j].second.insert(inlocuiesc);
                                G[j].second.erase(*it2);
                                it2=G[j].second.begin();
                            }
                        }
                     }
                    G.push_back(std::make_pair(nou, set_nou));
                    it=G[i].second.begin();
                    k+=len;
                }
            }
        }
    }
}

void gramatica::Transform_into_Chomsky_Normal_Form() {

    try {
    remove_null_productions();
    remove_renaming_productions();
    replace_long_productions();
    replace_combined_right_hand_sides();
    }
    catch(std::string str) {
        std::cerr << str << '\n';
    }
    catch(...) {
        std::cerr << "default exception\n";
    }
}

char gramatica::generare_simbol() const {

    bool aparitie[CHAR_MAX] = {false};
    for (std::set< char >::iterator it=alfabet.begin(); it!=alfabet.end(); ++it) {
        aparitie[*it - 'A'] = true;
    }
    for (int i = 0; i <= 'Z'-'A'; i++)
        if (!aparitie[i])
            return (char)(i+'A');
    throw "Alfabetul sigma al gramaticii este saturat";
}
