#include <iostream>
#include "Matematica.h"
using namespace std;

Matematica *math= new Matematica();
static int CUADRATICAPOS = 1;
static int CUADRATICANEG = 2;

template <class T> void TestSumatoria(int n,T x){
    T res = math->Sumar<T>(n,x);
    cout << "Sumatoria: " << res << endl;
    double real = n*x;
    double resError = math->ErrorReal<T>(real,res);
    cout << "Error Verdadero: " << resError << endl;

}
template <class T> void TestCuadratica(T a,T b, T c){
    T res1 = math->CuadraticaTradicional<T>(a,b,c,CUADRATICAPOS);
    cout << "Cuadratica Tradicional Solucion 1 : " << res1 << endl;
    T res3 = math->CuadraticaAlternativa<T>(a,b,c,CUADRATICAPOS);
    cout << "Cuadratica Alternativa Solucion 1 : " << res3 << endl;
    double resError1 = 100 - math->ErrorAprox(res1,res3);
    cout << "Error Aproximado Procentual 1: " << resError1 << endl;
    cout << "----" << endl;
    T res2 = math->CuadraticaTradicional<T>(a,b,c,CUADRATICANEG);
    cout << "Cuadratica Tradicional Solucion 2 : " << res2 << endl;
    T res4 = math->CuadraticaAlternativa<T>(a,b,c,CUADRATICANEG);
    cout << "Cuadratica Alternativa Solucion 2 : " << res4 << endl;
    double resError2 = 100 - math->ErrorAprox(res2,res4);
    cout << "Error Aproximado Procentual 2: " << resError2 << endl;

}

int main() {
    cout << "------ Sumatorias ------" << endl;
    cout << "-- Float --" << endl;
    TestSumatoria<float>(10000000,0.00001);
    cout << "-- Double --" << endl;
    TestSumatoria<double>(10000000,0.00001);
    cout << "------ Cuadraticas ------" << endl;
    cout << "-- Float --" << endl;
    TestCuadratica<float>(1,3000.001,3);
    cout << "-- Double --" << endl;
    TestCuadratica<double>(1,3000.001,3);
    return 0;
}

