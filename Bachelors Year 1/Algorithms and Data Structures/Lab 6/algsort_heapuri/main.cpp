#include <bits/stdc++.h>
#define DIMMAX 500000

using namespace std;

ofstream g("algsort.out");

typedef int Heap[DIMMAX];

inline int father(int nod) {
    return nod / 2;
}

inline int left_son(int nod) {
    return nod * 2;
}

inline int right_son(int nod) {
    return nod * 2 + 1;
}

void sift(Heap, int, int);
void build_heap(Heap, int);

void heapsort(Heap H, int N)
{
    build_heap(H, N);
    g<<H[1]<<" ";
    for (int i = N; i >= 2; --i)
    {
        swap(H[1], H[i]);
        sift(H, i - 1, 1);
        g<<H[1]<<" ";
    }
}

void build_heap(Heap H, int N) {
    for (int i = N / 2; i > 0; --i) {
        sift(H, N, i);
    }
}

void sift(Heap H, int N, int K) {
    int son;
    do {
        son = 0;
        // Alege un fiu mai mare ca tatal.
        if (left_son(K) <= N) {
            son = left_son(K);
            if (right_son(K) <= N && H[right_son(K)] < H[left_son(K)]) {
                son = right_son(K);
            }
            if (H[son] >= H[K]) {
                son = 0;
            }
        }

        if (son) {
            swap(H[K], H[son]);  // Functie STL ce interschimba H[K] cu H[son].
            K = son;
        }
    } while (son);
}

int main()
{
    ifstream f("algsort.in");

    int N;
    Heap H;

    f>>N;
    for(int i=1;i<=N;i++)
        f>>H[i];

    heapsort(H, N);

    f.close();
    g.close();
    return 0;
}
