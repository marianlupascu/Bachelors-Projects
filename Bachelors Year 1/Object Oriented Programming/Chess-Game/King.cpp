#include "King.h"
#include <iostream>

King::King () {}

/*King::King ( std::pair < int, int > table, Color color, std::pair < int, int > texture) :
    Pieces( table, color, texture ) { type = Pieces::KING; }
*/
King::King ( int tableRow, int tableColumn, Color color, int textureRow, int textureColumn) :
    Pieces(tableRow, tableColumn, color, textureRow, textureColumn) { type = Pieces::KING; }

bool King::valid ( std::pair < int, int > mPair, Pieces* const ChessPiece[8][8]) const {

    if( mPair.first >= 8 || mPair.first < 0 )
        return false;
    if( mPair.second >= 8 || mPair.second < 0 )
        return false;
    if( point_in_chess(mPair, ChessPiece) )
        return false;
    else
        if( ChessPiece[mPair.first][mPair.second] != NULL )
            if( ChessPiece[mPair.first][mPair.second] -> getColor() == getColor() )
                return false;
            else
                return true;
        else
            return true;
}

std::vector < std::pair < int, int > > King::getPossibleMoves(Pieces* const ChessPiece[8][8]) const {
    std::vector < std::pair < int, int > > mList;
    std::pair < int, int > aux;
    aux = std::make_pair ( m_pozition.first - 1, m_pozition.second - 1 );
    if( valid ( aux, ChessPiece ) )
       mList.push_back( aux );
    aux = std::make_pair ( m_pozition.first - 1, m_pozition.second );
    if( valid ( aux, ChessPiece ) )
       mList.push_back( aux );
    aux = std::make_pair ( m_pozition.first - 1, m_pozition.second + 1 );
    if( valid ( aux, ChessPiece ) )
       mList.push_back( aux );
    aux = std::make_pair ( m_pozition.first , m_pozition.second + 1 );
    if( valid ( aux, ChessPiece ) )
       mList.push_back( aux );
    aux = std::make_pair ( m_pozition.first , m_pozition.second - 1 );
    if( valid ( aux, ChessPiece ) )
       mList.push_back( aux );
    aux = std::make_pair ( m_pozition.first + 1, m_pozition.second + 1 );
    if( valid ( aux, ChessPiece ) )
       mList.push_back( aux );
    aux = std::make_pair ( m_pozition.first + 1, m_pozition.second );
    if( valid ( aux, ChessPiece ) )
       mList.push_back( aux );
    aux = std::make_pair ( m_pozition.first + 1, m_pozition.second - 1 );
    if( valid ( aux, ChessPiece ) )
       mList.push_back( aux );

    if( castling_left(ChessPiece) )
    {
        switch( getColor() )
        {
            case Pieces::WHITE :
                if( getPozition() == std::make_pair(0, 3) )
                    mList.push_back( std::make_pair(0, 1) );
            case Pieces::BLACK :
                if( getPozition() == std::make_pair(7, 3) )
                    mList.push_back( std::make_pair(7, 1) );
        }
    }
    if( castling_right(ChessPiece) )
    {
        switch( getColor() )
        {
            case Pieces::WHITE :
                if( getPozition() == std::make_pair(0, 3) )
                    mList.push_back( std::make_pair(0, 5) );
            case Pieces::BLACK :
                if( getPozition() == std::make_pair(7, 3) )
                    mList.push_back( std::make_pair(7, 5) );
        }
    }

    return mList;
}

