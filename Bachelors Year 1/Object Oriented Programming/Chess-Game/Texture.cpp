#include "Texture.h"
#include "Variables.h"

void Texture::Render(int x,int y,SDL_Rect* rect){
    //std :: cout << x << " " << y << std :: endl;
    SDL_Rect auxRect;
    auxRect.x = x;
    auxRect.y = y;
    auxRect.w = rect -> w;
    auxRect.h = rect -> h;

    //std :: cout << auxRect.w << " " << auxRect.h << std :: endl << "\n";

    SDL_RenderCopy(renderer,m_texture,rect,&auxRect);
}

bool Texture::LoadMedia(const char* src){

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
            m_texture = SDL_CreateTextureFromSurface(renderer,surface);

            if(m_texture == NULL){
                std :: cout << "Textura neinitializata:" << SDL_GetError();
                return false;
            }
            else{
                setSize(surface);
                SDL_FreeSurface(surface);
            }
        }
    }

    /*m_font = TTF_OpenFont("font.otf",18);

    if(m_font == NULL){
        std::cout << "Font neinitializat\n";
        return false;
    }
*/
    return true;
}

bool Texture::Init(){

    if((SDL_Init(SDL_INIT_VIDEO) || SDL_Init(SDL_INIT_EVENTS) || SDL_Init(SDL_INIT_AUDIO))){
        std :: cout << "SDL Video sau SDL Audio sau SDL Event neinitializat:" << SDL_GetError();
        return false;
    }
    else
        window = SDL_CreateWindow("Chess Game",SDL_WINDOWPOS_CENTERED,SDL_WINDOWPOS_CENTERED,
                                  SCREEN_WIDTH,SCREEN_HEIGHT,SDL_WINDOW_SHOWN);

    if(window == NULL){
        std :: cout << "Fereastra nu a fost initializata:" << SDL_GetError();
        return false;
    }

    if(!SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY,"1")){
        std :: cout << "Linear texture neinitializat:" << SDL_GetError();
        return false;
    }
    else
        renderer = SDL_CreateRenderer(window,-1,SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);

    if(renderer == NULL){
        std :: cout << "Rendererul nu a fost initializat:" << SDL_GetError();
        return false;
    }
    else
        SDL_SetRenderDrawColor(renderer,0,0,0xFF,0xFF);

    int flag = IMG_INIT_JPG;

    if(!(IMG_Init(flag) & flag)){
        std :: cout << "IMG nu a fost initializat:" << SDL_GetError();
        return false;
    }

    if(TTF_Init()){
        std :: cout << "TTF nu a fost initializat:" << SDL_GetError();
        return 0;
    }

    return true;
}

/*bool Texture::LoadText(const char* text){

    SDL_Color color = {0,0,0};
    SDL_DestroyTexture(m_texture);

    SDL_Surface* textSurface = TTF_RenderText_Solid(m_font,text,color);

    if(textSurface == NULL){
        std::cout << "TextSurface nu a fost initializata\n";
        return false;
    }
    else{
        m_texture = SDL_CreateTextureFromSurface(renderer,textSurface);

        if(m_texture == NULL){
            std::cout << "Textura pentru text neinitializata\n";
            return false;
        }
    }

    SDL_FreeSurface(textSurface);
    return true;
}*/

