#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define CURS_REFERINTA 5.25 /* Cursul de referinta 1Lira=CURS_REFERINTA lei */
#define DIMMAX 10 /* Numarul maxim de masini din baza de date */
#define NR_MASINI_AM 6 /* Numarul curent de masini din baza de bate */
#define FOR(i, a, b) for(i = a; i <= b; i++) /* Constanta simbolica */

struct performanta
{
    int putere_maxima;
    int tortiune_maxima;
    double timp;
    int viteza_maxima;
    int viteza_maxima_m_s;
};

enum transmisie
{
    Manuala,
    Automata
};

enum combustibil
{
    Benzina,
    Motorina,
    Combustibil_bio,
    Acetilena
};

struct cutie_viteza
{
    int tip_transmisie;
    int nr_viteze;
};

struct productie
{
    int incepere;
    int oprire;
};

struct pret
{
    long minim;
    long maxim;
    long mediu;
};

struct masina
{
    char nume[30];
    struct productie an;
    char tip_caroserie[20];
    int nr_usi;
    int nr_scaune;
    struct cutie_viteza cv;
    int nr_cilindri;
    struct performanta perf;
    int tip_combustibil;
    struct pret p;
    char web[50];
};
//----------------------------------------------------------------------
/*
 * Functia:  citire_BD
 * -----------------------
 *  Functia de mai sus citeste din fisierele date, datele de intrare,
    adica pentru fiecare masina numele, anul inceperii productiei, etc.
 *  n   : numarul de masini
 *  AM[]: vector de inregistrari de masini Aston Martin
 */
 //-----------------------
void citire_BD(int, struct masina AM[]);
//----------------------------------------------------------------------
/*
 * Functia:  afisare
 * -----------------------
 *  Functia de mai sus cafiseaza pe ecran sau scrie in fisier,
    in functie de preferintele utilizatorului specificatiile
    masinii date de indice
 *  n     : numarul de masini
 *  AM[]  : vector de inregistrari de masini Aston Martin
 *  indice: masina selectata
 */
 //-----------------------
void afisare(int, struct masina AM[], int, FILE *);
//----------------------------------------------------------------------
/*
 * Functia: calcul_pret_mediu
 * -----------------------
 *  Functia de mai sus calculeaza pretul mediu al masinii indice
    in functie de pretul maxim si cel minim
 *  n     : numarul de masini
 *  AM[]  : vector de inregistrari de masini Aston Martin
 *  indice: masina selectata
 *  g     : fisierul de scriere
 */
 //-----------------------
void calcul_pret_mediu(int, struct masina AM[]); //cerinta c).
//----------------------------------------------------------------------
/*
 * Functia:  convert_lira_lei
 * -----------------------
 *  Functia de mai sus transforma pretul initaial dat in lire sterline
    in lei, inmultind cu variabila curs_de_referinta
 *  n     : numarul de masini
 *  AM[]  : vector de inregistrari de masini Aston Martin
 */
 //-----------------------
void convert_lira_lei(int, struct masina AM[]);
//----------------------------------------------------------------------
/*
 * Functia:  afisare
 * -----------------------
 *  Functia de mai sus calculeaza viteza maxima in m/s in functie
    de datele de intrarea citite in Km/h
 *  n     : numarul de masini
 *  AM[]  : vector de inregistrari de masini Aston Martin
 */
 //-----------------------
void calcul_viteza_maxima_in_m_s(int, struct masina AM[]);
//----------------------------------------------------------------------
/*
 * Functia:  mofificare_pret_min
 * -----------------------
 *  Functia de mai sus mofifica pretul minim din inregistrarile
    date cu cele citite
 *  AM[]  : vector de inregistrari de masini Aston Martin
 */
 //-----------------------
void modificare_pret_min(struct masina AM[]);
//----------------------------------------------------------------------
/*
 * Functia:  mofificare_pret_max
 * -----------------------
 *  Functia de mai sus mofifica pretul maxim din inregistrarile
    date cu cele citite
 *  AM[]  : vector de inregistrari de masini Aston Martin
 */
 //-----------------------
