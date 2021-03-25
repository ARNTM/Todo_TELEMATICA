%El valor introducido por teclado debe ser el nombre del fichero
%Los par�metros y variables usados para esta funci�n coinciden con %los usados para la funci�n esfera del apartado anterior.
A=5e-3;
p=1.0e-9;
e=1/(4*pi*9*10^9);
% Corte seg�n el eje z=0; representaci�n en el plano (x,y).
[x,y] = meshgrid(-A:A/20:A, -A:A/20:A);
z=0;
%Las curvas equipotenciales en el interior quedar�an descritas por la %siguiente expresi�n de "V1" (potencial el�ctrico) respecto a un %punto cualquiera (x,y,z), considerando que la esfera est� centrada %en el origen de coordenadas cartesianas.
rr=sqrt(x.^2+y.^2+z^2);
% Cogemos los indices para ver que posiciones est�n dentro de la % esfera y que posiciones est�n fuera.
Ind_fuera=(rr>A);
Ind_dentro=(rr<=A);
% Calculamos el potencial dentro y fuera de la esfera.
% Primero, definimos una matriz de ceros.
V_dentro=zeros(size(rr));
V_fuera=zeros(size(rr));
% Despu�s, calculamos los valores del potencial en sus posiciones.
V_dentro(Ind_dentro)=(p/(2*e)).*(A^2-rr(Ind_dentro).^2/3);
V_fuera(Ind_fuera)=p.*A^3./(3*e.*rr(Ind_fuera));
% Finalmente, unimos ambas contribuciones (dentro y fuera).
V1=V_dentro+V_fuera;
%creamos el gradiente de este potencial el�ctrico en las tres %direcciones seg�n los ejes cartesianos.
[px,py] =gradient(V1,A/20,A/20);
%direccion del campo electrico
%plano x-y
[x,y]=meshgrid(-A:A/20:A, -A:A/20:A);
contour(x,y,V1,5) %representaci�n en 2d  con ejes x e y de la funci�n "V1", tomando 5 valores
hold on
quiver(x,y,-px,-py)
hold off
title('Plano X-Y');
xlabel('Eje X');
ylabel('Eje Y');
colorbar