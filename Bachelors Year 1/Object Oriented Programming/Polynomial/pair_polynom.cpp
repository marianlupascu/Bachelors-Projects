#include "polinom.h"
#include <iostream>

pair_polinom::pair_polinom(): real(0) {}

pair_polinom::pair_polinom(const polinom& obj, double re){
    poly = obj;
    real = re;
}

pair_polinom::~pair_polinom() {
    delete [] poly.coef;
}

const pair_polinom& pair_polinom::operator=(const pair_polinom& obj) {
    if (this != &obj)
    {
        real = obj.real;
        delete [] this -> poly.coef;
        poly.deg = obj.poly.deg;
        poly.max_deg = obj.poly.max_deg;
        poly.coef = new double [poly.max_deg];
        for(unsigned i = 0; i <= poly.max_deg; i++)
            poly.coef[i] = obj.poly.coef[i];
    }
    return (*this);
}

std::istream& operator>>(std::istream& in, pair_polinom& obj) {
    double real;
    if(in == std::cin)
    {
        std::cout<<"Dati un numar real:";

    }
    in >> obj.real;
    in >> obj.poly;
    return in;
}
std::ostream& operator<<(std::ostream& out, const pair_polinom& obj) {
    out<<obj.real<<'\n';
    out<<obj.poly;
}

bool pair_polinom::verif_radacina()
{
    if(!poly.point(real))
        return true;
    else
        return false;
}
