#ifndef TEXTTEXTURE_H_INCLUDED
#define TEXTTEXTURE_H_INCLUDED
#include "Texture.h"
#include <SDL.h>
#include <SDL_ttf.h>

class TextTexture:public Texture{

    private:
        TTF_Font* m_font;

    public:
        void setSize(SDL_Surface*);
        bool LoadText(const char*);
        bool LoadFont();
};




#endif // TEXTTEXTURE_H_INCLUDED
