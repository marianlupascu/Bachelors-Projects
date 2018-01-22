#include "Dot.h"
#include "Variables.h"

/*void Dot::Render(int x,int y,SDL_Rect* rect){

    SDL_Rect auxRect;
    auxRect.x = x;
    auxRect.y = y;
    auxRect.w = rect -> w;
    auxRect.h = rect -> h;

    SDL_RenderCopy(renderer,m_dotTexture,rect,&auxRect);
}

bool Dot::LoadMedia(const char* src){

    int flag = IMG_INIT_JPG;
    if(!(IMG_Init(flag) & flag)){
        std :: cout << "IMG nu a fost initializat:" << SDL_GetError();
        return false;
    }
    else{

        SDL_Surface* surface = IMG_Load(src);

        if(surface == NULL){
            std :: cout << "Suprafata nu a fost incarcata:" << SDL_GetError();
            return false;
        }
        else{
            m_dotTexture = SDL_CreateTextureFromSurface(renderer,surface);

            if(m_dotTexture == NULL){
                std :: cout << "Textura neinitializata:" << SDL_GetError();
                return false;
            }
            else{

                m_width = surface -> w;
                m_height = surface -> h;

                SDL_FreeSurface(surface);
            }
        }
    }

    return true;
}
*/

void Dot::setSize(SDL_Surface* surface){

    m_width = surface -> w;
    m_height = surface -> h;
}
