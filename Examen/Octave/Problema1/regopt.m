## Instituto Tecnológico de Costa Rica
## Área Académica de Ingeniería en Computadores
## CE-3102 Análisis Numérico para Ingeniería
## Prof. Pablo Alvarado
## I Semestre 2018
## Examen Final

## PROBLEMA 1

## NOMBRE: Rodolfo Solano Asenjo
## CARNE: 2015095556


## Cargar los datos
X=load("-ascii","regresion.dat");

####################################################
## Problema 1.1                                   ##
## Grafique los puntos bidimensionales            ##
####################################################
figure(1);
filas_x = X(1,:);
filas_y = X(2,:);
plot(filas_x,filas_y,'x'),title('Problema 1.1 y 1.7'),xlabel('x'),ylabel('y'), grid('on');
hold on;

####################################################
## Problema 1.2                                   ##
## Implemente la función de error                 ##
####################################################
function val=f(abc,X)
  ## abc: vector columna [a,b,c]' con los parámetros de la función cuadrática
  ## X:   datos para evaluar la función, un dato por columna
  
  #Variables a utilizar
  yi = X(2,:); # valores y
  xi = X(1,:); #valores x
  a = abc(1,1);
  b = abc(2,1);
  c = abc(3,1);
  
  #Componentes de la sumatoria
  temp = ((a .* (xi .^ 2)) + (b.*xi) .+ c); #aproximacion de y
  temp2 = (yi - temp).^2; # y teorica - y real al cuadrado
  
  #Retorno de resultado
  val = sum(temp2);
  
endfunction


####################################################
## Problema 1.3                                   ##
## Implemente el gradiente de la función de error ##
####################################################
function val=gf(abc,X)
  ## abc: vector columna [a,b,c]' con los parámetros de la función cuadrática
  ## X:   datos para evaluar la función, un dato por columna
  

  ## Use diferenciación NUMERICA para calcular el gradiente de f:
  h = 0.002; #paso de diferenciacion
  
  #valores de abc para calcular diferenciacion
  abc_a_1 = [abc(1,1) - h; abc(2,1); abc(3,1) ];
  abc_a_2 = [abc(1,1) + h; abc(2,1); abc(3,1) ];
  abc_b_1 = [abc(1,1); abc(2,1) - h; abc(3,1) ];
  abc_b_2 = [abc(1,1); abc(2,1) + h; abc(3,1) ];
  abc_c_1 = [abc(1,1); abc(2,1); abc(3,1) - h ];
  abc_c_2 = [abc(1,1); abc(2,1); abc(3,1) + h ];
  
  #valores de funciones
  f_a_1 = f(abc_a_1,X);
  f_a_2 = f(abc_a_2,X);
  f_b_1 = f(abc_b_1,X);
  f_b_2 = f(abc_b_2,X);
  f_c_1 = f(abc_c_1,X);
  f_c_2 = f(abc_c_2,X);
  
  #derivadas parciales
  ####################################################
  ## Justificacion                                  ##
  ## Se utilizo derivacion centrada debido que este ##
  ## da un menor error                              ##
  ####################################################
  
  d_a =  (f_a_2 - f_a_1) / (2 *h);
  d_b =  (f_b_2 - f_b_1) / (2 *h); 
  d_c =  (f_c_2 - f_c_1) / (2 *h); 
  
  #composicion  de gradiente
  val = [d_a;d_b;d_c];

endfunction

####################################################
## Problema 1.4                                   ##
## Descenso de gradiente                          ##
####################################################
function [ABC,err]=optimice(f,gf,X,lambda,tol,abc0=[0,0,0]')
  ## f      es el handler de la función a optimizar
  ## gf     es el handler que calcula el gradiente de f
  ## X      es la matriz de datos 
  ## lambda es el tamaño de paso del descenso de gradiente
  ## tol    es el umbral de tolerancia para determinar convergencia
  ## abc0   es un vector [a0,b0,c0] especificando el punto inicial de
  ##        la optimización
  ## ABC    es una matrix de n x 3, donde cada fila corresponde a un
  ##        paso en el proceso de optimización.  Es decir, ABC(:,1)
  ##        corresponde siempre a abc0, y ABC(:,rows(ABC)) corresponde
  ##        a los parámetros óptimos.
  ## err    es el vector conteniendo los errores en cada paso

  if ( (rows(abc0)!=3) || columns(abc0)!=1 )
    error("Vector inicial no tiene forma 3x1");
  endif;
  
  #Inicializacion de variables
  ABC = abc0'; err=[];

  convergencia = 1; #define condicion de terminacion segun el gradiente y tol
  h = 0.002; #paso de diferenciacion
  i = 0; # Contador de iteraciones para detener en caso de no converger
  while ((convergencia > tol) && i < 10000)
    #Descenso del gradiente
    gradiente = h * gf(abc0,X);
    abctemp = abc0;
    abc0 = abc0 - gradiente;
   
    # Guarda valores intermedios de abc
    ABC = vertcat(ABC,abc0');
    
    #Guarda los valores de error
    error = f(abc0,X);
    err = horzcat(err,error);
    
    #Condiciones de finalizacion
    convergencia = abs (gradiente(1,1)**2 + gradiente(2,1)**2 + gradiente(3,1)**2)**(0.5);
    i = i+1;
    
  endwhile
endfunction

## Llame al optimizador con la interfaz anterior

lambda=1;  # Ajuste esto
tol=1e-10; # Ajuste esto
[ABC,err]=optimice(@f,@gf,X,lambda,tol,[0,1,0]');

####################################################
## Problema 1.5                                   ##
## Imprima el conjunto óptimo de parámetros       ##
####################################################
ABC_OPTIMO = ABC(rows(ABC),:)

####################################################
## Problema 1.6                                   ##
## Muestre el error en función de las iteraciones ##
####################################################
figure(2);
n = [1:1:columns(err)];
plot(n,err),title('Grafica de error vs iteraciones'),xlabel('Iteraciones'),ylabel('Error'), grid('on');

####################################################
## Problema 1.7                                   ##
## Muestre las curvas inicial, intermedias y      ##
## final ajustadas a los datos                    ##
####################################################

function val=Y(abc,X)
  ## abc: vector columna [a,b,c]' con los parámetros de la función cuadrática
  ## X:   datos para evaluar la función, un dato por columna
  
  #Variables a utilizar
  xi = X(1,:); #valores x
  a = abc(1,1);
  b = abc(2,1);
  c = abc(3,1);
  
  #Componentes de la sumatoria
  val = ((a .* (xi .^ 2)) + (b.*xi) .+ c);
  
  
endfunction
figure(1);
temp_Y = Y([0;1;0],X); # corresponde a la funcion teorica de Y
plot(X(1,:),temp_Y,'k');
hold on;

for  i = 2:columns(err)
  abc_temp = ABC(i,:);
  abc_temp = abc_temp';
  temp_Y = Y(abc_temp,X); # corresponde a la funcion teorica de Y
  plot(X(1,:),temp_Y,['o','c']);
  hold on;
endfor

abc_temp = ABC(rows(ABC),:);
abc_temp = abc_temp';
temp_Y =Y(abc_temp,X); # corresponde a la funcion teorica de Y

plot(X(1,:),temp_Y,['o','r']);


hold on;

