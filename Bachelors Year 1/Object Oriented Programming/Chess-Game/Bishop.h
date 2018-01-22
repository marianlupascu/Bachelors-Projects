#ifndef BISHOP_H_INCLUDED
#define BISHOP_H_INCLUDED

#include "Pieces.h"
#include <algorithm>
#include <functional>

class Bishop: public Pieces{
private:

public:
    Bishop();
    Bishop(std::pair<int, int> position, Color color, std::pair<int, int> texture);
    Bishop(int tableRow, int tableColumn, Color color, int textureRow, int textureColumn);
    ~Bishop();
    bool valid(std::pair<int, int> moveCoords, Pieces* const pieces[8][8]) const override;
    std::vector<std::pair<int, int>> getPossibleMoves(Pieces* const pieces[8][8]) const override;
};

#endif // BISHOP_H_INCLUDED
