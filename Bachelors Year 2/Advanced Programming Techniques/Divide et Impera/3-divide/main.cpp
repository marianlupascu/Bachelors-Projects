#include <iostream>
#include <vector>
#include <fstream>

std::vector<int> a;
int n;

int interclasare(int, int, int);

void citire() {
    std::ifstream fin(
            R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab Divide\3-divide\date.in)");
    fin >> n;
    for (int i = 0; i < n; i++) {
        int x;
        fin >> x;
        a.push_back(x);
    }
    fin.close();
}

int nrInv(int start, int end) {
    if (start == end) {
        return 0;
    } else {
        int m = (start + end) / 2;
        int n1 = nrInv(start, m);
        //std::cout<<start<<" "<<m<<" n1= "<<n1<<'\n';
        int n2 = nrInv(m + 1, end);
        //std::cout<<m+1<<" "<<end<<" n2= "<<n2<<'\n';
        return interclasare(start, m, end) + n1 + n2;
    }
}

int interclasare(int start, int m, int end) {
    std::vector<int> b;
    b.assign(a.size(), 0);
    int i = start, j = m + 1, k = 0, nr = 0;

    while ((i <= m) && (j <= end)) { //pasul de numarare
        if (a[i] <= 2 * a[j]) {
            i++;
        } else {
            j++;
            nr += (m - i + 1);
        }
    }
    i = start;
    j = m + 1;
    while ((i <= m) && (j <= end)) { //pasul de interclasare
        if (a[i] <= a[j]) {
            b[k] = a[i];
            i++;
        } else {
            b[k] = a[j];
            j++;
        }
        k++;
    }
    while (i <= m) {
        b[k] = a[i];
        k++;
        i++;
    }
    while (j <= end) {
        b[k] = a[j];
        k++;
        j++;
    }
    for (i = start; i <= end; i++)
        a[i] = b[i - start];

    return nr;
}

int main() {

    citire();

    std::ofstream fout(
            R"(C:\Users\Maryan\Documents\Documents\FMI\II\SEM I\Tehnici Avansate de Programare\Laboratoare\Lab Divide\3-divide\date.out)");

    fout << "Numarul de Inversiuni semnificative este = " << nrInv(0, a.size() - 1);

    for (int i = 0; i <= a.size() - 1; i++)
        std::cout << a[i] << " ";

    fout.close();

    return 0;
}