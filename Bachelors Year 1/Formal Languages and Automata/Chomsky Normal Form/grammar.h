#ifndef GRAMMAR_H_INCLUDED
#define GRAMMAR_H_INCLUDED
#include <iostream>
#include <vector>
#include <set>
#include <string>
#include <utility>

class gramatica{

private:
    std::vector < std::pair < char, std::set < std::string > > > G;
    std::set < char > alfabet;

public:
    gramatica() {}
    friend std::istream& operator>> (std::istream&, gramatica&);
    friend std::ostream& operator<< (std::ostream&, const gramatica&);
    void remove_null_productions();
    void remove_renaming_productions();
    void replace_long_productions();
    void replace_combined_right_hand_sides();

    void Transform_into_Chomsky_Normal_Form();

    char generare_simbol() const;
};

#endif // GRAMMAR_H_INCLUDED
