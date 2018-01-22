#ifndef DOT_H_INCLUDED
#define DOT_H_INCLUDED
#include <SDL.h>
#include <SDL_image.h>
#include "Variables.h"
#include <iostream>
#include "Texture.h"

class Dot:public Texture{

    public:
        Dot(){}
        void f(){std::cout << "DA";}
        void setSize(SDL_Surface*);
        //~Dot(){
        //    SDL_DestroyTexture(m_texture);
};

#endif // DOT_H_INCLUDED
