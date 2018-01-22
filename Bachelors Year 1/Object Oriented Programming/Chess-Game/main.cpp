#include <iostream>
#include <vector>
#include <SDL.h>
#include <SDL_image.h>
#include "Table.h"
#include "PieceTexture.h"
#include "Init.h"
#include "Dot.h"
#include "Texture.h"
#include "TextTexture.h"
#include "PiecesManager.h"
#include "EventManager.h"

using namespace std;

const int SCREEN_HEIGHT = 670;
const int SCREEN_WIDTH = 640;
const int NUMBER_OF_PIECES = 32;

Pieces* Chess[8][8];

SDL_Window* window = NULL;
SDL_Renderer* renderer = NULL;

int main(int args,char* argv[]){

    Texture* ChessDotTexture = new Dot;
    Texture* ChessPieceTexture = new PieceTexture;
    Texture* ChessTableTexture = new Table(8);
    Texture* ChessTextTexture = new TextTexture;

    PiecesManager* PieceSingleton = PiecesManager::getInstance();
    EventManager* EventSingleton = EventManager::getInstance();

    if(!ChessTableTexture -> Init()){
        cout << "Jocul se va opri\n";
        return 0;
    }

    if(!ChessDotTexture -> LoadMedia("dot.jpg")){
         cout << "Jocul se va opri\n";
         return 0;
    }

    if(!ChessTextTexture -> LoadFont()){
        cout << "Jocul se va opri\n";
        return 0;
    }

    if(!ChessTableTexture -> LoadMedia("table.jpg")){
        cout << "Jocul se va opri\n";
        return 0;
    }

    if(!ChessPieceTexture -> LoadMedia("pieces.jpg")){
        cout << "Jocul se va opri\n";
        return 0;
    }

    if(!PieceSingleton -> InitPieces(ChessPieceTexture -> getPieceWidth(), ChessPieceTexture -> getPieceHeight())){
        cout << "Jocul se va opri\n";
        return 0;
    }

    bool quit = false;
    bool selected = false;
    const int table_width = ChessTableTexture->getWidth();
    const int table_height = ChessTableTexture->getHeight();
    const int cell_width = table_width / 8;
    const int cell_height = (table_height - 30) / 8;
    const int piece_width = ChessPieceTexture -> getPieceWidth();
    const int piece_height = ChessPieceTexture -> getPieceHeight();
    int i, j;
    SDL_Event e;
    SDL_Rect rect;
    SDL_Point last_piece = {-1,-1};
    SDL_Point selected_piece = {-1,-1};

    vector < pair < int, int > > pieceMoves;

    while(quit == false){
        while(SDL_PollEvent(&e) != 0){
            if(e.type == SDL_QUIT)
                goto quitGame;
            else{

                SDL_RenderClear(renderer);

                rect = {0,0,table_width,table_height};
                ChessTableTexture -> Render(0,0,&rect);

                selected_piece = {-1,-1};
                selected_piece = EventSingleton -> getEvent(&e);

                if(selected_piece.x > 0 && selected_piece.y <= SCREEN_HEIGHT - 30){
                    selected_piece.x /= cell_width;
                    selected_piece.y /= cell_height;

                    pieceMoves = PieceSingleton -> HandleEvent(selected_piece,cell_width,cell_height);
                }
                Pieces* matrix[8][8];
                PieceSingleton -> GetPieces(matrix);

                           // for(i = 0;i < 8; ++i){
//                                for(j = 0;j < 8; ++j)
//                                    if(matrix[i][j])
//                                        cout << 1 << " ";
//                                    else
//                                        cout << 0 << " ";
//                                cout << endl;
//                            }
//                            cout << endl;/

                ChessPieceTexture -> setAlpha(500);
                for(i = 0;i < 8; ++i)
                    for(j = 0;j < 8; ++j){
                        if(matrix[i][j] != NULL){
                            int cornerX = matrix[i][j] -> getTextureCornerY();
                            int cornerY = matrix[i][j] -> getTextureCornerX();
                            int tableCornerX = matrix[i][j] -> getTableCornerX();
                            int tableCornerY = matrix[i][j] -> getTableCornerY();


                            if(matrix[i][j] -> isAlive()){
                                rect = {cornerX,cornerY,piece_width,piece_height};
                            if(!matrix[i][j] -> isSelected())
                                ChessPieceTexture -> Render(tableCornerX * cell_width,tableCornerY * cell_height,&rect);
                            else{
                                ChessPieceTexture->setAlpha(50);
                                ChessPieceTexture->Render(tableCornerX * cell_width,tableCornerY * cell_height,&rect);
                                ChessPieceTexture->setAlpha(500);
                                }
                            }
                        }
                    }

                    //if(selected){
                    rect = {0,0,ChessDotTexture->getWidth(),ChessDotTexture->getHeight()};
                    //cout << ChessDot.getDotWidth();
                    for(int i = 0;i < pieceMoves.size(); ++i){
                        //SDL_RenderDrawLine(renderer,pieceMoves[i].second * ChessPieceTexture.getPieceWidth() + ChessPieceTexture.getPieceWidth() / 2,pieceMoves[i].first * ChessPieceTexture.getPieceHeight() + ChessPieceTexture.getPieceHeight() / 2,pieceMoves[i].second * ChessPieceTexture.getPieceWidth() + ChessPieceTexture.getPieceWidth() / 2 + 10,pieceMoves[i].first * ChessPieceTexture.getPieceHeight() + ChessPieceTexture.getPieceHeight() / 2);
                        ChessDotTexture -> Render(pieceMoves[i].second * ChessPieceTexture -> getPieceWidth() + 22,
                                pieceMoves[i].first * ChessPieceTexture -> getPieceHeight() + 21, &rect);
                    }
                //}
/*
                if(turn % 2 == 0)
                    ChessTextTexture -> LoadText("White`s turn!");
                else
                    ChessTextTexture -> LoadText("Black`s turn!");
                SDL_Rect rect;
                rect.h = ChessTextTexture -> getHeight();
                rect.w = ChessTextTexture -> getWidth();
                rect.x = 0;
                rect.y = 0;
                ChessTextTexture -> Render(5,645,&rect);
                SDL_RenderPresent(renderer);

                    }
                }*/
            SDL_RenderPresent(renderer);
            }
        }
    }


    quitGame:
        {
            ChessTableTexture -> Close();
            return 0;
        }

    return 0;
}
