#ifndef QUEEN_H
#define QUEEN_H

#include "Pieces.h"
#include <functional>
#include <algorithm>

class Queen: public Pieces{
public:
    Queen();
    Queen(std::pair<int, int> position, Color color, std::pair<int, int> texture);
    Queen(int tableRow, int tableColumn, Color color, int textureRow, int textureColumn);
    std::vector<std::pair<int, int>> getPossibleMoves(Pieces* const pieces[8][8]) const override;
    bool valid(std::pair<int, int> moveCoords, Pieces* const pieces[8][8]) const override;
};

#endif // QUEEN_H
