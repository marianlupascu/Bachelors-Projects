#ifndef PAWN_H
#define PAWN_H

#include "Pieces.h"
#include <algorithm>

class Pawn: public Pieces{
public:
    Pawn();
    Pawn(std::pair<int, int> position, Color color, std::pair<int, int> texture);
    Pawn(int tableRow, int tableColumn, Color color, int textureRow, int textureTable);
    ~Pawn();
    std::vector<std::pair<int, int>> getPossibleMoves(Pieces* const pieces[][8]) const override;
    bool valid(std::pair<int, int> moveCoords, Pieces* const pieces[][8]) const override;
};


#endif // PAWN_H
