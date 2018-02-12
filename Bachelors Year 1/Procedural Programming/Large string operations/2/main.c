#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
//----------------------------------------------------------------------
/*
 * Functia:  lungime
 * -----------------------
 *  Functia de mai sus calculeaza si returneaza lungimea fisierului de
    intrare in numar de caractere
 */
int lungime(FILE *fin)
{
    fseek(fin, 0, SEEK_SET);
    int len=0;
    while(fgetc(fin) != EOF)
    {
        len++;
    }
    return len;
}
//----------------------------------------------------------------------
/*
 * Functia:  sterge_mot
 * -----------------------
 *  Functia de mai sus reinitializeaza la fiecare iteratie cuvantul din
    uz cu cuvantul vid
 */
void sterge_mot(char mot[], int len)
{
    int i;
    for(i = 0; i < len; ++i)
        mot[i]='\0';
}
//----------------------------------------------------------------------
/*
 * Functia:  upper
 * -----------------------
 *  Functia de mai sus transforma literele mari in litere mici
 */
void upper(char c[], int len_c)
{
    int i;
    for(i = 0; i < len_c; ++i)
        if(c[i] >= 'A' && c[i] <= 'Z')
            c[i] += 32;
}
//----------------------------------------------------------------------
/*
 * Functia:  compare
 * -----------------------
 *  Functia de mai sus compara doua stringuri
 */
int compare(char a[], char b[], int len_a, int len_b)
{
    int i;
    if(len_a != len_b)
        return 0;

    for(i = 0; i < len_a; ++i)
        if(a[i] != b[i])
            return 0;
    return 1;
}
//----------------------------------------------------------------------
/*
 * Functia:  aparitii
 * -----------------------
 *  Functia de mai sus calculeaza numarul de aparitii al unui cuvant
    intr-un fisier
 */
int aparitii(FILE *fin, char c[], int len_c)
{
    int nr_ap = 0;
    int len = lungime(fin);
    //printf("Lungime = %d", len);
    int i, len_mot = 0;
    char mot[50], x;
    sterge_mot(mot, 50);
    fseek(fin, 0, SEEK_SET);
    for(i = 1; i <= len; i++)
    {
        fscanf(fin, "%c", &x);

        if(x == ' ' || x == '\n')
        {
            upper(mot, len_mot);
            if(compare(c, mot, len_c, len_mot))
                nr_ap++;
            //printf("%s   %d\n", mot, len_mot);
            len_mot = 0;
            sterge_mot(mot, len_mot);
        }
        else
        {
            mot[len_mot++] = x;
        }
    }
    return nr_ap;
}
//----------------------------------------------------------------------
/*
 * Functia:  valid_voc
 * -----------------------
 *  Functia de mai sus returneaza true in cazul care primeste ca parametru
    un string ce contine numai vocale si false in caz contrar
 */
int valid_voc(char c[], int len_c)
{
    int i;
    for(i = 0; i < len_c; i++)
        if(c[i]!= 'a' && c[i]!= 'e' && c[i]!= 'i' && c[i]!= 'o' && c[i]!= 'u' && c[i]!= 'A' && c[i]!= 'E' && c[i]!= 'I' && c[i]!= 'O' && c[i]!= 'U')
            return 0;
    return 1;
}
//----------------------------------------------------------------------
/*
 * Functia:  vocale
 * -----------------------
 *  Functia de mai sus scrie in fisierul de iesire toate cuvintele
    ce contin numai vocale din fisierul de intrare
 */
void vocale(FILE *fin, FILE *fout)
{
    int len = lungime(fin);
    //printf("Lungime = %d", len);
    int i, len_mot = 0;
    char mot[50], x;
    sterge_mot(mot, 50);
    fseek(fin, 0, SEEK_SET);
    for(i = 1; i <= len; i++)
    {
        fscanf(fin, "%c", &x);

        if(x == ' ' || x == '\n')
        {
            //printf("%s\n", mot);
            if(valid_voc(mot, len_mot))
            {
                int j;
                for(j = 0; j < len_mot; j++)
                    fprintf(fout, "%c", mot[j]);
                fprintf(fout, "\n");
            }
            len_mot = 0;

            sterge_mot(mot, len_mot);
        }
        else
        {
            mot[len_mot++] = x;
        }
    }
}
//----------------------------------------------------------------------
/*
 * Functia:  sterge_no
 * -----------------------
 *  Functia de mai sus reinitializeaza la fiecare iteratie numarul din
    uz cu numarul vid
 */
void sterge_no(char Z[], int len_Z, char Q[], int len_Q)
{
    int i;
    for(i = 0; i < len_Z; ++i)
        Z[i]='\0';
    for(i = 0; i < len_Q; ++i)
        Q[i]='\0';
}
//----------------------------------------------------------------------
/*
 * Functia:  numar
 * -----------------------
 *  Functia de mai sus intoare suma numerelor din fisierul primit ca
    parametru
 */
