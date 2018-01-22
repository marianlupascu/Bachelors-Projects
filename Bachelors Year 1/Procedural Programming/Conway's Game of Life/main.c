#include <stdio.h>
#include <stdlib.h>
#define DIMMAX 1005 /* Constanta simbolica ce retine dimensiunile
                       maxime de intrare*/
#define FOR(i, a, b) for(i = a; i <= b; i++) /* Constanta simbolica */

//---------------------------------------------------------------------------
/* Declarari globale de date (pentru a fi vizibile tuturor functiilor)
 * N: numarul de linii din matricea citita
 * M: munarul de coloane din matricea citita
 * K: numarul de generatii de simulat
 * P: reprezinta indicatorul de harta pe care se simuleaza jocul si poate fi:
      <<P>> pentru harta planara si <<T>> pentru harta toroidala
 * m[][]: reprezinta matricea de biti pe care se desfasoara jocul
 * pereche: tipul de data ce retine o perecge ordonata/ element din matrice
 * stergere[]: vector de perechi ce retine celulele ce trebuie sterse la
               finalul uni pas p, 1<=p<=K, functioneaza similar unei cozi
 * adaugare[]: analog
 * len_s: lungimea vectorului stergere[]
 * len_a: lungimea vectorului adaugare[]
 */

int N, M, K;
char P;
char m[DIMMAX][DIMMAX];
typedef struct
{
     int l, c;
} pereche;

pereche stergere[DIMMAX * DIMMAX];
int len_s;
pereche adaugare[DIMMAX * DIMMAX];
int len_a;
//----------------------------------------------------------------------
/*
 * Functia:  initializare_perechi_cu_0
 * -----------------------
 *  Functia de mai sus initializeaza vectorii de perechi stergere si
    adaugare cu perechea vida (0,0), cu alte cuvinte sterge cozile
    folosite la pasul p, pentru a fi folosdite la pasul p+1
 */
void initializare_perechi_cu_0()
{
    int i;
    pereche vid;
    vid.c = 0;  //initializare prima componenta cu 0
    vid.l = 0;  //initializare a doua componenta cu 0
    FOR(i, 1, len_s)
    {
        stergere[i] = vid;
    }
    len_s = 0;

    FOR(i, 1, len_a)
    {
        adaugare[i] = vid;
    }
    len_a = 0;
}
//----------------------------------------------------------------------
/*
 * Functia:  citire_fisier
 * -----------------------
 *  Functia de mai sus citeste din fisierul input.in datele de intrare,
    adica P, N, M, K si matricea m[][]
 */
void citire_fisier()
{
    freopen("input.in", "r", stdin);

    scanf("%c %d %d %d" ,&P, &M, &N, &K);
    int i, j;

    FOR(i, 1, N)
    {
        FOR(j, 1, M)
        {
            scanf("%d", &m[i][j]);
        }
    }
}
//----------------------------------------------------------------------
/*
 * Functia:  citire
 * -----------------------
 *  Functia de mai sus citeste de la tastatura datele de intrare,
    adica P, N, M, K si matricea m[][]
 */
void citire()
{
    scanf("%c %d %d %d" ,&P, &M, &N, &K);
    int i, j;

    FOR(i, 1, N)
    {
        FOR(j, 1, M)
        {
            scanf("%d", &m[i][j]);
        }
    }
}
//----------------------------------------------------------------------
/*
 * Functia:  afisare_grafica
 * -----------------------
 *  Functia de mai sus afiseaza pe ecran matricea m[][], nu sub forma
    binara, ci sub o forma grafica: daca elementul m[i][j]==1 se vor
    afisa doua dreptunghiuri pline, adica doua caractere ce au codul
    ASCII 219; daca m[i][j]==0 se vor afisa doua dreptunghiuri goale
    adica doua caractere ce au codul ASCII 176
 */
void afisare_grafica()
{
    int i, j;

    FOR(i, 1, N)
    {
        FOR(j, 1, M)
        {
            if(m[i][j] == 1)printf("%c%c", 219, 219);
            else printf("%c%c", 176, 176);
        }
        printf("\n");
    }
    printf("\n");
}
//----------------------------------------------------------------------
/*
 * Functia:  afisare_binara
 * -----------------------
 *  Functia de mai sus afiseaza pe ecran matricea m[][] sub forma
    binara
 */
void afisare_binara()
{
    int i, j;

    FOR(i, 1, N)
    {
        FOR(j, 1, M)
        {
            printf("%d ", m[i][j]);
        }
        printf("\n");
    }
}
//----------------------------------------------------------------------
/*
 * Functia:  calcul_vecini_P
 * -----------------------
 *  Functia de mai sus calculeaza numarul de vecini ai elementului
    m[l][c] pe forma planara astfel: se analizeaza toti ce 8 vecini
    ai celuli m[l][c], acest lucru se bazaza pe indezarea de la 1
    atat pe linie cat si pe coloana, fapt ce permite considerarea
    matrici bordata cu 0. Deci analizarea cazurilor in afara matricii
    nu afecteaza rezultatul dorit

 *  l: linia de pe care se analizeaza celula curenta
 *  c: coloana de pe care se analizeaza celula curenta

 *  returneaza: suma vecinilor celulei curente
 */
