#Aumenta la presicion de los datos
format long #presicion long 16 cifras significativas

#Funcion recursiva para calcular el factorial de un numero "num"
function FACTORIAL = Factorial(num)
  if (num <= 1 # Condicion de Finalizacion
    FACTORIAL = 1;
  else
    FACTORIAL = num * Factorial(num - 1); #Linea recursiva
  endif
endfunction
 
#Calculo de la sumatoria para calular e^x con una presicion de n digitos
function [VALORREAL,ERRORAPROXIMADO,ERRORREAL,TERMINOS] = Calcular(x,n)
  consecutivo = 0; #Cantidad de iteraciones del while
  aproximacionActual = 0;
  aproximacionAnterior = 0;
  errorAceptado = (x * (10**(2-n))); #El minimo error que se espera
  errorActual = errorAceptado + 1; #El error verdadero de la funcion
  while (errorActual > errorAceptado)
    aproximacionActual += (x**consecutivo)/(Factorial(consecutivo));
    errorActual = ((aproximacionActual-aproximacionAnterior)/aproximacionActual)*100;
    ++consecutivo;
    aproximacionAnterior = aproximacionActual;
  endwhile
  #Valores de retorno---------------------------
  VALORREAL = e**x
  APROXIMACION = aproximacionActual
  ERRORAPROXIMADO =  errorActual
  ERRORREAL = (((e**x) - aproximacionActual)/(e**x))* 100
  TERMINOS = consecutivo
  #---------------------------------------------
endfunction


#Principal metodo para toma de datos del usuario
function Main()
  n = input ("Cuantas cifras significativas desea: ");
  if(abs(mod(n,1))!=0)# Verifica que sea numero entero
    printf("Debe de ser un numero entero\n");
    Main();
  elseif(n>15) #Verifica que sea menor a la precision trabajada "long"
    printf("La maxima presicion es de 15 digitos\n");
    Main();
  else # entra solo si el dato es correcto
    x= input ("Ingrese el exponente deseado: ");
    printf("\n");
    Calcular(x,n);# Llamada de la funcion Clacular()
  endif
endfunction

#Llamada de la funcion Main()
Main()