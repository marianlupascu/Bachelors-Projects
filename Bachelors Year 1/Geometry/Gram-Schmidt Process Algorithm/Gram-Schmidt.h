#ifndef GRAM_SCHMIDT_H_INCLUDED
#define GRAM_SCHMIDT_H_INCLUDED
#include <iostream>
#include <iomanip>
#include <vector>
#include <utility>
#include <stdexcept>
#include <cmath>

const int DIMMAX = 25;

typedef std::pair < int, int > fractie;

class baza
{
private:
    int dim;
    std::vector < fractie > baz[DIMMAX];
    std::vector < fractie > ort[DIMMAX];
public:
    baza ( );
    baza ( int );
    baza ( int, std::vector < fractie > [] );
    friend std::istream& operator>> ( std::istream&, baza& );
    friend std::ostream& operator<< ( std::ostream&, const baza& );
    bool Este_Baza ( ) const;
    void Ortonormalizare_Gram_Schmidt( );
    fractie Produs_scalar ( std::vector < fractie >, std::vector < fractie > ) const;
};

#endif // GRAM_SCHMIDT_H_INCLUDED
