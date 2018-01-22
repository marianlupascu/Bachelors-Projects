#include "Queen.h"
#include "King.h"

Queen::Queen(): Pieces(){
    type = QUEEN;
}


/*Queen::Queen(std::pair<int, int> position, Color color, std::pair<int, int> texture):
    Pieces(position, color, texture){
    type = QUEEN;
}
*/

Queen::Queen(int tableRow, int tableColumn, Color color, int textureRow, int textureColumn):
    Pieces(tableRow, tableColumn, color, textureRow, textureColumn){
    type = QUEEN;
}

bool Queen::valid ( std::pair < int, int > mPair, Pieces* const ChessPiece[8][8]) const {
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

std::vector<std::pair<int, int>> Queen::getPossibleMoves(Pieces* const pieces[8][8]) const{
    std::vector<std::pair<int, int>> possibleMoves;

    bool stop = false;
    std::pair<int, int> currentSquare = this->getPozition();
    while(!stop){
        currentSquare.first++;
        currentSquare.second++;
        if(valid(currentSquare, pieces)){
            if(pieces[currentSquare.first][currentSquare.second] == nullptr){
                possibleMoves.push_back(currentSquare);
            }else{
                stop = true;
                if(pieces[currentSquare.first][currentSquare.second]->getColor() != this->getColor()){
                    possibleMoves.push_back(currentSquare);
                }
            }
        }else{
            stop = true;
        }
    }


    //Verificam in sensul stanga-sus
    stop = false;
    currentSquare = this->getPozition();
    while(!stop){
        currentSquare.first--;
        currentSquare.second++;
        if(valid(currentSquare, pieces)){
            if(pieces[currentSquare.first][currentSquare.second] == nullptr){
                possibleMoves.push_back(currentSquare);
            }else{
                stop = true;
                if(pieces[currentSquare.first][currentSquare.second]->getColor() != this->getColor()){
                    possibleMoves.push_back(currentSquare);
                }
            }
        }else{
            stop = true;
        }
    }

    //Verificam in sensul stanga-jos
    stop = false;
    currentSquare = this->getPozition();
    while(!stop){
        currentSquare.first--;
        currentSquare.second--;
        if(valid(currentSquare, pieces)){
            if(pieces[currentSquare.first][currentSquare.second] == nullptr){
                possibleMoves.push_back(currentSquare);
            }else{
                stop = true;
                if(pieces[currentSquare.first][currentSquare.second]->getColor() != this->getColor()){
                    possibleMoves.push_back(currentSquare);
                }
            }
        }else{
            stop = true;
        }
    }

    //Verificam in sensul drepata-jos;
    stop = false;
    currentSquare = this->getPozition();
    while(!stop){
        currentSquare.first++;
        currentSquare.second--;
        if(valid(currentSquare, pieces)){
            if(pieces[currentSquare.first][currentSquare.second] == nullptr){
                possibleMoves.push_back(currentSquare);
            }else{
                stop = true;
                if(pieces[currentSquare.first][currentSquare.second]->getColor() != this->getColor()){
                possibleMoves.push_back(currentSquare);
                }
            }
        }else{
            stop = true;
        }
    }

    stop = false;
    currentSquare = this->getPozition();
    while(!stop){
        currentSquare.first--;
        if(valid(currentSquare, pieces)){
            if(pieces[currentSquare.first][currentSquare.second] == nullptr){
                possibleMoves.push_back(currentSquare);
            }else{
                stop = true;
                if(pieces[currentSquare.first][currentSquare.second]->getColor() != this->getColor()){
                    possibleMoves.push_back(currentSquare);
                }
            }
        }else{
            stop = true;
        }
    }

    stop = false;
    currentSquare = this->getPozition();
    while(!stop){
        currentSquare.first++;
        if(valid(currentSquare, pieces)){
            if(pieces[currentSquare.first][currentSquare.second] == nullptr){
                possibleMoves.push_back(currentSquare);
            }else{
                stop = true;
                if(pieces[currentSquare.first][currentSquare.second]->getColor() != this->getColor()){
                    possibleMoves.push_back(currentSquare);
                }
            }
        }else{
            stop = true;
        }
    }

    stop = false;
    currentSquare = this->getPozition();
    while(!stop){
        currentSquare.second++;
        if(valid(currentSquare, pieces)){
            if(pieces[currentSquare.first][currentSquare.second] == nullptr){
                possibleMoves.push_back(currentSquare);
            }else{
                stop = true;
                if(pieces[currentSquare.first][currentSquare.second]->getColor() != this->getColor()){
                    possibleMoves.push_back(currentSquare);
                }
            }
        }else{
            stop = true;
        }
    }

    stop = false;
    currentSquare = this->getPozition();
    while(!stop){
        currentSquare.second--;
        if(valid(currentSquare, pieces)){
            if(pieces[currentSquare.first][currentSquare.second] == nullptr){
                possibleMoves.push_back(currentSquare);
            }else{
                stop = true;
                if(pieces[currentSquare.first][currentSquare.second]->getColor() != this->getColor()){
                    possibleMoves.push_back(currentSquare);
                }
            }
        }else{
            stop = true;
        }
    }

    return possibleMoves;
}
