#ifndef PIECESMANAGER_H_INCLUDED
#define PIECESMANAGER_H_INCLUDED
#include "Pieces.h"
#include "Pawn.h"
#include "Rook.h"
#include "Knight.h"
#include "Bishop.h"
#include "Queen.h"
#include "King.h"
#include <vector>
#include <utility>

class PiecesManager{ //Singleton class

private:
    static PiecesManager* instance;
    PiecesManager( );
    Pieces* ChessPieces[8][8];
    bool selected;
    int turn;
    SDL_Point actual_piece;
    SDL_Point last_piece;
    std::vector<std::pair<int,int >> piece_moves;

public:
    static PiecesManager* getInstance( );
    virtual ~PiecesManager();
    void GetPieces( Pieces* Matrix[][8] ) const;
    bool AddPieces( Pieces* piece );
    bool InitPieces(int,int);
    std::vector<std::pair<int,int >> HandleEvent(SDL_Point,int,int);
    bool DeletePieces( std::pair < int, int > );
    bool RevivePieces( std::pair < int, int > );
    bool MovePieces( std::pair < int, int >, std::pair < int, int > );
};

#endif // PIECESMANAGER_H_INCLUDED
