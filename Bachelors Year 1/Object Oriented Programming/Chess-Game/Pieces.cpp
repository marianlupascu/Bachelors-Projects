#include "Pieces.h"
#include <SDL_image.h>
#include <iostream>
#include "Variables.h"
#include <vector>
#include <utility>

Pieces::Pieces(){}

/*Pieces::Pieces(std::pair < int, int > table, Color color, std::pair < int, int > texture){

    m_pozition = table;
    m_color = color;

    m_alive = true;
    m_selected = false;
    m_moved = false;
    m_texture_aux = texture; // * o constanta specifica pozei de unde se ia piesa respectiva;
    m_tableCorner.x = tableColumn;
    m_tableCorner.y = tableRow;
    m_textureCorner.x = textureColumn;
    m_textureCorner.y = textureHeight;
}*/

Pieces::Pieces( int tableRow, int tableColumn, Color color, int textureRow, int textureColumn){

    m_pozition.first = tableRow;
    m_pozition.second = tableColumn;
    m_color = color;

    m_alive = true;
    m_selected = false;
    m_moved = false;
    m_texture_aux.first = textureRow; // * o constanta specifica pozei de unde se ia piesa respectiva;
    m_texture_aux.second = textureColumn; // la fel;
    m_tableCorner.x = tableColumn;
    m_tableCorner.y = tableRow;
    m_textureCorner.x = textureColumn;
    m_textureCorner.y = textureRow;
}

Pieces::~Pieces(){}

Pieces::sign(Color color){

    if(color == WHITE)
        return 1;
    return -1;
}

std::pair < int, int > Pieces::Get_King_Pozition( Pieces::Color color, Pieces* const ChessPieces[8][8]) const {
    for(int i = 0; i < 8; i++)
        for(int j = 0; j < 8; j++)
            if(ChessPieces[i][j] != NULL)
                if(ChessPieces[i][j] -> getType() == Pieces::KING && ChessPieces[i][j] -> getColor() == color)
                    return std::make_pair(i, j);
}
