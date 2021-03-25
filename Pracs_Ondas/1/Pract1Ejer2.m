%L�nea infinita distribuida sobre el eje z
%El valor introducido por teclado debe ser el nombre del fichero
%Valor de la densidad lineal de carga (C/m)
d=1e-9;
%defino la constante diel�ctrica "e" en el vac�o y le asigno su %valor
e=1/(4*pi*9*10^9);
%defino tres variables "x", "y", "z" para usarlas en la
%posterior visualizaci�n hecha con "contour"
%Corte con el plano (x,y)
[x,y] = meshgrid(-2:.2:2, -2:.2:2);
z=0;
%Seg�n el estudio te�rico el c�lculo del potencial el�ctrico "V"
% depender� del logaritmo de la distancia a la l�nea, por tanto
% si considero que la l�nea est� sobre el eje cartesiano Z, tendr�
% que la distancia a dicha l�nea depender� de la ra�z cuadrada del
% cuadrado de los pares de puntos (x,y) que haya tomado
%(Usamos el teorema de pit�goraspara hallar un radio cualquiera)
V = d*log(sqrt(x.^2+y.^2))/(2*pi*e);
%puede visualizarse las lineas equipotenciales usando el plano X-Y
%usando un mismo radio para todas las l�neas equipotenciales visibles
%desde este plano. Vamos a representar 5 superficies
%equipotenciales (5 radios distintos) cortadas sobre el plano X-Y
contour(x,y,V,5);
title('plano X-Y')
colorbar
%O tambi�n se puede visualizar las lineas equipotenciales usando el %plano X-Z. Tambi�n representamos 5 superficies equipotenciales.
[x,z] = meshgrid(-2:.2:2, -2:.2:2);
y=0;
V = d*log(sqrt(x.^2+y.^2))/(2*pi*e);
contour(x,z,V,5);
title('plano X-Z')
colorbar
%Tambi�n puede visualizarse las lineas equipotenciales usando el
%plano Y-Z. Escriba la parte de programa correspondiente en
%este caso.
[y,z] = meshgrid(-2:.2:2, -2:.2:2);
x=0;
V = d*log(sqrt(x.^2+y.^2))/(2*pi*e);
contour(y,z,V,5);
title('plano Y-Z')
colorbar