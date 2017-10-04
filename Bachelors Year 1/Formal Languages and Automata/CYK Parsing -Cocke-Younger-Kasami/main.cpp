#include<bits/stdc++.h>
#define FOR(i,a,b) for(i=a;i<b; i++)

using namespace std;

const int DIMMAX = 100;

string gram[DIMMAX][DIMMAX];  //to store entered grammar
string productie[DIMMAX], start;
int p, nr_productii;
string Tabel[DIMMAX][DIMMAX], cuvant;

bool is_CNF_st (string);
bool is_CNF_dr (string);
string Concat_Simboluri (string, string);
void Separare (string);
string Cauta_productii (string);
string Generare_combinatii (string, string);
void citire();

ifstream fin ("Grammar.in");

void citire()
{
    int poz_despartire;
    string linie;

    start = "S";
    fin >> nr_productii;
    fin.get();

    for(int i = 0; i < nr_productii; i++)
    {
        fin >> linie;
        fin.get();

        poz_despartire = linie.find("->");
        gram[i][0] = linie.substr(0, poz_despartire);
        if (is_CNF_st(gram[i][0]) == 0)
        {
            cout << "\nGramatica nu este CNF";
            abort();
        }
        linie = linie.substr(poz_despartire + 2, linie.length());

        Separare(linie);

        for(int j = 0; j < p; j++)
        {
            gram[i][j+1] = productie[j];
            if (is_CNF_dr(productie[j]) == 0)
            {
                cout << "\nGramatica nu este CNF";
                abort();
            }
        }
    }
}

string Concat_Simboluri (string str1, string str2) //concateneaza non-terminalele
{
    string str_aux = str1;
    for (int i = 0; i < str2.length(); i++)
        if (str_aux.find(str2[i]) > str_aux.length())
            str_aux += str2[i];
    return str_aux;
}

void Separare (string init) // separa productia initiala
{
    int i;
    p = 0;
    while (init.length())
    {
        i = init.find("|");
        if(i > init.length())
        {
            productie[p++] = init;
            init = "";
        }
        else
        {
            productie[p++] = init.substr(0, i);
            init = init.substr(i+1, init.length());
        }
    }
}

bool is_CNF_st (string str)   //verifica la stanga daca o productie este CNF
{
    if (str.length() == 1 && str[0] >= 'A' && str[0] <= 'Z')
        return true;
    return false;
}

bool is_CNF_dr (string str)   //verifica la dreapta daca o productie este CNF
{
    if (str.length() == 1 && str[0]>='a' && str[0] <='z')
        return true;
    if (str.length() == 2 && str[0] >= 'A' && str[0] <= 'Z' && str[1] >= 'A' && str[1] <= 'Z' )
        return true;
    if (str.length() == 3 && str[0] >= 'A' && str[0] <= 'Z' && str[1] >= 'A' && str[1] <= 'Z' && str[2] >= 'A' && str[2] <= 'Z')
        return true;
    return false;
}

string Cauta_productii (string str) //returneazã un string de variabile concatenate care pot produce stringul str
{
    int k;
    string aux = "";
    for(int i = 0; i < nr_productii; i++)
    {
        k = 1;
        while(gram[i][k] != "")
        {
            if(gram[i][k] == str)
                aux = Concat_Simboluri(aux, gram[i][0]);
            k++;
        }
    }
    return aux;
}

string Generare_combinatii (string str1, string str2)  //creaza combinatii crescatoare pe pozitii cu stringurile str1, str2
{
    string generator = str1, aux="";
    for(int i = 0; i < str1.length(); i++)
        for(int j = 0; j < str2.length(); j++)
        {
            generator = "";
            generator = generator + str1[i] + str2[j];
            aux = aux + Cauta_productii(generator);     //searches if the generated productions can be created or not
        }
    return aux;
}

void procesare()
{
    string p_final, cautat;
    cout<<"\nDati cuvantul de parsat : ";
    cin >> cuvant;
    for(int i = 0; i < cuvant.length(); i++)       //Completare linia 1 in tabel
    {
        p_final="";
        cautat = cuvant[i];
        for(int j = 0; j < nr_productii; j++)
            for(int k = 1; gram[j][k] != ""; k++)
                if(gram[j][k] == cautat)
                    p_final = Concat_Simboluri(p_final,gram[j][0]);
        Tabel[0][i] = p_final;
    }

    for(int k = 1; k < cuvant.length(); k++)       //Completarea resului tabelului
        for(int j = 0; j < cuvant.length() - k; j++)
        {
            p_final="";
            for(int l = 0; l < k; l++)
                p_final = Concat_Simboluri(p_final, Generare_combinatii(Tabel[l][j],Tabel[k-1-l][j+l+1]));
            Tabel[k][j] = p_final;
        }
}

void afisare()
{
    for(int i = 0; i < cuvant.length(); i++)
    {
        for(int j = 0; j < cuvant.length() - i; j++)
            if(Tabel[i][j].length())
                cout<<setw(5)<<Tabel[i][j]<<" ";
            else
                cout<<setw(5)<<"- ";
        cout<<endl;
    }

    for(int i = 0; i < start.length(); i++)
        if(Tabel[cuvant.length()-1][0].find(start[i]) <= Tabel[cuvant.length()-1][0].length())   //Caut in coltul din stanga jos al tabelului simbolul de start
        {
            cout<<"Stringul dat poate fi generat\n";
            return;
        }
    cout<<"Stringul dat nu poate fi generat\n";
}

int main()
{
    citire();

    procesare();

    afisare();

    return 0;
}
