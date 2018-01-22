#ifndef KING_H_INCLUDED
#define KING_H_INCLUDED
#include "Pieces.h"


class King:public Pieces{

public:
    King ( );
    King ( std::pair < int, int >, Color, std::pair < int, int >);
    King ( int, int, Color, int, int);
    bool valid ( std::pair < int, int >, Pieces* const [][8] ) const;
    std::vector < std::pair < int, int > > getPossibleMoves( Pieces* const [][8] ) const;
    bool point_in_chess ( std::pair < int, int >, Pieces* const [][8] ) const;
    bool with_Rook ( std::pair < int, int >, Pieces* const [][8] ) const;
    bool with_Knight ( std::pair < int, int >, Pieces* const [][8] ) const;
    bool with_Bishop ( std::pair < int, int >, Pieces* const [][8] ) const;
    bool with_Queen ( std::pair < int, int >, Pieces* const [][8] ) const;
    bool with_King ( std::pair < int, int >, Pieces* const [][8] ) const;
    bool with_Pawn ( std::pair < int, int >, Pieces* const [][8] ) const;
    bool castling_right ( Pieces* const [][8] ) const;
    bool castling_left ( Pieces* const [][8] ) const;
    bool are_in_chess ( Pieces* const [][8] ) const;
};

#endif // KING_H_INCLUDED
