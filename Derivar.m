format long #Ayuda a aumentar la presicion de los calculos

# x = variable de la funcion, h = paso para el calculo
function derivadaAdelante = DerivarAdelante (x,h)
  f_x = (0.3*(x**4)) - (0.15*(x**2)); 
  f_xh = (0.3*((x+h)**4)) - (0.15*((x+h)**2));
  f_i = (f_xh-f_x);
  derivadaAdelante = f_i/h;
endfunction

# x = variable de la funcion, h = paso para el calculo
function derivadaAtras = DerivarAtras (x,h)
  f_x = (0.3*(x**4)) - (0.15*(x**2));
  f_xh = (0.3*((x-h)**4)) - (0.15*((x-h)**2));
  f_i = (f_x-f_xh);
  derivadaAtras = f_i/h;
endfunction

# x = variable de la funcion, h = paso para el calculo
function derivadaCentrada = DerivarCentrada (x,h)
  f_xhAnt = (0.3*((x-h)**4)) - (0.15*((x-h)**2));
  f_xhSig = (0.3*((x+h)**4)) - (0.15*((x+h)**2));
  f_i = (f_xhSig-f_xhAnt);
  derivadaCentrada = f_i/(2*h);
endfunction

# x = variable de la funcion, h = paso para el calculo
function principal = Main()
  #Define variables
  a = [];
  b = [];
  c = [];
  a_err = [];
  b_err = [];
  c_err = [];
  i = 0;
  h = 0.5;
  lambda = 0.99;
  valorReal = 0.9;
  #--------------------------
  while (h > 0.00000000000001)#Calcula con un h con una precision de 15 digitos
    #Calculo para Adelante
    temp_a = DerivarAdelante(1,h);
    a = horzcat(a,h);
    temp_aerr = (valorReal-temp_a)/valorReal;
    a_err =horzcat(a_err ,temp_aerr);
    #Calculo para anterior
    temp_b = DerivarAtras(1,h);
    b = horzcat(b,h);
    temp_berr = (valorReal-temp_b)/valorReal;
    b_err = horzcat(b_err , temp_berr);
    #Calculo para centrada
    temp_c = DerivarCentrada(1,h);
    c = horzcat(c,h);
    temp_cerr = (valorReal-temp_c)/valorReal;
    c_err = horzcat (c_err , temp_cerr);
    h *=lambda;#decrementa paso en factor de lambda
  endwhile
  #Despliegue de grafico
  clf;
  set (gca, "xdir", "reverse");
  set (gca, "ydir", "reverse");
  loglog(a,a_err,"r");
  hold on
  loglog(b,b_err,"g");
  hold on 
  loglog(c,c_err,"b");
  hold on
  title ("error vs pasos");
  ylabel("Error");
  xlabel("Pasos");
  n = input ("Escribe s para salir: ");
  #------------------------------------
endfunction

Main()#llamado de funcion main para iniciar el programa
