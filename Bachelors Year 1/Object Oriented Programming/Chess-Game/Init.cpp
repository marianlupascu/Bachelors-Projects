#include <SDL.h>
#include <SDL_image.h>
#include <SDL_ttf.h>
#include "Variables.h"

/*void InitPieces(){

    int pawn_number = 8;

    for(int i = 0;i < pawn_number; ++i)
        ChessPiece[i] = new Pawn()

}*/

SDL_Point getEvent(SDL_Event* e){

    SDL_Point mouse_position = {-1,-1};

    if(e -> type == SDL_MOUSEBUTTONDOWN)
        SDL_GetMouseState(&mouse_position.x,&mouse_position.y);

    return mouse_position;
}

void Close(){

    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    renderer = NULL;
    window = NULL;

    SDL_Quit();
    IMG_Quit();
    TTF_Quit();
}