bool King::with_Rook( std::pair < int, int > mPair, Pieces* const ChessPiece[8][8] ) const {

    for(int i = 1; i < 8; i++)
    {
        if( mPair.first + i < 8 )
            if( ChessPiece[mPair.first + i][mPair.second] != NULL )
            {
                if( ChessPiece[mPair.first + i][mPair.second] -> getType() == Pieces::ROOK &&
                        ChessPiece[mPair.first + i][mPair.second] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[mPair.first + i][mPair.second] -> getType() != Pieces::ROOK &&
                        ChessPiece[mPair.first + i][mPair.second] -> getColor() != getColor() )
                    break;
                if( ChessPiece[mPair.first + i][mPair.second] -> getColor() == getColor() &&
                        ChessPiece[mPair.first + i][mPair.second] -> getType() != KING )
                    break;
            }
    }

    for(int i = 1; i < 8; i++)
    {
        if( mPair.first - i >= 0)
            if( ChessPiece[mPair.first - i][mPair.second] != NULL )
            {
                if( ChessPiece[mPair.first - i][mPair.second] -> getType() == Pieces::ROOK &&
                        ChessPiece[mPair.first - i][mPair.second] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[mPair.first - i][mPair.second] -> getType() != Pieces::ROOK &&
                        ChessPiece[mPair.first - i][mPair.second] -> getColor() != getColor() )
                    break;
                if( ChessPiece[mPair.first - i][mPair.second] -> getColor() == getColor() &&
                        ChessPiece[mPair.first - i][mPair.second] -> getType() != KING )
                    break;
            }
    }

    for(int i = 1; i < 8; i++)
    {
        if( mPair.second + i < 8)
            if( ChessPiece[mPair.first][mPair.second + i] != NULL )
            {
                if( ChessPiece[mPair.first][mPair.second + i] -> getType() == Pieces::ROOK &&
                        ChessPiece[mPair.first][mPair.second + i] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[mPair.first][mPair.second + i] -> getType() != Pieces::ROOK &&
                        ChessPiece[mPair.first][mPair.second + i] -> getColor() != getColor() )
                    break;
                if( ChessPiece[mPair.first][mPair.second + i] -> getColor() == getColor() &&
                        ChessPiece[mPair.first][mPair.second + i] -> getType() != KING )
                    break;
            }
    }

    for(int i = 1; i < 8; i++)
    {
        if( mPair.second - i >= 0)
            if( ChessPiece[mPair.first][mPair.second - i] != NULL )
            {
                if( ChessPiece[mPair.first][mPair.second - i] -> getType() == Pieces::ROOK &&
                        ChessPiece[mPair.first][mPair.second - i] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[mPair.first][mPair.second - i] -> getType() != Pieces::ROOK &&
                        ChessPiece[mPair.first][mPair.second - i] -> getColor() != getColor() )
                    break;
                if( ChessPiece[mPair.first][mPair.second - i] -> getColor() == getColor() &&
                        ChessPiece[mPair.first][mPair.second - i] -> getType() != KING )
                    break;
            }
    }
    return false;
}

bool King::with_Knight( std::pair < int, int > mPair, Pieces* const ChessPiece[8][8] ) const {

    std::pair < int, int > aux;

    aux.first = mPair.first - 2;
    aux.second = mPair.second - 1;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KNIGHT &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    aux.first = mPair.first - 2;
    aux.second = mPair.second + 1;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KNIGHT &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    aux.first = mPair.first - 1;
    aux.second = mPair.second - 2;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KNIGHT &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    aux.first = mPair.first - 1;
    aux.second = mPair.second + 2;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KNIGHT &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    aux.first = mPair.first + 2;
    aux.second = mPair.second - 1;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KNIGHT &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    aux.first = mPair.first + 2;
    aux.second = mPair.second + 1;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KNIGHT &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    aux.first = mPair.first + 1;
    aux.second = mPair.second - 2;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KNIGHT &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    aux.first = mPair.first + 1;
    aux.second = mPair.second + 2;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KNIGHT &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    return false;
}


bool King::with_King( std::pair < int, int > mPair, Pieces* const ChessPiece[8][8] ) const {

    std::pair < int, int > aux;

    aux.first = mPair.first - 1;
    aux.second = mPair.second - 1;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KING &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    aux.first = mPair.first - 1;
    aux.second = mPair.second;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KING &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    aux.first = mPair.first - 1;
    aux.second = mPair.second + 1;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KING &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    aux.first = mPair.first;
    aux.second = mPair.second - 1;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KING &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    aux.first = mPair.first;
    aux.second = mPair.second + 1;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KING &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    aux.first = mPair.first + 1;
    aux.second = mPair.second - 1;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KING &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    aux.first = mPair.first + 1;
    aux.second = mPair.second;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KING &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    aux.first = mPair.first + 1;
    aux.second = mPair.second + 1;
    if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
        if( ChessPiece[aux.first][aux.second] != NULL )
            if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::KING &&
                    ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                return true;

    return false;
}