void modificare_pret_maxim(struct masina AM[]);

int compare(const void * a, const void * b)
{
    int size_len=strlen( ((struct masina *)a)->nume ) ;
    int i;
    for( i=0; i<size_len; i++)
    {
        if(((struct masina *)a)->nume[i] != ((struct masina *)b)->nume[i])
        {
            return ((struct masina *)a)->nume[i]- ((struct masina *)b)->nume[i];
        }
    }
    return 1;
}

int main()
{
    FILE *g;
    g = fopen("output.out","w");

    struct masina AM[DIMMAX];

    void (*p[5])(void);
    p[0] = calcul_pret_mediu;
    p[1] = convert_lira_lei;
    p[2] = calcul_viteza_maxima_in_m_s;
    p[3] = modificare_pret_min;
    p[4] = modificare_pret_maxim;

    citire_BD(NR_MASINI_AM, AM);

    qsort(AM+1, NR_MASINI_AM, sizeof(struct masina), compare);

    int ok = 1, i;


    while(ok)
    {
        int aux;
        char c;
        printf("In cazul in care doriti sa lucrati cu viteza in km/h tastati 1).\n");
        printf("In cazul in care doriti sa lucrati cu viteza in m/s tastati 2).\n");
        scanf("%c", &c);
        while(c != '1' && c != '2')
        {
            printf("Numar invalid retastati...\n");
            printf("In cazul in care doriti sa lucrati cu viteza in km/h tastati 1).\n");
            printf("In cazul in care doriti sa lucrati cu viteza in m/s tastati 2).\n");
            scanf("%d", &aux);
        }
        if(aux == 2)
            calcul_viteza_maxima_in_m_s(NR_MASINI_AM, AM);
        printf("\n");
        printf("In cazul in care doriti sa lucrati in lire sterline tastati 1).\n");
        printf("In cazul in care doriti sa lucrati in lei tastati 2).\n");
        scanf("%d", &aux);
        while(aux != 1 && aux != 2)
        {
            printf("Numar invalid retastati...\n");
            printf("In cazul in care doriti sa lucrati in lire sterline tastati 1).\n");
            printf("In cazul in care doriti sa lucrati in lei tastati 2).\n");
            scanf("%d", &aux);
        }
        if(aux == 2)
            convert_lira_lei(NR_MASINI_AM, AM);

        printf("Tastati 1). in cazul in care doriti sa modificati pretul minim al unei masini.\n");
        printf("Tastati 2). in cazul in care doriti sa modificati pretul maxim al unei masini.\n");
        printf("Tastati 3). in cazul in care doriti sa afisati la consola masiniile cu un pret mediu dat.\n");
        scanf("%d", &aux);
        while(aux != 1 && aux != 2 && aux != 3)
        {
            printf("Numar invalid retastati...\n");
            printf("Tastati 1). in cazul in care doriti sa modificati pretul minim al unei masini.\n");
            printf("Tastati 2). in cazul in care doriti sa modificati pretul maxim al unei masini.\n");
            printf("Tastati 3). in cazul in care doriti sa afisati la consola masiniile cu un pret mediu dat.\n");
            scanf("%d", &aux);
        }
        if(aux == 1)
            modificare_pret_min(AM);
        if(aux == 2)
                modificare_pret_maxim(AM);
        if(aux == 3)
        {
            printf("Dati valorile de minim si de maxim pentru preturile medii de cautat.\n");
            int minim, maxim;
            printf("Minim = ");
            scanf("%d", &aux);
            minim = aux;
            printf("Maxim = ");
            scanf("%d", &aux);
            maxim = aux;
            calcul_pret_mediu(NR_MASINI_AM, AM);
            int sem = 0;
            for(i = 1; i <= NR_MASINI_AM; i++)
            {
                if(AM[i].p.mediu <= maxim && AM[i].p.mediu >= minim)
                {
                    afisare(NR_MASINI_AM, AM, i, g);
                    sem = 1;
                }
            }
            if(sem == 0)
                printf("Nu exista masini cu pretul mediu intre %d si %d.", minim, maxim);
        }
        printf("\n");
        printf("In cazul in care doriti sa continuati sa mai faceti alte operatii pe BD tastati 1). \n");
        printf("In cazul in care  NU doriti sa mai faceti alte operatii pe BD tastati 0). \n");
        scanf("%d", &aux);
        while(aux != 0 && aux != 1)
        {
            printf("Numar invalid retastati...\n");
            printf("In cazul in care doriti sa continuati sa mai faceti alte operatii pe BD tastati 1). \n");
            printf("In cazul in care  NU doriti sa mai faceti alte operatii pe BD tastati 0). \n");
            scanf("%d", &aux);
        }
        ok = aux;
    }
    fclose (g);
    return 0;
}

