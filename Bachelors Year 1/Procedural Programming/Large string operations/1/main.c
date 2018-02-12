#include <stdio.h>
#include <stdlib.h>

int lungime(FILE *fin)
{
    int len=0;
    while(fgetc(fin) != EOF)
    {
        len++;
    }
    return len;
}

void sterge_mot(char mot[], int len)
{
    int i;
    for(i = 0; i < len; ++i)
        mot[i]='\0';
}

int valid(char mot[], int *len)
{
    int i;
    for(i = *len - 1; i > 0; --i)
    {
        if(mot[i] < 'a' || mot[i] > 'z')
        (*len)--;
    }

    for(i = 0; i < *len; ++i)
        if(mot[i] < 'a' || mot[i] > 'z')
            return 0;
    return 1;
}

void cuvant(FILE *fin, FILE *fout)
{
    int len = lungime(fin);
    printf("Lungime = %d", len);
    int i, len_mot = 0;
    char mot[50], x;
    sterge_mot(mot, 50);
    fseek(fin, 0, SEEK_SET);
    for(i = 1; i <= len; i++)
    {
        fscanf(fin, "%c", &x);

        if(x == '\n')
        {
            if(valid(mot, &len_mot))
            {
                int j;
                for(j = 0; j < len_mot; j++)
                    fprintf(fout, "%c", mot[j]);
            }
            fprintf(fout, "%c", x);
        }

        if(x == ' ')
        {
            if(valid(mot, &len_mot))
            {
                int j;
                for(j = 0; j < len_mot; j++)
                    fprintf(fout, "%c", mot[j]);
                fprintf(fout, " ");
            }
            len_mot = 0;
        }
        else
        {
            mot[len_mot++] = x;
        }
    }
}

void sterge_no(char no[], int len)
{
    int i;
    for(i = 0; i < len; ++i)
        no[i]='\0';
}

int valid_no(char no[], int *len)
{
    int i;
    for(i = *len - 1; i > 0; --i)
    {
        if(no[i] < '0' || no[i] > '9')
        (*len)--;
    }

    for(i = 0; i < *len; ++i)
        if(no[i] < '0' || no[i] > '9')
            return 0;
    return 1;
}

void numar(FILE *fin, FILE *fout)
{
    int len = lungime(fin);
    printf("Lungime = %d", len);
    int i, len_no = 0;
    char no[50], x;
    sterge_no(no, 50);
    fseek(fin, 0, SEEK_SET);
    for(i = 1; i <= len; i++)
    {
        fscanf(fin, "%c", &x);

        if(x == '\n')
        {
            if(valid_no(no, &len_no))
            {
                int j;
                for(j = 0; j < len_no; j++)
                    fprintf(fout, "%c", no[j]);
            }
            fprintf(fout, "%c", x);
        }

        if(x == ' ')
        {
            if(valid_no(no, &len_no))
            {
                int j;
                for(j = 0; j < len_no; j++)
                    fprintf(fout, "%c", no[j]);
                fprintf(fout, " ");
            }
            len_no = 0;
        }
        else
        {
            no[len_no++] = x;
        }
    }
}

int main()
{
    FILE *f, *g;
    f = fopen("date.in", "r");
    g = fopen("date.out", "w");

    cuvant(f, g);

    //numar(f, g);

    return 0;
}
