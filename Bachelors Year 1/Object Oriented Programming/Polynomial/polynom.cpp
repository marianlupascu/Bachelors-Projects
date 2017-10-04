#include "polinom.h"
#include <iostream>
#include <stdexcept>
#include <math.h>

polinom::polinom(){
    deg = 0;
    max_deg = DEGMAX;
    coef = new double [DEGMAX];
    for(unsigned i = 0; i < DEGMAX; i++)
        coef[i] = 0.0;
}

polinom::polinom(unsigned nr) {
    deg = 0;
    max_deg = nr;
    coef = new double [nr];
    for(unsigned i = 0; i < nr; i++)
        coef[i] = 0.0;
}

polinom::polinom(const polinom& obj) {
    deg = obj.deg;
    max_deg = obj.max_deg;
    coef = new double [max_deg];
    for(unsigned i = 0; i < max_deg; i++)
        coef[i] = obj.coef[i];
}

polinom::~polinom() {
    delete [] coef;
}

const polinom& polinom::operator=(const polinom& obj) {
    if (this != &obj)
    {
        delete [] this -> coef;
        deg = obj.deg;
        max_deg = obj.max_deg;
        coef = new double [max_deg];
        for(unsigned i = 0; i <= max_deg; i++)
            coef[i] = obj.coef[i];
    }
    return (*this);
}

std::istream& operator>>(std::istream& in, polinom& obj) {
    int sch;
    if(in == std::cin)
        sch = 1;
    else
        sch = 2;
    switch (sch)
    {
    case 1:
        {
            std::cout<<"Daca a-ti finalizat procesul de citire al polinomului tastari -1 pentru exponent. \n";
            unsigned exp = 0;
            double coeficient;
            for(unsigned i = 1;; i++)
            {
                std::cout<<"Exponentul numarul "<<i<<" = ";
                in>>exp;
                if(exp < 0 || exp > obj.max_deg)
                {
                    throw std::out_of_range("Indexul iese din vector");
                    break;
                }
                if(obj.coef[exp])
                    std::cout<<"X^"<<exp<<" este scris deja...\n";
                std::cout<<"Coeficientul lui X^"<<exp<<" = ";
                in>>coeficient;
                obj.coef[exp] = coeficient;
            }
            break;
        }
    case 2:
        {
            unsigned exp;
            double coeficient;
            while(in >> exp >> coeficient)
            {
                if(exp < 0 || exp > obj.max_deg)
                {
                    throw std::out_of_range("Indexul iese din vector");
                    break;
                }
                obj.coef[exp] = coeficient;
            }
            break;
        }
    }
    obj.deg = degree(obj);
    return in;
}

std::ostream& operator<<(std::ostream& out, const polinom& obj) {
    for(unsigned i = 0; i < obj.deg; i++)
    {
        if(obj.coef[i])
            out << obj.coef[i] << "*X^" << i << " + ";
    }
    out << obj.coef[obj.deg] << "*X^" << obj.deg;
    return out;
}

unsigned degree(const polinom& obj)
{
    unsigned deg_max = 0;
    for(unsigned i = 0; i < obj.max_deg; i++)
        if(obj.coef[i])
            deg_max = i;
    return deg_max;
}

double polinom::point(double data)
{
    unsigned val_polinom = 0;
    for(unsigned i = 0; i <= deg; i++)
        if(coef[i])
            val_polinom += (double)pow(data, i) * coef[i];
    return val_polinom;
}

polinom& polinom::operator+(const polinom& obj) {
    polinom* sum = new polinom;
    sum -> max_deg = std::max(max_deg, obj.max_deg);
    sum -> deg = std::max(deg, obj.deg);
    for(unsigned i = 0; i <= sum -> deg; i++)
        sum -> coef[i] = coef[i] + obj.coef[i];
    return *sum;
}

polinom& polinom::operator-(const polinom& obj) {
    polinom* sum = new polinom;
    sum -> max_deg = std::max(max_deg, obj.max_deg);
    sum -> deg = std::max(deg, obj.deg);
    for(unsigned i = 0; i <= sum -> deg; i++)
        sum -> coef[i] = coef[i] - obj.coef[i];
    return *sum;
}

polinom& polinom::operator*(const polinom& obj) {
    polinom* sum = new polinom;
    sum -> max_deg = std::min((int)(max_deg + obj.max_deg), DEGMAX);
    sum -> deg = deg + obj.deg;
    if(sum -> deg >= sum -> max_deg)
        throw std::out_of_range("Inmultirea da pe afara");
    for(unsigned i = 0; i <= deg; i++)
    {
        for(unsigned j = 0; j <= obj.deg; j++)
        {
            if(coef[i] && obj.coef[j])
                sum -> coef[i + j] += coef[i] * obj.coef[j];
        }
    }
    return *sum;
}

polinom& polinom::diferentiala()
{
    polinom* dif = new polinom;
    dif -> max_deg = max_deg;
    if(deg >= 0)
        dif -> deg = deg - 1;
    else
    {
        deg = 0;
        dif -> coef[0] = 0;
    }

    for(unsigned i = 1; i <= deg; i++)
    {
        if(coef[i])
            dif -> coef[i - 1] += coef[i] * i;
    }
    return *dif;
}
