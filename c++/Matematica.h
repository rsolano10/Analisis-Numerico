//
// Created by rodolfo on 17/02/18.
//

#ifndef ANALISIS_MATEMATICA_H
#define ANALISIS_MATEMATICA_H


#include <cmath>

class Matematica {
public:

    template <class T> T  Sumar(int cantidad, T x) {
        T result = 0;
        for (int i = 0; i < cantidad; ++i) {
            result += x;
        }
        return (result);
    }

    template <class T> T CuadraticaTradicional(T a, T b, T c, int tipo) {
        T result;
        if(tipo == 1){
            result = (-b + sqrt(b*b - 4.0*a*c))/(2.0*a);
        }
        else if (tipo == 2){
            result = (-b - sqrt(b*b - 4.0*a*c))/(2.0*a);
        }
        return result;
    }

    template <class T> T CuadraticaAlternativa(T a, T b, T c, int tipo) {
        T result;
        if(tipo == 1){
            result = (-2*c)/(b + sqrt(b*b - 4.0*a*c));
        }
        else if (tipo == 2){
            result = (-2*c)/(b - sqrt(b*b - 4.0*a*c));
        }

        return result;
    }

    template <class T> double  ErrorReal(double real, T aprox) {
        return real-aprox;
    }
    template <class T> double  ErrorAprox(T aprox1, T aprox2) {
        return (aprox1/aprox2)*100;
    }


};


#endif //ANALISIS_MATEMATICA_H
