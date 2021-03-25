%El valor introducido por teclado debe ser el nombre del fichero
%Los parámetros y variables usados para esta función coinciden con %los usados para la función esfera del apartado anterior.
A=5e-3;
p=1.0e-9;
e=1/(4*pi*9*10^9);
% Corte según el eje z=0; representación en el plano (x,y).
[x,y] = meshgrid(-A:A/20:A, -A:A/20:A);
z=0;
%Las curvas equipotenciales en el interior quedarían descritas por la %siguiente expresión de "V1" (potencial eléctrico) respecto a un %punto cualquiera (x,y,z), considerando que la esfera está centrada %en el origen de coordenadas cartesianas.
rr=sqrt(x.^2+y.^2+z^2);
% Cogemos los indices para ver que posiciones están dentro de la % esfera y que posiciones están fuera.
Ind_fuera=(rr>A);
Ind_dentro=(rr<=A);
% Calculamos el potencial dentro y fuera de la esfera.
% Primero, definimos una matriz de ceros.
V_dentro=zeros(size(rr));
V_fuera=zeros(size(rr));
% Después, calculamos los valores del potencial en sus posiciones.
V_dentro(Ind_dentro)=(p/(2*e)).*(A^2-rr(Ind_dentro).^2/3);
V_fuera(Ind_fuera)=p.*A^3./(3*e.*rr(Ind_fuera));
% Finalmente, unimos ambas contribuciones (dentro y fuera).
V1=V_dentro+V_fuera;
%creamos el gradiente de este potencial eléctrico en las tres %direcciones según los ejes cartesianos.
[px,py] =gradient(V1,A/20,A/20);
%direccion del campo electrico
%plano x-y
[x,y]=meshgrid(-A:A/20:A, -A:A/20:A);
contour(x,y,V1,5) %representación en 2d  con ejes x e y de la función "V1", tomando 5 valores
hold on
quiver(x,y,-px,-py)
hold off
title('Plano X-Y');
xlabel('Eje X');
ylabel('Eje Y');
colorbar