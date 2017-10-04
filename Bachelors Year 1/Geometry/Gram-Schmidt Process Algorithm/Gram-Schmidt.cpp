#include "Gram-Schmidt.h"

int cmmdc( int, int );
fractie operator+ ( fractie, fractie );
fractie operator- ( fractie, fractie );
fractie operator* ( fractie, fractie );
fractie operator/ ( fractie, fractie );
std::vector < fractie > operator* (fractie , std::vector < fractie > );
std::vector < fractie > operator- (std::vector < fractie >, std::vector < fractie > );

baza::baza ( )  : dim(0) {}

baza::baza ( int param ) : dim(param) {
    if( param >= DIMMAX )
    {
        std::cerr << "Dimensiunea spatiului este prea mare \n";
        throw "Dimensiunea spatiului este prea mare \n";
    }
}

baza::baza ( int param, std::vector < fractie > matrice[] ) : dim( param ) {
    if( param >= DIMMAX )
    {
        std::cerr << "Dimensiunea spatiului este prea mare \n";
        throw "Dimensiunea spatiului este prea mare \n";
    }
    bool ok = true;
    for( int i = 0; i < dim && ok; i++ )
        if( matrice[i].size() != dim )
            ok = false;
    if( !ok )
    {
        std::cerr << "Matricea data ca parametru constructorului nu corespunde dimensiunii... \n";
        throw "Matricea data ca parametru constructorului nu corespunde dimensiunii \n";
    }

    for( int i = 0; i < dim; i++)
        baz[i] = matrice[i];
}

std::istream& operator>> ( std::istream& in, baza& param ) {

    std:: vector < fractie > aux;
    int x;

    if( in == std::cin )
    {
        std::cout << "Dimensiunea spatiului = ";
        std::cin >> param.dim;
        if( param.dim >= DIMMAX )
        {
            std::cerr << "Dimensiunea spatiului este prea mare \n";
            throw "Dimensiunea spatiului este prea mare \n";
        }
        for( int i = 0; i < param.dim; i++)
        {
            for( int j = 0; j < param.dim; j++ )
            {
                std::cout << "b[" << i << "][" << j << "] = ";
                in >> x;
                aux.push_back( std::make_pair(x, 1) );
            }
            param.baz[i] = aux;
            aux.clear();
        }
    }
    else
    {
        in >> param.dim;
        if( param.dim >= DIMMAX )
        {
            std::cerr << "Dimensiunea spatiului este prea mare \n";
            throw "Dimensiunea spatiului este prea mare \n";
        }
        for( int i = 0; i < param.dim; i++)
        {
            for( int j = 0; j < param.dim; j++ )
            {
                in >> x;
                aux.push_back( std::make_pair(x, 1) );
            }
            param.baz[i] = aux;
            aux.clear();
        }
    }
    return in;
}

std::ostream& operator<< ( std::ostream& out, const baza& param ) {
    if( out == std::cout )
    {
        std::cout << "Dimensiunea spatiului = " << param.dim << '\n';
        std::cout << "Vectorii ortonormali sunt: \n";
        for( int i = 0; i < param.dim; i++)
        {
            for( int j = 0; j < param.dim; j++ )
            {
                out << "o[" << i << "][" << j << "] = ";
                out << param.ort[i][j].first << "/" << param.ort[i][j].second << " ; " << std::setw(5);
            }
            out << '\n';
        }
    }
    else
    {
        out << param.dim << '\n';
        for( int i = 0; i < param.dim; i++)
        {
            for( int j = 0; j < param.dim; j++ )
            {
                out << "o[" << i << "][" << j << "] = ";
                out << param.ort[i][j].first << "/" << param.ort[i][j].second << " ; ";
            }
            out << '\n';
        }
    }
    return out;
}

