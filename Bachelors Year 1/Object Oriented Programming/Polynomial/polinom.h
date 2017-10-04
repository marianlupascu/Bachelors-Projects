#ifndef POLINOM_H_INCLUDED
#define POLINOM_H_INCLUDED
#define DEGMAX 250
#include <iostream>

class pair_polinom;

class polinom
{
    friend class pair_polinom;
private:
    double* coef;
    unsigned deg;
    unsigned max_deg;
public:
    polinom();
    polinom(unsigned);
    polinom(const polinom&);
    ~polinom();
    const polinom& operator=(const polinom&);
    friend std::istream& operator>>(std::istream&, polinom&);
    friend std::ostream& operator<<(std::ostream&, const polinom&);
    friend unsigned degree(const polinom&);
    double point(double data);
    polinom& operator+(const polinom&);
    polinom& operator-(const polinom&);
    polinom& operator*(const polinom&);
    polinom& diferentiala();
};

class pair_polinom
{
private:
    polinom poly;
    double real;
public:
    pair_polinom();
    pair_polinom(const polinom&, double);
    ~pair_polinom();
    const pair_polinom& operator=(const pair_polinom&);
    friend std::istream& operator>>(std::istream&, pair_polinom&);
    friend std::ostream& operator<<(std::ostream&, const pair_polinom&);
    bool verif_radacina();
};

#endif // POLINOM_H_INCLUDED
