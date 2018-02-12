#include <iostream>
#include <fstream>
#define DIMMAX 100005
#define ll long long
#define FOR(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

int n, k, A[DIMMAX];
ll dif=-30000;
int deque_min[DIMMAX], stanga_min=1, dreapta_min=0;
int deque_max[DIMMAX], stanga_max=1, dreapta_max=0;

void citire()
{
    ifstream f("vila2.in");
    f >> n >> k;
    FOR(i, 1, n)
    {
        f >> A[i];
    }
    f.close();
}

void afisare()
{
    ofstream g("vila2.out");
    g<<dif;
    g.close();
}

//void det_min_max(int poz)
//{
//    int m=30001,M=-30001;
//    FOR(i,poz,poz+k-1)
//    {
//        if(A[i]>M)
//        {
//            M=A[i];
//        }
//        if(A[i]<m)
//        {
//            m=A[i];
//        }
//    }
//    if(M-m>dif)dif=M-m;
//}
//
//void diferenta_max()
//{
//    FOR(i, 1, n-k+1)
//    {
//        det_min_max(i);
//    }
//}

void build_deque()
{
    FOR(i, 1, n)
    {
        while (stanga_min <= dreapta_min && A[deque_min[dreapta_min]] >= A[i]) --dreapta_min;
        deque_min[++dreapta_min] = i;
        while (stanga_min <= dreapta_min && i - deque_min[stanga_min] >= k) ++stanga_min;


        while (stanga_max <= dreapta_max && A[deque_max[dreapta_max]] <= A[i]) --dreapta_max;
        deque_max[++dreapta_max] = i;
        while (stanga_max <= dreapta_max && i - deque_max[stanga_max] >= k) ++stanga_max;
//cout<<A[deque_max[stanga_max]]<<"  "<<A[deque_min[stanga_min]]<<'\n';

        if (i>=k && A[deque_max[stanga_max]]-A[deque_min[stanga_min]] >= dif) dif=A[deque_max[stanga_max]]-A[deque_min[stanga_min]];
    }
}

int main()
{
    citire();
    //diferenta_max();

    build_deque();

    afisare();
    return 0;
}