bool King::with_Bishop( std::pair < int, int > mPair, Pieces* const ChessPiece[8][8] ) const {

    std::pair < int, int > aux = mPair;

    for(int i = 1; i < 8; i++)
    {
        aux.first -= 1;
        aux.second -= 1;
        if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
            if( ChessPiece[aux.first][aux.second] != NULL )
            {
                if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::BISHOP &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[aux.first][aux.second] -> getType() != Pieces::BISHOP &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    break;
                if( ChessPiece[aux.first][aux.second] -> getColor() == getColor() &&
                        ChessPiece[aux.first][aux.second] -> getType() != KING )
                    break;
            }
    }

    aux = mPair;
    for(int i = 1; i < 8; i++)
    {
        aux.first -= 1;
        aux.second += 1;
        if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
            if( ChessPiece[aux.first][aux.second] != NULL )
            {
                if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::BISHOP &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[aux.first][aux.second] -> getType() != Pieces::BISHOP &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    break;
                if( ChessPiece[aux.first][aux.second] -> getColor() == getColor() &&
                        ChessPiece[aux.first][aux.second] -> getType() != KING )
                    break;
            }
    }

    aux = mPair;
    for(int i = 1; i < 8; i++)
    {
        aux.first += 1;
        aux.second -= 1;
        if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
            if( ChessPiece[aux.first][aux.second] != NULL )
            {
                if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::BISHOP &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[aux.first][aux.second] -> getType() != Pieces::BISHOP &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    break;
                if( ChessPiece[aux.first][aux.second] -> getColor() == getColor() &&
                        ChessPiece[aux.first][aux.second] -> getType() != KING )
                    break;
            }
    }

    aux = mPair;
    for(int i = 1; i < 8; i++)
    {
        aux.first += 1;
        aux.second += 1;
        if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
            if( ChessPiece[aux.first][aux.second] != NULL )
            {
                if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::BISHOP &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[aux.first][aux.second] -> getType() != Pieces::BISHOP &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    break;
                if( ChessPiece[aux.first][aux.second] -> getColor() == getColor() &&
                        ChessPiece[aux.first][aux.second] -> getType() != KING )
                    break;
            }
    }

    return false;
}

