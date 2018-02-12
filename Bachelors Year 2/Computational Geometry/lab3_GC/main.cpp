#include <iostream>
#include <fstream>
#include <utility>
#include <algorithm>

using namespace std;

bool cmpx (pair<int, int> i,pair<int, int> j) { return (i.first < j.first); }
bool cmpy (pair<int, int> i,pair<int, int> j) { return (i.second < j.second); }

pair<int, int> A[5];
int a[5], b[5], c[5];

void citire() {

    ifstream fin("date.in");
    for(int i = 1; i <= 4; i++) {
        fin >> A[i].first >> A[i].second;
    }

    a[1] = A[2].second - A[1].second;
    a[2] = A[4].second - A[3].second;

    b[1] = A[1].first - A[2].first;
    b[2] = A[3].first - A[4].first;

    c[1] = A[2].first * A[1].second - A[1].first * A[2].second;
    c[2] = A[4].first * A[3].second - A[3].first * A[4].second;

    fin.close();
}

int det() {
    return a[1] * b[2] - a[2] * b[1];
}

void procesare() {
    double d = det();
    if(d) {
        pair<double, double> I;
        I.first = (double)(-c[1] * b[2] + b[1] * c[2]) / d;
        I.second = (double)(-a[1] * c[2] + c[1] * a[2]) / d;
        if(min(A[1].first, A[2].first) <= I.first && max(A[1].first, A[2].first) >= I.first && min(A[1].second, A[2].second) <= I.second && max(A[1].second, A[2].second) >= I.second)
            if(min(A[3].first, A[4].first) <= I.first && max(A[3].first, A[4].first) >= I.first && min(A[3].second, A[4].second) <= I.second && max(A[3].second, A[4].second) >= I.second)
                cout << I.first << " " << I.second <<'\n';
            else
                cout << "multimea vida\n";
        else cout << "multimea vida\n";
    }
    else {
        if(A[1].first * A[2].second + A[2].first * A[3].second + A[3].first * A[1].second - A[3].first * A[2].second - A[2].first * A[1].second - A[1].first * A[3].second) {
            cout << "multimea vida (segmente aflate pe drepte paralele)\n";
        }
        else {
            if((max(A[1].first, A[2].first)< min(A[3].first, A[4].first))|| (max(A[3].first, A[4].first)< min(A[1].first, A[2].first)) )
                cout << "multimea vida (segmente aflate pe acc. dreapta dar disjuncte)\n";
            else {
                sort(A+1, A+5, cmpx);
                if(A[1].first == A[2].first)
                    if(A[1].second > A[2].second)
                        cout << "(" << A[2].first << " " << A[2].second << ") ";
                    else
                        cout << "(" << A[1].first << " " << A[1].second << ") ";
                else
                    cout << "(" << A[2].first << " " << A[2].second << ") ";

                if(A[3].first == A[4].first)
                    if(A[3].second > A[4].second)
                        cout << "(" << A[4].first << " " << A[4].second << ") ";
                    else
                        cout << "(" << A[3].first << " " << A[3].second << ") ";
                else
                    cout << "(" << A[3].first << " " << A[3].second << ") ";
            }
        }
    }
}

int main()
{
    citire();

    procesare();

    return 0;
}