void citire_BD(int n, struct masina AM[])
{
    FILE *f[7];
    f[1] = fopen("DB9-Volante.txt","r");
    f[2] = fopen("DBS-Coupe.txt","r");
    f[3] = fopen("One-77.txt","r");
    f[4] = fopen("Rapide-S.txt","r");
    f[5] = fopen("V12-Zagato.txt","r");
    f[6] = fopen("Vanquish.txt","r");

    int i, j, k;
    char str[100];
    FOR(i, 1, n)
    {
        //-------------------------------------------------------------
        //  citire camp nume pentru AM[i]
        fgets (AM[i].nume , 100, f[i]);

        //-------------------------------------------------------------
        //  citire camp an.incepere pentru AM[i]
        fgets (str, 100, f[i]);
        j=0;
        while(j < strlen(str) && str[j] != ':')
            ++j;
        j += 2;
        int nr = 0;
        FOR(k, j, strlen(str) - 2)
            nr += (int)pow(10, (strlen(str) - k - 2)) * (int)(str[k] - 48);
        AM[i].an.incepere = nr;

        //-------------------------------------------------------------
        //  citire camp an.oprire pentru AM[i]
        fgets (str, 100, f[i]);
        j=0;
        while(j < strlen(str) && str[j] != ':')
            ++j;
        j += 2;
        nr = 0;
        FOR(k, j, strlen(str) - 2)
            nr += (int)pow(10, (strlen(str) - k - 2)) * (int)(str[k] - 48);
        AM[i].an.oprire = nr;

        //-------------------------------------------------------------
        //  citire camp tip_caroserie pentru AM[i]
        fgets (str, 100, f[i]);
        j=0;
        while(j < strlen(str) && str[j] != ':')
            ++j;
        j += 2;
        strcpy(AM[i].tip_caroserie, str+j);

        //-------------------------------------------------------------
        //  citire camp nr_usi pentru AM[i]
        fgets (str, 100, f[i]);
        j=0;
        while(j < strlen(str) && str[j] != ':')
            ++j;
        j += 2;
        nr = 0;
        FOR(k, j, strlen(str) - 2)
            nr += (int)pow(10, (strlen(str) - k - 2)) * (int)(str[k] - 48);
        AM[i].nr_usi = nr;

        //-------------------------------------------------------------
        //  citire camp nr_scaune pentru AM[i]
        fgets (str, 100, f[i]);
        j=0;
        while(j < strlen(str) && str[j] != ':')
            ++j;
        j += 2;
        nr = 0;
        FOR(k, j, strlen(str) - 2)
            nr += (int)pow(10, (strlen(str) - k - 2)) * (int)(str[k] - 48);
        AM[i].nr_scaune = nr;

        //-------------------------------------------------------------
        //  citire camp cv.transmisie pentru AM[i]
        fgets (str, 100, f[i]);
        j=0;
        while(j < strlen(str) && str[j] != ':')
            ++j;
        j += 2;
        if(str[j] == 'A')
            AM[i].cv.tip_transmisie = Automata;
        else
            AM[i].cv.tip_transmisie = Manuala;

        //-------------------------------------------------------------
        //  citire camp cv.nr_viteze pentru AM[i]
        fgets (str, 100, f[i]);
        j=0;
        while(j < strlen(str) && str[j] != ':')
            ++j;
        j += 2;
        nr = 0;
        FOR(k, j, strlen(str) - 2)
            nr += (int)pow(10, (strlen(str) - k - 2)) * (int)(str[k] - 48);
        AM[i].cv.nr_viteze = nr;

        //-------------------------------------------------------------
        //  citire camp nr_cilindri pentru AM[i]
        fgets (str, 100, f[i]);
        j=0;
        while(j < strlen(str) && str[j] != ':')
            ++j;
        j += 2;
        nr = 0;
        FOR(k, j, strlen(str) - 2)
            nr += (int)pow(10, (strlen(str) - k - 2)) * (int)(str[k] - 48);
        AM[i].nr_cilindri = nr;

        //-------------------------------------------------------------
        //  citire camp perf.putere_maxima pentru AM[i]
        fgets (str, 100, f[i]);
        j=0;
        while(j < strlen(str) && str[j] != ':')
            ++j;
        j += 2;
        nr = 0;
        FOR(k, j, strlen(str) - 2)
        {
            int ok = 1;
            int aux = (int)(str[k] - 48);
            if(aux < 10 && aux >= 0 && ok)
                nr += (int)pow(10, (strlen(str) - k - 5)) * aux;
            else ok = 0;
        }
        AM[i].perf.putere_maxima = nr;

        //-------------------------------------------------------------
        //  citire camp perf.tortiune_maxima pentru AM[i]
        fgets (str, 100, f[i]);
        j=0;
        while(j < strlen(str) && str[j] != ':')
            ++j;
        j += 2;
        nr = 0;
        FOR(k, j, strlen(str) - 2)
        {
            int ok = 1;
            int aux = (int)(str[k] - 48);
            if(aux < 10 && aux >= 0 && ok)
                nr += (int)pow(10, (strlen(str) - k - 5)) * aux;
            else ok = 0;
        }
        AM[i].perf.tortiune_maxima = nr;

        //-------------------------------------------------------------
        //  citire camp perf.timp pentru AM[i]
        fgets (str, 100, f[i]);
        j=0;
        while(j < strlen(str) && str[j] != ':')
            ++j;
        j += 2;
        int l1 = j;
        while(l1 < strlen(str) && str[l1] != '.')
            ++l1;
        int l2 = l1;
        while(l2 < strlen(str) && str[l2] != ' ')
            ++l2;
        l2--;
        nr = 0;
        FOR(k, j, l1-1)
            nr += ceil(pow(10, (l2 - j) - (k - j + 1)) * (int)(str[k] - 48));
        FOR(k, l1+1, l2)
            nr += ceil(pow(10, (l2 - l1) - (k - l1)) * (int)(str[k] - 48));
        AM[i].perf.timp = (double)nr / pow(10, l2 - l1);

        //-------------------------------------------------------------
        //  citire camp perf.viteza_maxima pentru AM[i]
        fgets (str, 100, f[i]);
        j=0;
        while(j < strlen(str) && str[j] != ':')
            ++j;
        j += 2;
        nr = 0;
        FOR(k, j, strlen(str) - 4)
        {
            int ok = 1;
            int aux = (int)(str[k] - 48);;
            if(aux < 10 && aux >= 0 && ok)
                nr += ceil(pow(10, (strlen(str) - k - 7)) * aux);
            else ok = 0;
        }
        AM[i].perf.viteza_maxima = nr;

        //-------------------------------------------------------------
        //  citire camp perf.tip_combustibil pentru AM[i]
        fgets (str, 100, f[i]);
        j=0;
        while(j < strlen(str) && str[j] != ':')
            ++j;
        j += 2;
        if(str[j] == 'B')
            AM[i].tip_combustibil = Benzina;
        else
            if(str[j] == 'M')
                AM[i].tip_combustibil = Motorina;
            else
                if(str[j] == 'C')
                    AM[i].tip_combustibil = Combustibil_bio;
                else
                    AM[i].tip_combustibil = Acetilena;

        //-------------------------------------------------------------
        //  citire camp perf.p pentru AM[i]
        fgets (str, 100, f[i]);
        j=0;
        while(j < strlen(str) && str[j] != ':')
            ++j;
        j += 2;
        l1 = j;
        while(l1 < strlen(str) && str[l1] != '-')
            ++l1;
        nr = 0;
        FOR(k, j, l1-2)
            nr += ceil(pow(10, (l1 - 2 - k)) * (int)(str[k] - 48));
        AM[i].p.minim = nr;
        nr = 0;
        FOR(k, l1+2, strlen(str) - 2)
        {
            int x = (int)(str[k] - 48);
            if(x < 10 && x >= 0)
                nr += ceil(pow(10, (strlen(str) - 4 - k)) * x);
        }
        AM[i].p.maxim = nr;

        //-------------------------------------------------------------
        //  citire camp perf.web pentru AM[i]
        fgets (str, 100, f[i]);
        j=0;
        while(j < strlen(str) && str[j] != ':')
            ++j;
        j += 2;
        strcpy(AM[i].web, str+j);

        fclose (f[i]);
    }
}