double numar(FILE *fin)
{
    printf("Numerele sunt:\n");
    int intreg = 0;
    double zecimal =0;
    double numar = 0;
    int len = lungime(fin);
    //printf("Lungime = %d", len);
    int i, len_Z = 0, len_Q = 0, ok = 1;
    char Z[50], Q[10], x;
    sterge_no(Z, 50, Q, 10);
    fseek(fin, 0, SEEK_SET);
    for(i = 1; i <= len; i++)
    {
        fscanf(fin, "%c", &x);

        if((x == ' ' || x == '\n') && len_Z)
        {
            //if(valid_no(no, &len_no))
            {
                int j;
                for(j = 0; j < len_Z; ++j)
                {
                    intreg = intreg * 10 + Z[j] - '0';
                }
                numar += intreg;
                for(j = 0; j < len_Q; ++j)
                {
                    zecimal = zecimal * 10 + Q[j] - '0';
                }
                zecimal /= (double)pow(10, len_Q);
                numar += zecimal;
            }
            printf("%.5f\n", intreg + zecimal);
            sterge_no(Z, len_Z, Q, len_Q);
            len_Z = 0;
            len_Q = 0;
            intreg = 0;
            zecimal = 0;
            ok = 1;
        }
        if((x == '.' || x == ',') && len_Z && ok)
        {
            fscanf(fin, "%c", &x);
            while(x >= '0' && x <= '9')
            {
                Q[len_Q++] = x;
                i++;
                fscanf(fin, "%c", &x);
            }
            fseek(fin, -1, SEEK_CUR);
            ok = 0;
        }
        if(x >= '0' && x <= '9' && ok)
        {
            Z[len_Z++] = x;
        }
    }
    return numar;
}
//----------------------------------------------------------------------
/*
 * Functia:  inlocuire
 * -----------------------
 *  Functia de mai sus inlocuieste aparitiile sursei cu ale destinatiei
    in fisierul primit ca parametru
 */
void inlocuire(FILE *fin, char sursa[], char destinatie[])
{
    int lg_s = strlen(sursa), lg_d = strlen(destinatie);
    upper(sursa, lg_s);
    upper(destinatie, lg_d);

    int len = lungime(fin);
    //printf("%d", len);
    int i, len_mot = 0;
    char mot[50], x;
    sterge_mot(mot, 50);
    fseek(fin, 0, SEEK_SET);
    for(i = 1; i <= len; i++)
    {
        fscanf(fin, "%c", &x);

        if(x == ' ' || x == '\n')
        {
            upper(mot, len_mot);

            if(compare(sursa, mot, lg_s, len_mot))
            {
                fseek(fin, i - lg_d -1 , SEEK_SET);
                fprintf(fin, "%s", destinatie);
            }
            len_mot = 0;
            sterge_mot(mot, len_mot);
        }
        else
        {
            mot[len_mot++] = x;
        }
    }
}

int ok(char c[])
{
    if(strlen(c) > 1)
        return 0;
    else
        if(c[0] >= '1' && c[0] <= '4')
            return 1;
        else
            return 0;
}

int main()
{
    FILE *f, *g;
    f = fopen("date.in", "r+");
    g = fopen("date.out", "w");

    int menu;
    char c[50];
    printf("Pentru:\n - Determinarea numarului de aparitii pentru un cuvant tastati 1;\n");
    printf(" - Determinarea cuvintelor ce nu contin consoane 2;\n");
    printf(" - Determinarea sumei numerelor din fisier tastati 3;\n");
    printf(" - Interschimbarea unor cuvinte de lungimi egale tastati 4.\n");
    scanf("%s", c);
    while(!ok(c))
    {
        printf("Valoare invalida...Tastati un numar intre 1 si 4\n");
        scanf("%s", c);
    }
    menu = c[0] - '0';

    switch(menu)
    {
    case 1:
        {
            char c[50];
            printf("Dati cuvantul de cautat...\n");
            scanf("%s", c);
            upper(c, strlen(c));
            printf("\nNumarul de aparitii al cuvantului %s in fisier este = %d\n", c, aparitii(f, c, strlen(c)));
            break;
        }
    case 2:
        {
            printf("Cuvintele ce nu contin consoane se afla in fisierul de iesire.\n");
            vocale(f, g);
            break;
        }
    case 3:
        {
            printf("\n");
            printf("\nSuma numerelor din fisierul dat este %.5f\n", numar(f));
            break;
        }
    case 4:
        {
            char c[50], d[50];
            printf("Dati cuvantul de inlocuit...\n");
            scanf("%s", c);
            upper(c, strlen(c));
            printf("Numarul de aparitii al cuvantului %s in fisier este = %d\n", c, aparitii(f, c, strlen(c)));
            printf("Dati cuvantul cu care doriti sa il inlocuiti pe %s\n", c);
            scanf("%s", d);
            while(strlen(c) != strlen(d))
            {
                printf("Cuvintele nu au acceiasi lungime... Dati un cuvant de lungime %d\n", strlen(c));
                scanf("%s", d);
            }
            inlocuire(f, c, d);
            printf("Textul a fost inlocuit cu succes.");
            break;
        }
    }

    return 0;
}
