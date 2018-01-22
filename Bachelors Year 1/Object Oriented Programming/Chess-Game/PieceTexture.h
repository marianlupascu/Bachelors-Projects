#ifndef PIECETEXTURE_H_INCLUDED
#define PIECETEXTURE_H_INCLUDED
#include "Texture.h"

class PieceTexture:public Texture{

    private:
        int m_pieceHeight;
        int m_pieceWidth;

    public:
        void setSize(SDL_Surface*);

        inline int getPieceWidth(){
            return m_pieceWidth;
        }

        inline int getPieceHeight(){
            return m_pieceHeight;
        }

        inline void setAlpha(int a){
            SDL_SetTextureAlphaMod(m_texture,a);
        }
};


#endif // PIECETEXTURE_H_INCLUDED
