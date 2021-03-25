%Línea infinita distribuida sobre el eje z
%El valor introducido por teclado debe ser el nombre del fichero
%Valor de la densidad lineal de carga (C/m)
d=1e-9;
%defino la constante dieléctrica "e" en el vacío y le asigno su %valor
e=1/(4*pi*9*10^9);
%defino tres variables "x", "y", "z" para usarlas en la
%posterior visualización hecha con "contour"
%Corte con el plano (x,y)
[x,y] = meshgrid(-2:.2:2, -2:.2:2);
z=0;
%Según el estudio teórico el cálculo del potencial eléctrico "V"
% dependerá del logaritmo de la distancia a la línea, por tanto
% si considero que la línea está sobre el eje cartesiano Z, tendré
% que la distancia a dicha línea dependerá de la raíz cuadrada del
% cuadrado de los pares de puntos (x,y) que haya tomado
%(Usamos el teorema de pitágoraspara hallar un radio cualquiera)
V = d*log(sqrt(x.^2+y.^2))/(2*pi*e);
%puede visualizarse las lineas equipotenciales usando el plano X-Y
%usando un mismo radio para todas las líneas equipotenciales visibles
%desde este plano. Vamos a representar 5 superficies
%equipotenciales (5 radios distintos) cortadas sobre el plano X-Y
contour(x,y,V,5);
title('plano X-Y')
colorbar
%O también se puede visualizar las lineas equipotenciales usando el %plano X-Z. También representamos 5 superficies equipotenciales.
[x,z] = meshgrid(-2:.2:2, -2:.2:2);
y=0;
V = d*log(sqrt(x.^2+y.^2))/(2*pi*e);
contour(x,z,V,5);
title('plano X-Z')
colorbar
%También puede visualizarse las lineas equipotenciales usando el
%plano Y-Z. Escriba la parte de programa correspondiente en
%este caso.
[y,z] = meshgrid(-2:.2:2, -2:.2:2);
x=0;
V = d*log(sqrt(x.^2+y.^2))/(2*pi*e);
contour(y,z,V,5);
title('plano Y-Z')
colorbar