## Instituto Tecnológico de Costa Rica
## Área Académica de Ingeniería en Computadores
## CE-3102 Análisis Numérico para Ingeniería
## Prof. Pablo Alvarado
## I Semestre 2018
## Examen Final

## PROBLEMA 3

## NOMBRE: Rodolfo Solano Asenjo
## CARNE: 2015095556

3;

## Cargue los datos 
X=load("-ascii","pcadata.dat");
N=columns(X);

################################################
## Problema 3.1                               ##
## Grafique los datos                         ##
################################################
x = X(1,:);
y = X(2,:);
z = X(3,:);
plot3(x,y,z,['x','b']),title('Valores de X y punto Medio'),xlabel('x'),ylabel('y'),zlabel('z'), grid('on');
hold on;
  
################################################
## Problema 3.2                               ##
## Calcule la media de los datos              ##
################################################

#Para determinar el punto medio se suman todos 
#los componentes de cada vector y se dividen 
#entre el numero total de datos. Se contruye de 
#la forma [x,y,z]

mx = sum(x) / columns(x);
my = sum(y) / columns(y);
mz = sum(z) / columns(z);
pm = [mx;my;mz];

################################################
## Problema 3.3                               ##
## Muestre la media en rojo                   ##
################################################

figure(1);
plot3(mx,my,mz,['o','r']);
hold off;


################################################
## Problema 3.4                               ##
## Calcule los datos sin media                ##
################################################
#Para calcular estos datos lo que se hace es
#restar la media a cada valor de los ejes 
Xd = X - pm;
x0 = Xd(1,:);
y0 = Xd(2,:);
z0 = Xd(3,:);

figure(2);
plot3(x0,y0,z0,['x','b']),title('Datos con media 0'),xlabel('x'),ylabel('y'),zlabel('z'), grid('on');
hold on;

#Media
mx0 = sum(x0) / columns(x0);
my0 = sum(y0) / columns(y0);
mz0 = sum(z0) / columns(z0);

plot3(mx0,my0,mz0,['o','r'])

hold on;

################################################
## Problema 3.5                               ##
## Calcule la matriz de covarianza            ##
################################################
f = columns(Xd); #columnas
c = rows(Xd); # filas
covar=zeros(c,c); # matriz de covarianza
for j=1:c
  for i=1:c
  covar(j,i)=sum(Xd(:,j).*Xd(:,i))/f;
  endfor
endfor
covar
################################################
## Problema 3.6                               ##
## Encuentre los eigenvalores y eigenvectores ##
################################################
[eigevec, eigval] = eig(covar)

################################################
## Problema 3.7                               ##
## Reordene los eigenvectores para PCA        ##
################################################
auxeigvec=zeros(1,c); # matriz eigenvectores reacomodada
for i=1:c
  auxeigval(1,i)=sum(eigval(:,i)); # eigenvalores en forma de vector
endfor

aux1=zeros(1,c); # contiene vectores de posiciones ordenadas.
for j=1:c
  for i=1:c
    if max(auxeigval)== auxeigval(i)
      aux1(j)=i;
    end
  end
  auxeigval(aux1(j))=0;
end

vectcar=zeros(size(eigevec)); # Matriz caracteristica, eigenvectores ordenados.
for i=1:c
vectcar(:,i)=eigevec(:,aux1(i));
end
vectcar
########################################################################
## Problema 3.8                                                       ##
## Cuáles son los ejes principales y qué varianza tiene los datos     ##
########################################################################

#sumamos filas para verificar cual eje tiene mayor varianza
covx = abs (sum(covar(1,:)))
covy = abs (sum(covar(2,:)))
covz = abs (sum(covar(3,:)))

mv = 0; # variable que reconoce cual tiene la menor varianza, y cual eliminar en matriz caracteristica 
if (covx < covy)
  if (covx < covz)
    mv = aux1(1,1);
  else
     mv = aux1(1,3);
  endif
else 
  if (covy < covz)
    mv = aux1(1,2);
  else
     mv = aux1(1,3);
  endif
endif

matriz_principal = []; # nueva matriz eliminando ejes no principales
for i = 1:c
  if (i != mv)
    matriz_principal = horzcat(matriz_principal,vectcar(:,i));
  endif
endfor
matriz_principal
#En este caso en especifico, decimos que eliminamos el eje x, ya que tiene la varianza mas baja
#los ejes principales son y,z

########################################################################
## Problema 3.9                                                       ##
## Calcule la proyección de los datos al plano engendrado por los dos ##
## eigenvectores                                                      ##
########################################################################
#reducimos Xd los vectores X
#mfd = matriz_principal' * Xd;
mfd = vectcar' * Xd;
## Grafique la proyección
figure(3);
pt0 = zeros(f);
plot3(pt0(1,:),mfd(1,:),mfd(2,:),['x','b']),title('proyecccion de principales yz'),xlabel('x'),ylabel('y'),zlabel('z'), grid('on');
hold on;

########################################################################
## Problema 3.10                                                      ##
## Calcule los datos reconstrudos a partir de los datos proyectados   ##
########################################################################
#Codigo por cambiar

Xd1 = inv(vectcar') * mfd;
###################
figure(4);
plot3(x,y,z,['x','b']),title('Matriz inicial vs reconstruida'),xlabel('x'),ylabel('y'),zlabel('z'), grid('on');
hold on;
plot3(Xd1(1,:),Xd1(2,:),Xd1(3,:),['s','m'])
hold off;
