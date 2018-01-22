#include "PieceTexture.h"

void PieceTexture::setSize(SDL_Surface* surface){

    m_width = surface -> w;
    m_height = surface -> h;
    m_pieceWidth = surface -> w / 6;
    m_pieceHeight = surface -> h / 2;
}
