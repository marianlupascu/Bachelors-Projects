#include "Gauss.h"

int cmmdc( int, int );
fractie operator+ ( fractie, fractie );
fractie operator- ( fractie, fractie );
fractie operator* ( fractie, fractie );

FormaPatratica::FormaPatratica ( )  : dim(0) {}

FormaPatratica::FormaPatratica ( int param ) : dim(param) {
    if( param >= DIMMAX )
    {
        std::cerr << "Dimensiunea spatiului este prea mare \n";
        throw "Dimensiunea spatiului este prea mare \n";
    }
}

FormaPatratica::FormaPatratica ( int param, int* matrice[] ) : dim( param ) {
    if( param >= DIMMAX )
    {
        std::cerr << "Dimensiunea spatiului este prea mare \n";
        throw "Dimensiunea spatiului este prea mare \n";
    }
    for( int i = 1; i <= dim; i++)
            for( int j = 1; j <= dim; j++ )
                m[i][j] = matrice[i][j];
}

std::istream& operator>> ( std::istream& in, FormaPatratica& param ) {
    if( in == std::cin )
    {
        std::cout << "Dimensiunea spatiului = ";
        std::cin >> param.dim;
        if( param.dim >= DIMMAX )
        {
            std::cerr << "Dimensiunea spatiului este prea mare \n";
            throw "Dimensiunea spatiului este prea mare \n";
        }
        for( int i = 1; i <= param.dim; i++)
            for( int j = i; j <= param.dim; j++ )
            {
                std::cout << "x" << i << " * x" << j << " = ";
                in >> param.m[i][j];
                if( i != j )
                {
                    param.m[j][i] = param.m[i][j];
                }
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
        for( int i = 1; i <= param.dim; i++)
            for( int j = 1; j <= param.dim; j++ )
            {
                in >> param.m[i][j];
                if( i != j )
                    param.m[i][j] *= 2;
            }

    }
    return in;
}

std::ostream& operator<< ( std::ostream& out, const FormaPatratica& param ) {
    if( out == std::cout )
    {
        std::cout << "Dimensiunea spatiului = " << param.dim << '\n';
        std::cout << "    ";
        for( int i = 1; i <= param.dim; i++)
            std::cout << std::setw(4) << i;
        std::cout << '\n';
        for( int i = 1; i <= param.dim * param.dim * param.dim; i++)
            std::cout <<"_";
        std::cout << '\n';
        for( int i = 1; i <= param.dim; i++)
        {
            std::cout << " "<< i << " |";
            for( int j = 1; j <= param.dim; j++ )
                if( i != j)
                    std::cout << std::setw(4) << std::setprecision(2) << (float)param.m[i][j] / 2;
                else
                    std::cout << std::setw(4) << std::setprecision(2) << (float)param.m[i][j];
            std:: cout << '\n';
        }
    }
    else
    {
        out << param.dim << '\n';
        for( int i = 1; i <= param.dim; i++)
        {
            for( int j = 1; j <= param.dim; j++ )
                out << param.m[i][j];
            out << '\n';
        }
    }
    return out;
}

bool FormaPatratica::Este_Forma_Patratica () const {
    for( int i = 1; i <= dim; i++)
            for( int j = i + 1; j <= dim; j++ )
                if(m[i][j] != m[j][i])
                    return false;
    return true;
}

std::pair < fractie, std::vector < fractie > > FormaPatratica::Eliminare_Gauss_pe_linii( int linie, fractie m_auxiliara[][DIMMAX] ) const {

    std::vector < fractie > rezultat;

    if( m_auxiliara[linie][linie].first == 0 && linie != dim )
        throw 0;

    fractie F = std::make_pair( m_auxiliara[linie][linie].second, m_auxiliara[linie][linie].first );

    rezultat.push_back( m_auxiliara[linie][linie] );

    for(int i = linie + 1; i <= dim; i++)
    {
        m_auxiliara[linie][i] = (m_auxiliara[linie][i] * std::make_pair(1,2) );

        rezultat.push_back( m_auxiliara[linie][i] );
    }

    for( int i = linie + 1; i <= dim; i++ )
        for( int j = i; j <= dim; j++ )
            if( i == j )
                m_auxiliara[i][j] = m_auxiliara[i][j] - ( F * m_auxiliara[linie][i] * m_auxiliara[linie][j] );
            else
                m_auxiliara[i][j] = m_auxiliara[i][j] - ( F * m_auxiliara[linie][i] * m_auxiliara[linie][j] * std::make_pair(2, 1) );

    return std::make_pair( F, rezultat );
}

std::vector < std::pair < fractie, std::vector < fractie > > > FormaPatratica::Eliminare_Gauss( ) const {

    std::vector < std::pair < fractie, std::vector < fractie > > > rezultat;

    fractie m_auxiliara[DIMMAX][DIMMAX];

    for( int i = 1; i <= dim; i++)
            for(int j = i; j <= dim; j++)
                    m_auxiliara[i][j] = std::make_pair( m[i][j], 1 );

    for( int i = 1; i <= dim; i++ )
    {
//        std::cout<<'\n';
        try{
            rezultat.push_back( Eliminare_Gauss_pe_linii(i, m_auxiliara) ); }
        catch( int ){
            std::cerr << "Exista 0 pe diagonala principala \n"; throw; }
//        for( int i = 1; i <= dim; i++)
//        {
//            for( int j = 1; j <= dim; j++ )
//                std::cout <<m_auxiliara[i][j].first<<"/"<<m_auxiliara[i][j].second<<"    ";
//            std::cout << '\n';
//        }
    }


    return rezultat;
}

void FormaPatratica::Afisare_forma_Canonica( std::ostream& out ) const {

    if(!Este_Forma_Patratica())
        out << "Nu este forma biliniara deoarece nu e simetrica \n";
    else
    {
        std::vector < std::pair < fractie, std::vector < fractie > > > aux = Eliminare_Gauss();

        out << '\n';

        for(int i = 0; i < aux.size(); i++)
        {
            if( i < aux.size() - 1 )
                if(aux[i].first.first)
                {
                    out<<aux[i].first.first<<"/"<<aux[i].first.second<<" * ( ";
                    for(int j = 0; j < aux[i].second.size(); j++)
                        if( j < aux[i].second.size() - 1 )
                            if(aux[i].second[j].first)
                                out<<aux[i].second[j].first<<"/"<<aux[i].second[j].second<<"*x"<<j+i+1<<" + ";
                            else
                                out << 0;
                        else
                            if(aux[i].second[j].first)
                                out<<aux[i].second[j].first<<"/"<<aux[i].second[j].second<<"*x"<<j+i+1;
                            else
                                out << 0;
                    out<<" )^2 + ";
                }
                else;
            else
                if(aux[i].first.first)
                {
                    out<<aux[i].first.first<<"/"<<aux[i].first.second<<" * ( ";
                    for(int j = 0; j < aux[i].second.size(); j++)
                        if( j < aux[i].second.size() - 1 )
                            if(aux[i].second[j].first)
                                out<<aux[i].second[j].first<<"/"<<aux[i].second[j].second<<"*x"<<j+i+1<<" + ";
                            else
                                out << 0;
                        else
                            if(aux[i].second[j].first)
                                out<<aux[i].second[j].first<<"/"<<aux[i].second[j].second<<"*x"<<j+i+1;
                            else
                                out << 0;
                    out<<" )^2 \n";
                }
        }
    }

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
    return C;
}

