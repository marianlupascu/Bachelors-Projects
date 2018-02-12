#include <bits/stdc++.h>
#define FOR(i, a ,b) for(int i = a; i <= b; i++)

using namespace std;

int main()
{
    int N;
    unordered_map <string, long> h;
    //ifstream in ("winner.in");
    string c, win;
    int val;
    long maxim = INT_MIN;
    //in >> N;
    //in.get();
    cin >> N;
    FOR(i, 1, N)
    {
        cin >> c;
        cin >> val;
        //in >> c;
        //in >> val;
        if(h[c])
            h[c] += val;
        else
            h[c] = val;
        if(maxim < h[c])
        {
            maxim = h[c];
            win = c;
        }
    }

    cout << win;

    //in.close();
    return 0;
}
