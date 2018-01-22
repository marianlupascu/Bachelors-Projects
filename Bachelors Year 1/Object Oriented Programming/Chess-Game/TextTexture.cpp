#include "TextTexture.h"
#include "Variables.h"
#include "Texture.h"

bool TextTexture::LoadText(const char* text){

    SDL_Color color = {0xFF,0xFF,0xFF};

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
        else
            setSize(textSurface);
    }

    SDL_FreeSurface(textSurface);
    return true;
}

bool TextTexture::LoadFont(){

    m_font = TTF_OpenFont("lazy.ttf",18);

    if(m_font == NULL){
        std::cout << "Font neinitializat " << TTF_GetError() << "\n";
        return false;
    }

    return true;
}

void TextTexture::setSize(SDL_Surface* surface){

    m_width = surface -> w;
    m_height = surface -> h;
}
