#ifndef PIECES_H
#define PIECES_H

#include <vector>
#include "Table.h"
#include <SDL.h>

class Pieces{

    public:
        enum Color{
            WHITE,
            BLACK
        };
        enum Piece_type{
            PAWN,
            ROOK,
            KNIGHT,
            BISHOP,
            QUEEN,
            KING
        };

    protected:
        std::pair < int, int > m_pozition; //intre 0 si 7
        Color m_color;
        Piece_type type;
        bool m_alive;
        bool m_selected;
        bool m_moved;

        std::pair < int, int > m_texture_aux;
        int m_repeat;
        int m_moves;
        int sign(Color);
        SDL_Point m_tableCorner; // coordonatele de pe tabla unde va fi afiasata piesa(coltul patratelului)
        SDL_Point m_textureCorner; //coordonatele din poza cu piese de unde va fi afisata piesa(tot colt)

    public:
        Pieces();
        Pieces(std::pair < int, int >, Color, std::pair < int, int >);
        Pieces(int, int, Color, int, int);
        virtual ~Pieces();
        //SDL_Point getEvent(SDL_Event*);

        inline int getTableCornerX(){
            return m_tableCorner.x;
        }

        inline int getTableCornerY(){
            return m_tableCorner.y;
        }

        inline int getTextureCornerX(){
            return m_textureCorner.x;
        }

        inline int getTextureCornerY(){
            return m_textureCorner.y;
        }

        inline void setSelected(bool x){
            m_selected = x;
        }

        inline void setAlive(bool x){
            m_alive = x;
        }

        inline bool isSelected() const {
            return m_selected;
        }

        inline bool isAlive() const {
            return m_alive;
        }

    /*    inline void setAlpha(int a){
            SDL_SetTextureAlphaMod(m_texture,a);
        }*/

        inline void setTableCornerX(int x){
            m_tableCorner.x = x;
        }

        inline void setTableCornerY(int y){
            m_tableCorner.y = y;
        }

        inline Color getColor() const {
            return m_color;
        }

        inline void setMoved(bool x){
            m_moved = x;
        }

        inline bool getMoved() const {
            return m_moved;
        }

        inline int getColumn() const {
            return m_pozition.second;
        }
        //void setColumn(int column);
        inline int getRow() const {
            return m_pozition.first;
        }
        //void setRow(int row);
        inline std::pair <int, int> getPozition() const {
            return m_pozition;
        }

        inline void setPozition( std::pair < int, int > pos){
            m_pozition = pos;
        }

        inline Piece_type getType() const {
            return type;
        }

        virtual bool valid ( std::pair < int, int >, Pieces* const [][8] ) const = 0;
        virtual std::vector < std::pair < int, int > > getPossibleMoves(Pieces* const [][8] ) const = 0;
        std::pair < int, int > Get_King_Pozition( Pieces::Color, Pieces* const [][8] ) const;
};


#endif // PIECES_H