void afisare(int n, struct masina AM[], int indice, FILE *g)
{
    if(indice < 0 || indice > n)
        printf("Masina %d nu exista in baza de date\n", indice);
    else
    {
        int ok;
        printf("Pentru afisare in fisier tastati 1 iar pentru ecran tastati 2 -> ");
        scanf("%d", &ok);
        while(ok != 1 && ok != 2)
        {
            printf("Instructiune invalida.\n");
            printf("Pentru afisare in fisier tastati 1 iar pentru ecran tastati 2 ->");
            scanf("%d", &ok);
        }
        if(ok == 1)
            afisare_fisier(AM, indice, g);
        else
            afisare_consola(AM, indice);
    }
}

void afisare_fisier(struct masina AM[], int indice, FILE *g)
{
    fprintf(g, "%s", AM[indice].nume);
    fprintf(g, "Anul inceperii productiei: %d\n", AM[indice].an.incepere);
    fprintf(g, "Anul opririi productiei: %d\n", AM[indice].an.oprire);
    fprintf(g, "Tipul caroseriei: %s", AM[indice].tip_caroserie);
    fprintf(g, "Numãr de usi: %d\n", AM[indice].nr_usi);
    fprintf(g, "Numãr de scaune: %d\n", AM[indice].nr_scaune);
    if(AM[indice].cv.tip_transmisie == 0)
        fprintf(g, "Transmisie: Manuala\n");
    else
        fprintf(g, "Transmisie: Automata\n");
    fprintf(g, "Numarul de viteze: %d\n", AM[indice].cv.nr_viteze);
    fprintf(g, "Numarul de cilindri: %d\n", AM[indice].nr_cilindri);
    fprintf(g, "Putere maxima: %d CP\n", AM[indice].perf.putere_maxima);
    fprintf(g, "Tortiunea maxima: %d Nm\n", AM[indice].perf.tortiune_maxima);
    fprintf(g, "Acceleratia de la 0 la 100 km/h: %.1f secunde\n", AM[indice].perf.timp);
    fprintf(g, "Viteza maxima: %d km/h\n", AM[indice].perf.viteza_maxima);
    if(AM[indice].tip_combustibil == 0)
        fprintf(g, "Tipul de combustibil: Benzina\n");
    else
        if(AM[indice].tip_combustibil == 1)
            fprintf(g, "Tipul de combustibil: Motorina\n");
        else
            if(AM[indice].tip_combustibil == 2)
                fprintf(g, "Tipul de combustibil: Combustibil bio\n");
            else
                fprintf(g, "Tipul de combustibil: Acetilena\n");
    fprintf(g, "Pret: %ld - %ld L\n", AM[indice].p.minim, AM[indice].p.maxim);
    fprintf(g, "Web: %s", AM[indice].web);
    fprintf(g, "\n");
}