int calcul_vecini_P(int l, int c)
{
    int vecini = 0;
    if(m[l][c-1])
        vecini++;
    if(m[l][c+1])
        vecini++;
    if(m[l-1][c])
        vecini++;
    if(m[l+1][c])
        vecini++;
    if(m[l-1][c-1])
        vecini++;
    if(m[l-1][c+1])
        vecini++;
    if(m[l+1][c-1])
        vecini++;
    if(m[l+1][c+1])
        vecini++;
    return vecini;
}
//----------------------------------------------------------------------
/*
 * Functia:  calcul_vecini_T
 * -----------------------
 *  Functia de mai sus calculeaza numarul de vecini ai elementului
    m[l][c] pe forma planara astfel: se analizeaza toti ce 8 vecini
    ai celuli m[l][c] pe 9 cazuri:
 *         cazul 1: daca celula curenta se afla in coltul din stanga
                    sus al matrici
 *         cazul 2: daca celula curenta se afla in coltul din dreapta
                    sus al matrici
 *         cazul 3: daca celula curenta se afla in coltul din stanga
                    jos al matrici
 *         cazul 4: daca celula curenta se afla in coltul din dreapta
                    jos al matrici
 *         cazul 5: daca celula curenta se afla pe prima linie dar
                    nu se afla pe coloanele 1 sau M, fiind analizate
                    pe cazurile 2 si 3
 *         cazul 6: daca celula curenta se afla pe ultima linie dar
                    nu se afla pe coloanele 1 sau M, fiind analizate
                    pe cazurile 3 si 4
 *         cazul 7: daca celula curenta se afla pe prima coloana dar
                    nu se afla pe liniile 1 sau N, fiind analizate
                    pe cazurile 1 si 3
 *         cazul 8: daca celula curenta se afla pe ultima coloana dar
                    nu se afla pe liniile 1 sau N, fiind analizate
                    pe cazurile 2 si 4
 *         cazul 9: altfel, adica daca m[l][c] nu se afla la periferia
                    matrici

 *  l: linia de pe care se analizeaza celula curenta
 *  c: coloana de pe care se analizeaza celula curenta

 *  returneaza: suma vecinilor celulei curente
 */
int calcul_vecini_T(int l, int c)
{
    int vecini = 0, aux;

    if(l == 1 && c == 1) aux = 1;
    else if(l == 1 && c == M) aux = 2;
         else if(l == N && c == 1) aux = 3;
              else if(l == N && c == M) aux = 4;
                   else if(l == 1) aux = 5;
                        else if(l == N) aux = 6;
                             else if(c == 1) aux = 7;
                                  else if(c == M) aux = 8;
                                       else aux = 9;
    switch(aux)
    {
    case 1:
        {
            if(m[1][2])
                vecini++;
            if(m[2][1])
                vecini++;
            if(m[2][2])
                vecini++;
            if(m[N][1])
                vecini++;
            if(m[N][2])
                vecini++;
            if(m[N][M])
                vecini++;
            if(m[1][M])
                vecini++;
            if(m[2][M])
                vecini++;
            break;
        }
    case 2:
        {
            if(m[1][M-1])
                vecini++;
            if(m[2][M-1])
                vecini++;
            if(m[2][M])
                vecini++;
            if(m[N][1])
                vecini++;
            if(m[1][1])
                vecini++;
            if(m[2][1])
                vecini++;
            if(m[N][M-1])
                vecini++;
            if(m[N][M])
                vecini++;
            break;
        }
    case 3:
        {
            if(m[N-1][1])
                vecini++;
            if(m[N-1][2])
                vecini++;
            if(m[N][2])
                vecini++;
            if(m[1][M])
                vecini++;
            if(m[1][1])
                vecini++;
            if(m[1][2])
                vecini++;
            if(m[N-1][M])
                vecini++;
            if(m[N][M])
                vecini++;
            break;
        }
    case 4:
        {
            if(m[N-1][M-1])
                vecini++;
            if(m[N-1][M])
                vecini++;
            if(m[N][M-1])
                vecini++;
            if(m[1][1])
                vecini++;
            if(m[1][M-1])
                vecini++;
            if(m[1][M])
                vecini++;
            if(m[N-1][1])
                vecini++;
            if(m[N][1])
                vecini++;
            break;
        }
    case 5:
        {
            if(m[l][c-1])
                vecini++;
            if(m[l][c+1])
                vecini++;
            if(m[N][c])
                vecini++;
            if(m[l+1][c])
                vecini++;
            if(m[N][c-1])
                vecini++;
            if(m[N][c+1])
                vecini++;
            if(m[l+1][c-1])
                vecini++;
            if(m[l+1][c+1])
                vecini++;
            break;
        }
    case 6:
        {
            if(m[l][c-1])
                vecini++;
            if(m[l][c+1])
                vecini++;
            if(m[l-1][c])
                vecini++;
            if(m[1][c])
                vecini++;
            if(m[l-1][c-1])
                vecini++;
            if(m[l-1][c+1])
                vecini++;
            if(m[1][c-1])
                vecini++;
            if(m[1][c+1])
                vecini++;
            break;
        }
    case 7:
        {
            if(m[l][M])
                vecini++;
            if(m[l][c+1])
                vecini++;
            if(m[l-1][c])
                vecini++;
            if(m[l+1][c])
                vecini++;
            if(m[l-1][M])
                vecini++;
            if(m[l-1][c+1])
                vecini++;
            if(m[l+1][M])
                vecini++;
            if(m[l+1][c+1])
                vecini++;
            break;
        }
    case 8:
        {
            if(m[l][c-1])
                vecini++;
            if(m[l][1])
                vecini++;
            if(m[l-1][c])
                vecini++;
            if(m[l+1][c])
                vecini++;
            if(m[l-1][c-1])
                vecini++;
            if(m[l-1][1])
                vecini++;
            if(m[l+1][c-1])
                vecini++;
            if(m[l+1][1])
                vecini++;
            break;
        }
    case 9:
        {
            if(m[l][c-1])
                vecini++;
            if(m[l][c+1])
                vecini++;
            if(m[l-1][c])
                vecini++;
            if(m[l+1][c])
                vecini++;
            if(m[l-1][c-1])
                vecini++;
            if(m[l-1][c+1])
                vecini++;
            if(m[l+1][c-1])
                vecini++;
            if(m[l+1][c+1])
                vecini++;
            break;
        }
    }
    return vecini;
}
//----------------------------------------------------------------------
float populare = 0; /* va retine gradul maxim de populare la finalul celor
                     K pasi */
