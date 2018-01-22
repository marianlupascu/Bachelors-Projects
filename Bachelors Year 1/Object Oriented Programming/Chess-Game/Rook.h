#ifndef ROOK_H_INCLUDED
#define ROOK_H_INCLUDED
#include "Pieces.h"

class Rook:public Pieces{

public:
    Rook ( );
    Rook ( std::pair < int, int >, Color, std::pair < int, int >);
    Rook ( int, int, Color, int, int);
    bool valid ( std::pair < int, int >, Pieces* const [][8] ) const;
    std::vector < std::pair < int, int > > getPossibleMoves(Pieces* const [][8] ) const;
};

#endif // ROOK_H_INCLUDED