fractie determ( fractie a[][DIMMAX], int n ) {
    fractie det = std::make_pair(0, 1);
    int p, h, k, i, j;
    fractie temp[DIMMAX][DIMMAX];
    if(n==1)
        return a[0][0];
    else
        if(n==2)
        {
            det=(a[0][0]*a[1][1]-a[0][1]*a[1][0]);
            return det;
        }
        else
            {
                for(p=0;p<n;p++)
                {
                    h = 0; k = 0;
                    for(i=1;i<n;i++)
                        for( j=0;j<n;j++)
                        {
                            if(j==p)
                                continue;
                            temp[h][k] = a[i][j];
                            k++;
                            if(k==n-1) { h++; k = 0; }
                        }
                det = det + a[0][p] * std::make_pair( (int)pow(-1,p), 1 ) * determ( temp, n - 1);
                }
            return det;
            }
}

bool baza::Este_Baza () const {
    fractie M[DIMMAX][DIMMAX];
    for(int i = 0; i < dim; i++)
        for(int j = 0; j < dim; j++)
            M[i][j] = baz[i][j];
    fractie D = determ( M , dim );
    return (bool)D.first;
}

fractie baza::Produs_scalar ( std::vector < fractie > A, std::vector < fractie > B ) const {
    fractie Rez = std::make_pair( 0, 1 );

    for(int i = 0; i < A.size(); i++)
        Rez = Rez + ( A[i] * B[i] );

    return Rez;
}

void baza::Ortonormalizare_Gram_Schmidt( ) {

    if( ! Este_Baza() )
    {
        std::cerr << "Baza data nu este o baza valida, matricea anexata are determinantul nul\n";
        throw "Baza data nu este o baza valida, matricea anexata are determinantul nul \n";
    }

    for(int i = 0; i < dim; i++)
    {
        std::vector < fractie > linie = baz[i];
        for(int j = 0; j < i; j++)
            linie = linie - ( ( Produs_scalar( ort[j], baz[i] ) / Produs_scalar( ort[j], ort[j] ) ) * ort[j] );

        ort[i] = linie;
    }
}

std::vector < fractie > operator* (fractie A, std::vector < fractie > B)
{
    std::vector < fractie > Rez;
    Rez = B;
    for(int i = 0; i < Rez.size(); i++)
        Rez[i] = Rez[i] * A;
    return Rez;
}

std::vector < fractie > operator- (std::vector < fractie > A, std::vector < fractie > B)
{
    std::vector < fractie > Rez;
    Rez = A;
    for(int i = 0; i < Rez.size(); i++)
        Rez[i] = Rez[i] - B[i];
    return Rez;
}

int cmmdc( int a, int b )
{
    if( b == 0 )
        return a;
    else return cmmdc( b, a % b );
}

fractie operator+ ( fractie A, fractie B )
{
    fractie C;
    C.first = A.first * B.second + A.second * B.first;
    C.second = A.second * B.second;
    int num_comun = cmmdc( C.first, C.second );
    C.first /= num_comun;
    C.second /= num_comun;
    if( C.second < 0)
    {
        C.second *= -1;
        C.first *= -1;
    }
    return C;
}

fractie operator- ( fractie A, fractie B )
{
    fractie C;
    C.first = A.first * B.second - A.second * B.first;
    C.second = A.second * B.second;
    int num_comun = cmmdc( C.first, C.second );
    C.first /= num_comun;
    C.second /= num_comun;
    if( C.second < 0)
    {
        C.second *= -1;
        C.first *= -1;
    }
    return C;
}

fractie operator* ( fractie A, fractie B )
{
    fractie C;
    C.first = A.first * B.first;
    C.second = A.second * B.second;
    int num_comun = cmmdc( C.first, C.second );
    C.first /= num_comun;
    C.second /= num_comun;
    if( C.second < 0)
    {
        C.second *= -1;
        C.first *= -1;
    }
    return C;
}

fractie operator/ ( fractie A, fractie B )
{
    fractie C;
    C.first = A.first * B.second;
    C.second = A.second * B.first;
    int num_comun = cmmdc( C.first, C.second );
    C.first /= num_comun;
    C.second /= num_comun;
    if( C.second < 0)
    {
        C.second *= -1;
        C.first *= -1;
    }
    return C;
}
