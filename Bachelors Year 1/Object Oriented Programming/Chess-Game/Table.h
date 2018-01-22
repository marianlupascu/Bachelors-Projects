#ifndef TABLE_H_INCLUDED
#define TABLE_H_INCLUDED
#include <SDL.h>
#include "Variables.h"
#include "Texture.h"
#include <iostream>
#include <SDL_image.h>
#include <SDL_ttf.h>


class Table:public Texture{

    private:
        int m_colNumber, m_rowNumber; //numarul de coloare si de linii al tablei
        int m_cellWidth, m_cellHeight; //latimea si inaltimea unui patratel

    public:
        Table();
        Table(int); //constructor
        ~Table();
        void setSize(SDL_Surface*);
        void drawTable();
        void Close(); //un fel de destructor pt librarii

        inline int getCellWidth(){
            return m_cellWidth;
        }

        inline int getCellHeight(){
            return m_cellHeight;
        }
};

#endif // TABLE_H_INCLUDED