bool King::with_Queen( std::pair < int, int > mPair, Pieces* const ChessPiece[8][8] ) const {

    std::pair < int, int > aux = mPair;

    for(int i = 1; i < 8; i++)
    {
        aux.first -= 1;
        aux.second -= 1;
        if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
            if( ChessPiece[aux.first][aux.second] != NULL )
            {
                if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::QUEEN &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[aux.first][aux.second] -> getType() != Pieces::QUEEN &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    break;
                if( ChessPiece[aux.first][aux.second] -> getColor() == getColor() &&
                        ChessPiece[aux.first][aux.second] -> getType() != KING )
                    break;
            }
    }

    aux = mPair;
    for(int i = 1; i < 8; i++)
    {
        aux.first -= 1;
        aux.second += 1;
        if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
            if( ChessPiece[aux.first][aux.second] != NULL )
            {
                if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::QUEEN &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[aux.first][aux.second] -> getType() != Pieces::QUEEN &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    break;
                if( ChessPiece[aux.first][aux.second] -> getColor() == getColor() &&
                        ChessPiece[aux.first][aux.second] -> getType() != KING )
                    break;
            }
    }

    aux = mPair;
    for(int i = 1; i < 8; i++)
    {
        aux.first += 1;
        aux.second -= 1;
        if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
           if( ChessPiece[aux.first][aux.second] != NULL )
            {
                if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::QUEEN &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[aux.first][aux.second] -> getType() != Pieces::QUEEN &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    break;
                if( ChessPiece[aux.first][aux.second] -> getColor() == getColor() &&
                        ChessPiece[aux.first][aux.second] -> getType() != KING )
                    break;
            }
    }

    aux = mPair;
    for(int i = 1; i < 8; i++)
    {
        aux.first += 1;
        aux.second += 1;
        if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
            if( ChessPiece[aux.first][aux.second] != NULL )
            {
                if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::QUEEN &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[aux.first][aux.second] -> getType() != Pieces::QUEEN &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    break;
                if( ChessPiece[aux.first][aux.second] -> getColor() == getColor() &&
                        ChessPiece[aux.first][aux.second] -> getType() != KING )
                    break;
            }
    }

    for(int i = 1; i < 8; i++)
    {
        if( mPair.first + i < 8 )
            if( ChessPiece[mPair.first + i][mPair.second] != NULL )
            {
                if( ChessPiece[mPair.first + i][mPair.second] -> getType() == Pieces::QUEEN &&
                        ChessPiece[mPair.first + i][mPair.second] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[mPair.first + i][mPair.second] -> getType() != Pieces::QUEEN &&
                        ChessPiece[mPair.first + i][mPair.second] -> getColor() != getColor() )
                    break;
                if( ChessPiece[mPair.first + i][mPair.second] -> getColor() == getColor() &&
                        ChessPiece[mPair.first + i][mPair.second] -> getType() != KING )
                    break;
            }
    }

    for(int i = 1; i < 8; i++)
    {
        if( mPair.first - i >= 0)
            if( ChessPiece[mPair.first - i][mPair.second] != NULL )
            {
                if( ChessPiece[mPair.first - i][mPair.second] -> getType() == Pieces::QUEEN &&
                        ChessPiece[mPair.first - i][mPair.second] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[mPair.first - i][mPair.second] -> getType() != Pieces::QUEEN &&
                        ChessPiece[mPair.first - i][mPair.second] -> getColor() != getColor() )
                    break;
                if( ChessPiece[mPair.first - i][mPair.second] -> getColor() == getColor() &&
                        ChessPiece[mPair.first - i][mPair.second] -> getType() != KING )
                    break;
            }
    }

    for(int i = 1; i < 8; i++)
    {
        if( mPair.second + i < 8)
            if( ChessPiece[mPair.first][mPair.second + i] != NULL )
            {
                if( ChessPiece[mPair.first][mPair.second + i] -> getType() == Pieces::QUEEN &&
                        ChessPiece[mPair.first][mPair.second + i] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[mPair.first][mPair.second + i] -> getType() != Pieces::QUEEN &&
                        ChessPiece[mPair.first][mPair.second + i] -> getColor() != getColor() )
                    break;
                if( ChessPiece[mPair.first][mPair.second + i] -> getColor() == getColor() &&
                        ChessPiece[mPair.first][mPair.second + i] -> getType() != KING )
                    break;
            }
    }

    for(int i = 1; i < 8; i++)
    {
        if( mPair.second - i >= 0)
            if( ChessPiece[mPair.first][mPair.second - i] != NULL )
            {
                if( ChessPiece[mPair.first][mPair.second - i] -> getType() == Pieces::QUEEN &&
                        ChessPiece[mPair.first][mPair.second - i] -> getColor() != getColor() )
                    return true;
                if( ChessPiece[mPair.first][mPair.second - i] -> getType() != Pieces::QUEEN &&
                        ChessPiece[mPair.first][mPair.second - i] -> getColor() != getColor() )
                    break;
                if( ChessPiece[mPair.first][mPair.second - i] -> getColor() == getColor() &&
                        ChessPiece[mPair.first][mPair.second - i] -> getType() != KING )
                    break;
            }
    }

    return false;
}

