#include "Rook.h"
#include "King.h"

Rook::Rook () {}

/*Rook::Rook ( std::pair < int, int > table, Color color, std::pair < int, int > texture) :
    Pieces( table, color, texture) { type = Pieces::ROOK; }
*/
Rook::Rook ( int tableRow, int tableColumn, Color color, int textureRow, int textureColumn) :
    Pieces(tableRow, tableColumn, color, textureRow, textureColumn) { type = Pieces::ROOK; }

bool Rook::valid ( std::pair < int, int > mPair, Pieces* const ChessPiece[8][8]) const {
    std::pair <int, int> King_poz = Get_King_Pozition(getColor(), ChessPiece);

    bool in_chess = false;
    King* k;

    if(ChessPiece[King_poz.first][King_poz.second] -> getType() == Pieces::KING) {
        if( k = dynamic_cast<King*>(ChessPiece[King_poz.first][King_poz.second])) {
            if(k -> are_in_chess(ChessPiece))
                in_chess = true;
        }
    }
    if( mPair.first >= 8 || mPair.first < 0 )
        return false;
    if( mPair.second >= 8 || mPair.second < 0 )
        return false;
    switch(in_chess)
    {
        case true:
            {
                Pieces* matrix_aux[8][8];
                for(int i = 0; i < 8; i++)
                    for(int j = 0; j < 8; j++)
                        matrix_aux[i][j] = ChessPiece[i][j];
                matrix_aux[mPair.first][mPair.second] = matrix_aux[m_pozition.first][m_pozition.second];
                matrix_aux[m_pozition.first][m_pozition.second] = NULL;
                if(k -> are_in_chess(matrix_aux))
                    return false;
                else
                    return true;
                break;
            }

        case false:
            {
                if( ChessPiece[mPair.first][mPair.second] == NULL )
                    return true;
                else
                    if( ChessPiece[mPair.first][mPair.second] -> getColor() == getColor() )
                        return false;
                    else
                        return true;
            }
    }
}

std::vector < std::pair < int, int > > Rook::getPossibleMoves(Pieces* const ChessPiece[8][8]) const {
    std::vector < std::pair < int, int > > mList;
    std::pair < int, int > aux;

    for(int i = 1; i < 8; i++)
    {
        aux = std::make_pair ( m_pozition.first + i, m_pozition.second );
        if( valid ( aux, ChessPiece ) )
           mList.push_back( aux );
        else
            break;
        if( ChessPiece[m_pozition.first + i][m_pozition.second] != NULL)
            if( ChessPiece[m_pozition.first + i][m_pozition.second] -> getColor() != getColor() )
                break;
    }

    for(int i = 1; i < 8; i++)
    {
        aux = std::make_pair ( m_pozition.first - i, m_pozition.second );
        if( valid ( aux, ChessPiece ) )
           mList.push_back( aux );
        else
            break;
        if( ChessPiece[m_pozition.first - i][m_pozition.second] != NULL)
            if( ChessPiece[m_pozition.first - i][m_pozition.second] -> getColor() != getColor() )
                break;
    }

    for(int i = 1; i < 8; i++)
    {
        aux = std::make_pair ( m_pozition.first, m_pozition.second + i );
        if( valid ( aux, ChessPiece ) )
           mList.push_back( aux );
        else
            break;
        if( ChessPiece[m_pozition.first][m_pozition.second + i] != NULL)
            if( ChessPiece[m_pozition.first][m_pozition.second + i] -> getColor() != getColor() )
                break;
    }

    for(int i = 1; i < 8; i++)
    {
        aux = std::make_pair ( m_pozition.first, m_pozition.second - i );
        if( valid ( aux, ChessPiece ) )
           mList.push_back( aux );
        else
            break;
        if( ChessPiece[m_pozition.first][m_pozition.second - i] != NULL)
            if( ChessPiece[m_pozition.first][m_pozition.second - i] -> getColor() != getColor() )
                break;
    }
    return mList;
}
