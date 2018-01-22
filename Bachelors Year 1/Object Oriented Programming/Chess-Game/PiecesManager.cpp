#include "PiecesManager.h"

PiecesManager* PiecesManager::instance = 0;


PiecesManager* PiecesManager::getInstance()
{
    if ( instance == 0 )
        instance = new PiecesManager( );

    return instance;
}

PiecesManager::~PiecesManager(){
    for(int i = 0; i < 8; i++)
        for(int j = 0; j < 8; j++)
            if( ChessPieces[i][j] != NULL )
                delete ChessPieces[i][j];
    delete instance;
}

PiecesManager::PiecesManager( ) {
    for(int i = 0; i < 8; i++)
        for(int j = 0; j < 8; j++)
            ChessPieces[i][j] = NULL;

    selected = false;
    turn = 0;
}

void PiecesManager::GetPieces( Pieces* Matrix[][8] ) const{
    for(int i = 0; i < 8; i++)
        for(int j = 0; j < 8; j++)
            Matrix[i][j] = ChessPieces[i][j];
}

bool PiecesManager::AddPieces( Pieces* piece ) {
    if(piece == NULL)
        return 0;
    ChessPieces[piece->getRow()][piece->getColumn()] = piece;
    return 1;
}

bool PiecesManager::DeletePieces( std::pair < int, int > MyPair) {
    if(ChessPieces[MyPair.first][MyPair.second] == NULL)
        return 0;
    ChessPieces[MyPair.first][MyPair.second] -> setAlive(false);
    return 1;
}

bool PiecesManager::RevivePieces( std::pair < int, int > MyPair ) {
    if(ChessPieces[MyPair.first][MyPair.second] == NULL)
        return 0;
    ChessPieces[MyPair.first][MyPair.second] -> setAlive(true);
    return 1;
}

bool PiecesManager::MovePieces( std::pair < int, int > Initial, std::pair < int, int > Final) {
    if(ChessPieces[Initial.first][Initial.second] == NULL)
        return 0;
    std::vector < std::pair < int, int > > moves = ChessPieces[Initial.first][Initial.second] -> getPossibleMoves( ChessPieces );
    for ( std::vector < std::pair < int, int > >::iterator it = moves.begin(); it != moves.end(); ++it )
        if( *it == Final )
            return true;
    return false;
}

bool PiecesManager::InitPieces(int width,int height){

    const int number_of_pawns = 8;

    for(int i = 0;i < number_of_pawns; ++i){
        ChessPieces[1][i] = new Pawn(1,i,Pieces::WHITE,5 * width,(int)Pieces::WHITE * height);
        ChessPieces[6][i] = new Pawn(6,i,Pieces::BLACK,5 * width,(int)Pieces::BLACK * height);
    }

    //WHITE ROOKS
    ChessPieces[0][0] = new Rook(0,0,Pieces::WHITE,0,(int)Pieces::WHITE * height);
    ChessPieces[0][7] = new Rook(0,7,Pieces::WHITE,0,(int)Pieces::WHITE * height);

    //BLACK ROOKS
    ChessPieces[7][0] = new Rook(7,0,Pieces::BLACK,0,(int)Pieces::BLACK * height);
    ChessPieces[7][7] = new Rook(7,7,Pieces::BLACK,0,(int)Pieces::BLACK * height);

    //WHITE BISHOPS
    ChessPieces[0][2] = new Bishop(0,2,Pieces::WHITE,2 * width,(int)Pieces::WHITE * height);
    ChessPieces[0][5] = new Bishop(0,5,Pieces::WHITE,2 * width,(int)Pieces::WHITE * height);

    //BLACK BISHOPS
    ChessPieces[7][2] = new Bishop(7,2,Pieces::BLACK,2 * width,(int)Pieces::BLACK * height);
    ChessPieces[7][5] = new Bishop(7,5,Pieces::BLACK,2 * width,(int)Pieces::BLACK * height);

    //WHITE KNIGHT
    ChessPieces[0][1] = new Knight(0,1,Pieces::WHITE,width,(int)Pieces::WHITE * height);
    ChessPieces[0][6] = new Knight(0,6,Pieces::WHITE,width,(int)Pieces::WHITE * height);

    //BLACK KNIGHT
    ChessPieces[7][1] = new Knight(7,1,Pieces::BLACK,width,(int)Pieces::BLACK * height);
    ChessPieces[7][6] = new Knight(7,6,Pieces::BLACK,width,(int)Pieces::BLACK * height);

    //WHITE QUEEN
    ChessPieces[0][4] = new Queen(0,4,Pieces::WHITE,3 * width,(int)Pieces::WHITE * height);

    //BLACK QUEEN
    ChessPieces[7][4] = new Queen(7,4,Pieces::BLACK,3 * width,(int)Pieces::BLACK * height);

    //WHITE KING
    ChessPieces[0][3] = new King(0,3,Pieces::WHITE,4 * width,(int)Pieces::WHITE * height);

    //BLACK KING
    ChessPieces[7][3] = new King(7,3,Pieces::BLACK,4 * width,(int)Pieces::BLACK * height);

    return true;
}