bool King::with_Pawn( std::pair < int, int > mPair, Pieces* const ChessPiece[8][8] ) const {

    std::pair < int, int > aux;

    if( getColor() == Pieces::BLACK )
    {
        aux.first = mPair.first - 1;
        aux.second = mPair.second - 1;
        if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
            if( ChessPiece[aux.first][aux.second] != NULL )
                if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::PAWN &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    return true;

        aux.first = mPair.first - 1;
        aux.second = mPair.second + 1;
        if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
            if( ChessPiece[aux.first][aux.second] != NULL )
                if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::PAWN &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    return true;
    }
    else
    {
        aux.first = mPair.first + 1;
        aux.second = mPair.second - 1;
        if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
            if( ChessPiece[aux.first][aux.second] != NULL )
                if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::PAWN &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    return true;

        aux.first = mPair.first + 1;
        aux.second = mPair.second + 1;
        if( aux.first < 8 &&  aux.first >= 0 && aux.second < 8 &&  aux.second >= 0 )
            if( ChessPiece[aux.first][aux.second] != NULL )
                if( ChessPiece[aux.first][aux.second] -> getType() == Pieces::PAWN &&
                        ChessPiece[aux.first][aux.second] -> getColor() != getColor() )
                    return true;
    }
}

bool King::castling_right ( Pieces* const ChessPiece[8][8] ) const {

    switch( getColor() )
    {
        case Pieces::WHITE : {
            if(ChessPiece[0][7] != NULL)
                if( ChessPiece[0][4] == NULL && ChessPiece[0][5] == NULL && ChessPiece[0][6] == NULL && !m_moved &&
                        ( ChessPiece[0][7] -> getType() == ROOK && ChessPiece[0][7] -> getMoved() == false ) &&
                        ChessPiece[0][7] -> getColor() == Pieces::WHITE && !point_in_chess(std::make_pair(0,5), ChessPiece) )
                    return true;
        }
        case Pieces::BLACK : {
            if(ChessPiece[7][7] != NULL)
                if( ChessPiece[7][4] == NULL && ChessPiece[7][5] == NULL && ChessPiece[7][6] == NULL && !m_moved &&
                        ( ChessPiece[7][7] -> getType() == ROOK && ChessPiece[7][7] -> getMoved() == false ) &&
                        ChessPiece[7][7] -> getColor() == Pieces::BLACK && !point_in_chess(std::make_pair(7,5), ChessPiece) )
                    return true;
        }
    }
    return false;
}

bool King::castling_left ( Pieces* const ChessPiece[8][8] ) const {

    switch( getColor() )
    {
        case Pieces::WHITE : {
            if(ChessPiece[0][0] != NULL)
                if( ChessPiece[0][2] == NULL && ChessPiece[0][1] == NULL && !m_moved &&
                        ( ChessPiece[0][0] -> getType() == ROOK && ChessPiece[0][0] -> getMoved() == false ) &&
                        ChessPiece[0][0] -> getColor() == Pieces::WHITE && !point_in_chess(std::make_pair(0,1), ChessPiece) )
                    return true;
        }
        case Pieces::BLACK : {
            if(ChessPiece[7][0] != NULL)
                if( ChessPiece[7][2] == NULL && ChessPiece[7][1] == NULL && !m_moved &&
                        ( ChessPiece[7][0] -> getType() == ROOK && ChessPiece[7][0] -> getMoved() == false ) &&
                        ChessPiece[7][0] -> getColor() == Pieces::BLACK && !point_in_chess(std::make_pair(7,1), ChessPiece) )
                    return true;
        }
    }
    return false;
}

bool King::point_in_chess ( std::pair < int, int > mPair, Pieces* const ChessPiece[8][8] ) const {

    if( with_Rook( mPair, ChessPiece ) )
        return true;
    if( with_Knight( mPair, ChessPiece ) )
        return true;
    if( with_King( mPair, ChessPiece ) )
        return true;
    if( with_Bishop( mPair, ChessPiece ) )
        return true;
    if( with_Queen( mPair, ChessPiece ) )
        return true;
    if( with_Pawn( mPair, ChessPiece ) )
        return true;
    return false;
}

bool King::are_in_chess ( Pieces* const ChessPiece[8][8] ) const {

    return point_in_chess( m_pozition, ChessPiece);
}
