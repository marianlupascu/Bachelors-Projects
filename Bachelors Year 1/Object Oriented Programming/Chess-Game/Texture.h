#ifndef TEXTURE_H_INCLUDED
#define TEXTURE_H_INCLUDED
#include <SDL.h>
#include <SDL_image.h>
#include <SDL_ttf.h>
#include <iostream>

class Texture{

    protected:
        int m_height, m_width;
        SDL_Texture* m_texture;

    public:
        void Render(int,int,SDL_Rect*);
        bool LoadMedia(const char*);
        bool Init();
        //bool LoadText(const char*);
        virtual void setSize(SDL_Surface*){}
        virtual bool LoadFont(){}
        virtual bool LoadText(const char*){}
        inline int getWidth(){
            return m_width;
        }

        inline int getHeight(){
            return m_height;
        }

        virtual inline int getCellWidth(){}
        virtual inline int getCellHeight(){}
        virtual inline int getPieceWidth(){}
        virtual inline int getPieceHeight(){}
        virtual inline void setAlpha(int a){}
        virtual void Close(){}

};


#endif // TEXTURE_H_INCLUDED