std::vector<std::pair<int,int >> PiecesManager::HandleEvent(SDL_Point selected_piece,int width,int height){

    std::cout << "Last piece: " << last_piece.y << " " << last_piece.x << std::endl;
    std::cout << "Selected piece: " << selected_piece.y << " " << selected_piece.x << std::endl << "\n";

    bool is_king = false;

    if(!selected){
        if(ChessPieces[selected_piece.y][selected_piece.x] != NULL){
           if(ChessPieces[selected_piece.y][selected_piece.x] -> getColor() ==(Pieces::Color)(turn % 2)){
                actual_piece = selected_piece;
                selected = true;
                ChessPieces[selected_piece.y][selected_piece.x] -> setSelected(true);
                piece_moves = ChessPieces[selected_piece.y][selected_piece.x] -> getPossibleMoves(ChessPieces);
                piece_moves.push_back(std::make_pair(selected_piece.y,selected_piece.x));
                //if(ChessPieces[selected_piece.y][selected_piece.x] -> getType() == Pieces::KING)
                {
                    if(King* k = dynamic_cast<King*>(ChessPieces[selected_piece.y][selected_piece.x]))
                    {
                        std::cout << "downcast from pieces to king successful\n";
                        if(k -> are_in_chess(ChessPieces))
                        {
                            int ok = 1;
                            for(int i = 0; i < 8; i++)
                                for(int j = 0; j < 8; j++)
                                {
                                    if(ChessPieces[i][j] != NULL)
                                        if(ChessPieces[i][j] -> getColor() == k -> getColor() && ChessPieces[i][j] -> getType() != Pieces::KING)
                                            if(ChessPieces[i][j] -> getPossibleMoves(ChessPieces).size() != 0)
                                                ok = 0;
                                }
                            if(ok)
                            {
                                std::cout<<" SAH MAT !!!!!!!!!!!!!!!!!!!";
                                piece_moves.pop_back();
                            }

                        }
                    }
                }
                for(int i = 0;i < piece_moves.size(); ++i)
                    std::cout << piece_moves[i].first << " " << piece_moves[i].second << std::endl;
                last_piece = selected_piece;
           }
        }
    }
    else{

        bool valid_move = false;
        int len = piece_moves.size();

        for(int i = 0;i < len; ++i){
            std::cout << last_piece.y << " " << last_piece.x << std::endl;
            if(piece_moves[i].first == selected_piece.y && piece_moves[i].second == selected_piece.x){
                valid_move = true;
                break;
            }
        }

        if(valid_move){std::cout << "DA";
            if(last_piece.x != selected_piece.x || last_piece.y != selected_piece.y){
                ChessPieces[last_piece.y][last_piece.x] -> setMoved(true);
                ChessPieces[last_piece.y][last_piece.x] -> setSelected(false);
                ChessPieces[last_piece.y][last_piece.x] -> setTableCornerX(selected_piece.x );
                ChessPieces[last_piece.y][last_piece.x] -> setTableCornerY(selected_piece.y );
                ChessPieces[last_piece.y][last_piece.x] -> setPozition({selected_piece.y,selected_piece.x});

                if( ChessPieces[last_piece.y][last_piece.x] -> getType() == Pieces::KING)
                    is_king = true;

                if(is_king && (last_piece.x - selected_piece.x == 2) ) { // MAKE CASTLING LEFT AND MOVE THE ROOK
                    ChessPieces[last_piece.y][last_piece.x] -> setMoved(true);
                   // ChessPieces[last_piece.y][last_piece.x] -> setSelected(false);
                    ChessPieces[last_piece.y][0] -> setTableCornerX( 2 );
                    ChessPieces[last_piece.y][0] -> setTableCornerY(selected_piece.y );
                    ChessPieces[last_piece.y][0] -> setPozition(std::make_pair(last_piece.y, 2));
                    ChessPieces[last_piece.y][2] = ChessPieces[last_piece.y][0];
                    ChessPieces[last_piece.y][0] = NULL;
                }

                if(is_king && (selected_piece.x - last_piece.x == 2) ) { // MAKE CASTLING RIGHT AND MOVE THE ROOK
                    ChessPieces[last_piece.y][last_piece.x] -> setMoved(true);
                   // ChessPieces[last_piece.y][last_piece.x] -> setSelected(false);
                    ChessPieces[last_piece.y][7] -> setTableCornerX( 4 );
                    ChessPieces[last_piece.y][7] -> setTableCornerY(selected_piece.y );
                    ChessPieces[last_piece.y][7] -> setPozition(std::make_pair(last_piece.y, 4));
                    ChessPieces[last_piece.y][4] = ChessPieces[last_piece.y][7];
                    ChessPieces[last_piece.y][7] = NULL;
                }

                if(ChessPieces[selected_piece.y][selected_piece.x] != NULL)
                    ChessPieces[selected_piece.y][selected_piece.x] -> setAlive(false);

                ChessPieces[selected_piece.y][selected_piece.x] = ChessPieces[last_piece.y][last_piece.x];
                ChessPieces[last_piece.y][last_piece.x] = NULL;

                turn = (turn + 1) % 69;
            }
            else
                ChessPieces[selected_piece.y][selected_piece.x] -> setSelected(false);
            selected = false;

                piece_moves.erase(piece_moves.begin(),piece_moves.end());
                last_piece = {-1,-1};
        }
    }

    last_piece = actual_piece;

    return piece_moves;
}
