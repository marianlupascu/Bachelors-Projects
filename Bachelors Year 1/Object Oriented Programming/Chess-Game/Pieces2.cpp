#include "Pieces.h"
#include <SDL_image.h>
#include <iostream>
#include "Variables.h"
#include <vector>
#include <utility>

Pieces::Pieces(){}

Pieces::Pieces(std::pair < int, int > table, Color color, std::pair < int, int > texture, int repeat, int moves ){

    m_pozition = table;
    m_color = color;

    m_alive = true;
    m_selected = false;
    m_moved = false;
    m_repeat = repeat;
    m_moves = moves;
    m_texture_aux = texture; // * o constanta specifica pozei de unde se ia piesa respectiva;
//    m_tableCorner.x = tableColumn;
//    m_tableCorner.y = tableRow;
//    m_textureCorner.x = textureColumn;
//    m_textureCorner.y = textureHeight;
}

Pieces::Pieces( int tableRow, int tableColumn, Color color, int textureRow, int textureColumn, int repeat, int moves ){

    m_pozition.first = tableRow;
    m_pozition.second = tableColumn;
    m_color = color;

    m_alive = true;
    m_selected = false;
    m_moved = false;
    m_repeat = repeat;
    m_moves = moves;
    m_texture_aux.first = textureRow; // * o constanta specifica pozei de unde se ia piesa respectiva;
    m_texture_aux.first = textureColumn; // la fel;
//    m_tableCorner.x = tableColumn;
//    m_tableCorner.y = tableRow;
//    m_textureCorner.x = textureColumn;
//    m_textureCorner.y = textureHeight;
}

Pieces::~Pieces(){}

Pieces::sign(Color color){

    if(color == WHITE)
        return 1;
    return -1;
}