void afisare_consola(struct masina AM[], int indice)
{
    printf("\n");
    printf("%s\n", AM[indice].nume);
    printf("Anul inceperii productiei      : %d\n", AM[indice].an.incepere);
    printf("Anul opririi productiei        : %d\n", AM[indice].an.oprire);
    printf("Tipul caroseriei               : %s", AM[indice].tip_caroserie);
    printf("Numãr de usi                   : %d\n", AM[indice].nr_usi);
    printf("Numãr de scaune                : %d\n", AM[indice].nr_scaune);
    if(AM[indice].cv.tip_transmisie == 0)
        printf("Transmisie                     : Manuala\n");
    else
        printf("Transmisie                     : Automata\n");
    printf("Numarul de viteze              : %d\n", AM[indice].cv.nr_viteze);
    printf("Numarul de cilindri            : %d\n", AM[indice].nr_cilindri);
    printf("Putere maxima                  : %d CP\n", AM[indice].perf.putere_maxima);
    printf("Tortiunea maxima               : %d Nm\n", AM[indice].perf.tortiune_maxima);
    printf("Acceleratia de la 0 la 100 km/h: %.1f secunde\n", AM[indice].perf.timp);
    printf("Viteza maxima                  : %d km/h\n", AM[indice].perf.viteza_maxima);
    if(AM[indice].tip_combustibil == 0)
        printf("Tipul de combustibil           : Benzina\n");
    else
        if(AM[indice].tip_combustibil == 1)
            printf("Tipul de combustibil           : Motorina\n");
        else
            if(AM[indice].tip_combustibil == 2)
                printf("Tipul de combustibil           : Combustibil bio\n");
            else
                printf("Tipul de combustibil           : Acetilena\n");
    printf("Pret                           : %ld - %ld L\n", AM[indice].p.minim, AM[indice].p.maxim);
    printf("Web                            : %s\n", AM[indice].web);
}

