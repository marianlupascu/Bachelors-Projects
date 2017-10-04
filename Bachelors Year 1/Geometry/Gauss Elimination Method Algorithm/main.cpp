#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    int n;//n is the number of unknowns
    cout<<"n: ";
    cin>>n;
    float ** A;//Declare a pointer to pointer to use as a dynamic 2D array
    A=new float*[n];
    for (int i=0;i<n;i++)
    {
        A[i]=new float[n+1];
    }
    cout<<'\n';
    for (int r=0;r<n;r++)//Get the array elements from the user
    {
        for (int c=0;c<n+1;c++)
        {
            cout<<"A["<<r+1<<"]"<<"["<<c+1<<"] :";
            cin>>A[r][c];
        }
    }
    cout<<'\n';
    for (int r=0;r<n;r++)//Display the array on the console screen
    {
        for (int c=0;c<n+1;c++)
        {
            cout<<" "<<A[r][c]<<" ";
        }
        cout<<'\n';
    }

    for (int a=0;a<n;a++)
    {
        for(int x=0;x<(n+1);x++)
        {
            A[a][x]=A[a][x]/A[a][a];
        }
        for (int i=0;i<n;i++)
        {

            for (int j=0;j<(n+1);j++)
            {
                if(a==i) continue;
                A[i][j]=A[i][j]-A[a][j]*A[i][a];
            }
        }
    }
    cout<<"Solution of the system:"<<'\n';
    for (int r=0;r<n;r++)//The result after apllying the gauss algorithm
    {
        for (int c=0;c<n+1;c++)
        {
            cout<<" "<<A[r][c]<<" ";
        }
        cout<<'\n';
    }

}