int poz; /* va retine pasul p la care populatia este maxima, 1<=p<=K */
//----------------------------------------------------------------------
/*
 * Functia:  calcul_populatie
 * -----------------------
 *  Functia de mai sus memoreaza in variabila populare, populatia
    maxima primita de-a lungul celor K pasi primita prin cont si in
    variabila poz, pozitia pe care populatia este maxima, intreg primit
    de-a lungul celor K pasi prin pas

 *  cont: prin acest intreg se transmite functiei populatia de la pasul p
 *  pas:  prin acest intreg se transmite functiei pasul p
 */
void calcul_populatie(int cont, int pas)
{
    if(cont > populare)
    {
        populare = cont;
        poz = pas;
    }
}
//----------------------------------------------------------------------
/*
 * Functia:  determina_modificarile_dupa_i_pasi
 * -----------------------
 *  Functia de mai sus calculeaza populatia la pasul pas (pentru
    conditia suplimentara), determina numarul de vecini ai fiecarui
    element, actualizeaza  vectorii de perechi stergere si adaugare
    apoi modifica matricea conform enuntului cu ajutorul vectorilor
    de perechi. La final pregateste vectorii de perechi pentru un nou
    apel.

 *  caz: prin acest intreg se transmite codul ASCII al caracterului
         <<P>> sau <<T>>, dupa caz
 *  pas:  prin acest intreg se transmite pasul i cu 1<=i<=K
 */
void determina_modificarile_dupa_i_pasi(int caz, int pas)
{
    int i, j;
    int populatie_pasul_pas = 0; //initializare populatie la fiecare pas

    FOR(i, 1, N)
    {
        FOR(j, 1, M)
        {
            if(m[i][j])
                populatie_pasul_pas++;

            int nr_vecini;

            if(caz == 1)
                nr_vecini=calcul_vecini_P(i, j);
            else
                nr_vecini=calcul_vecini_T(i, j);

            if(nr_vecini < 2 || nr_vecini > 3)
            {
                len_s++;
                stergere[len_s].l = i;
                stergere[len_s].c = j;
            }
            else
                if(nr_vecini == 3)
                {
                    len_a++;
                    adaugare[len_a].l = i;
                    adaugare[len_a].c = j;
                }
        }
    }

    FOR(i, 1, len_s)
    {
        m[stergere[i].l][stergere[i].c] = 0;
    }
    FOR(i, 1, len_a)
    {
        int a = adaugare[i].l, b = adaugare[i].c;
        if(a > 0 && a <= M && b > 0 && b <= N)
        {
            m[a][b] = 1;
        }
    }

    initializare_perechi_cu_0();

    calcul_populatie(populatie_pasul_pas, pas - 1);
}
//----------------------------------------------------------------------
int main()
{
    citire_fisier();

    printf("matrice citita este:\n");
    afisare_grafica();

    //citire();

    if(P == 'P')
    {
        int i;
        FOR(i, 1, K)
        {
            determina_modificarile_dupa_i_pasi(1, i);

            printf("%d=\n", i);
            afisare_grafica();
        }
    }
    else
    {
        int i;
        FOR(i, 1, K)
        {
            determina_modificarile_dupa_i_pasi(2, i);

            printf("%d=\n", i);
            afisare_grafica();
        }
    }

    printf("Gradul maxim de populare este de %2.3f%c si se realizeaza la etapa %d \n\n",
          (populare * 100) / (M * N), '%', poz);

    //afisare_binara();
    //printf("%2.3f%c\n", (populare * 100) / (M * N), '%');

    return 0;
}
