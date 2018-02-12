#include <iostream>
#include <stdio.h>
#define DIMMAX 100005

using namespace std;

long long N, A[DIMMAX], B[DIMMAX];
long long tu;
void merge_sort(long long l, long long r)
{
    long long m = (l + r) >> 1, i, j, k;
    if (l == r) return;
    merge_sort(l, m);
    merge_sort(m + 1, r);
    for (i=l, j=m+1, k=l; i<=m || j<=r; )
        if (j > r || (i <= m && A[i] < A[j]))
            B[k++] = A[i++];
        else
            B[k++] = A[j++];
    for (k = l; k <= r; k++) A[k] = B[k];
}

int main()
{

    scanf("%d",&N);

    int i;
    for(i=1;i<=N;i++)
        scanf("%d",&A[i]);

    merge_sort(1,N);

    for(i=1;i<=N/2;i++)
        tu=(tu+(A[i]*A[N-i+1])*2)%10007;

    if(N%2)tu+=A[N/2+1]*A[N/2+1];

    if(tu==0)tu=A[1];

    printf("%d",tu%10007);

    return 0;
}
