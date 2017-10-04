#ifndef GAUSS_H_INCLUDED
#define GAUSS_H_INCLUDED
#include <iostream>
#include <iomanip>
#include <vector>
#include <utility>
#include <stdexcept>

const int DIMMAX = 10;

typedef std::pair < int, int > fractie;

class FormaPatratica
{
private:
    int dim;
    int m[DIMMAX][DIMMAX];
public:
    FormaPatratica ( );
    FormaPatratica ( int );
    FormaPatratica ( int, int* [] );
    friend std::istream& operator>> ( std::istream&, FormaPatratica& );
    friend std::ostream& operator<< ( std::ostream&, const FormaPatratica& );
    bool Este_Forma_Patratica () const;
    std::vector < std::pair < fractie, std::vector < fractie > > > Eliminare_Gauss( ) const;
    std::pair < fractie, std::vector < fractie > > Eliminare_Gauss_pe_linii( int, fractie[][DIMMAX] ) const;
    void Afisare_forma_Canonica( std::ostream& ) const;
};

#endif // GAUSS_H_INCLUDED