void calcul_pret_mediu(int n, struct masina AM[])
{
    int i;
    FOR(i, 1, n)
        AM[i].p.mediu = (AM[i].p.minim + AM[i].p.maxim) / 2;
}

void convert_lira_lei(int n, struct masina AM[])
{
    int i;
    FOR(i, 1, n)
    {
        AM[i].p.minim = AM[i].p.minim * CURS_REFERINTA;
        AM[i].p.maxim = AM[i].p.maxim * CURS_REFERINTA;

    }
}

void calcul_viteza_maxima_in_m_s(int n, struct masina AM[])
{
    int i;
    FOR(i, 1, n)
    {
        AM[i].perf.viteza_maxima_m_s = AM[i].perf.viteza_maxima * 10 / 36;
    }
}

void modificare_pret_min(struct masina AM[])
{
    int i, val, ok=0;
    FOR(i, 1, NR_MASINI_AM)
        printf("Tastati %d). pentru masina %s", i, AM[i].nume);
    scanf("%d", &val);
    FOR(i, 1, NR_MASINI_AM)
        ok = ok || (val == i);
    while(ok != 1)
    {
        printf("Numar invalid.");
        printf("Retastati indicele masinii al carui pret doriti sa il  modificati ->");
        scanf("%d", &val);
        FOR(i, 1, NR_MASINI_AM)
            ok = ok || (val == i);
    }
    printf("Masina selectata este: %s", AM[val].nume);
    printf("Pretul minim actual este: %d \n", AM[val].p.minim);
    printf("Pretul maxim actual este: %d \n", AM[val].p.maxim);
    printf("Intruduceti noul pret minim: ");
    scanf("%ld", &AM[val].p.minim);
}

void modificare_pret_maxim(struct masina AM[])
{
    int i, val, ok=0;
    FOR(i, 1, NR_MASINI_AM)
        printf("Tastati %d). pentru masina %s", i, AM[i].nume);
    scanf("%d", &val);
    FOR(i, 1, NR_MASINI_AM)
        ok = ok || (val == i);
    while(ok != 1)
    {
        printf("Numar invalid.");
        printf("Retastati indicele masinii al carui pret doriti sa il  modificati ->");
        scanf("%d", &val);
        FOR(i, 1, NR_MASINI_AM)
            ok = ok || (val == i);
    }
    printf("Masina selectata este: %s", AM[val].nume);
    printf("Pretul minim actual este: %d \n", AM[val].p.minim);
    printf("Pretul maxim actual este: %d \n", AM[val].p.maxim);
    printf("Intruduceti noul pret maxim: ");
    scanf("%ld", &AM[val].p.maxim);
}
