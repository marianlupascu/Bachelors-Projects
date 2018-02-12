#include <bits/stdc++.h>
#define FOR(i,a,b) for(int i = a; i <= b; i++)

using namespace std;

bool desc (int i, int j) { return (i>j); }

int main()
{
    int n,m;
    vector <int> locuri;
    int x;
    cin>>n>>m;
    FOR(i,1,m)
    {
        cin>>x;
        locuri.push_back(x);
    }
    sort(locuri.begin(), locuri.begin()+m, desc);

    int maxim[m];
    FOR(i,0,m-1)
        maxim[i]=locuri[i];
    int copie=n;
    long long sumamax=0;
    int j;
    while(copie)
    {
        j=1;
        while(maxim[0]==maxim[j] && j<m)
            j++;
        j--;
        int aux=j;
        for(int k=0;k<=aux && copie;k++)
        {
            sumamax+=maxim[k];
            maxim[k]--;
            copie--;
        }
    }

    cout<<sumamax<<" ";


    int minim[m];
    FOR(i,0,m-1)
        minim[i]=locuri[m-1-i];
    int copie2=n;
    long long sumamin=0;
    int i1=0;
    while(copie2 && i1<m)
    {
        while(minim[i1]<=0)i1++;
        if(copie2-minim[i1]>=0)
        {
            sumamin+=minim[i1]*(minim[i1]+1)/2;
            copie2-=minim[i1];
            minim[i1]=0;
        }
        else
        {
            while(copie2 && minim[i1]>0)
            {
                sumamin+=minim[i1];
                copie2--;
                minim[i1]--;
            }
        }
    }

    cout<<sumamin;

    return 0;
}
