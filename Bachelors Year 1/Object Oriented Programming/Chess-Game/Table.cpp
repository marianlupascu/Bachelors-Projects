#include "Table.h"

Table::Table(){}

Table::Table(int x){

    m_width = 0;
    m_height = 0;
    m_cellWidth = 0;
    m_cellHeight = 0;
    m_colNumber = x;
    m_rowNumber = x;
}

Table::~Table(){
    SDL_DestroyTexture(m_texture);
}

void Table::setSize(SDL_Surface* surface){

    m_width = surface -> w;
    m_height = surface -> h;
    m_cellWidth = m_width / m_colNumber;
    m_cellHeight = (m_height - 30) / m_rowNumber;
}

void Table::drawTable(){


}

void Table::Close(){

    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    renderer = NULL;
    window = NULL;

    SDL_Quit();
    IMG_Quit();
    TTF_Quit();
}
