function comandos_matlab_2

%% maximos y minimos

a = [1 15 2 0.5]
val = max(a) %devuelve el maximo valor
[val,ind] = max(a) %devuelve el maximo y su posicion en el vector
A = [1 8 2;9 5 6; 3 4 7];
vector = max(A) %devuelve un vector fila con los maximos de cada columna
[vector, ind] = max(A) %devuelve un vector fila con los maximos de cada columna y otro vector con las posiciones en cada columna
[val, i] = max(vector) %obtenemos el mayor elemento de A y la columna en la que se encuentra
c = [ind(i) i] %coordenadas del m�ximo
A(ind(i), i) %comprobamos el valor del m�ximo

%% bucle for

w = [];
z = 0;
vector = 1:10
for i=vector %bucle simple
    w = [w 2*i]
    z = z + i;
end

B = [];
k = 1;
filas = 1:5

for i = filas %bucle anidado
    fila = [];
    for j = vector
        fila = [fila k*j]
    end
    B = [B; fila]
    k = k + 1;
end

%% curvas 2D
x = 0:pi/20:4*pi
curva = sin(x)
plot(curva); %representa sin asignar ningun valor al eje
figure; %crea otra figura
plot(x,curva) %representa usando como eje el vector x
curva2 = cos(x)
figure; %crea otra figura
plot(x,curva,x,curva2); %representa dos (o m�s) curvas en la misma figura

%% curvas 3D
figure; %crea otra figura
mesh(B)  %representa la matriz sin asignar ningun valor a los ejes
%surf(B) %como una superficie
vector_x = 100:100:1000
vector_y = 0.1:0.1:0.5
[x y] = meshgrid(vector_x, vector_y); %crea ejes para representacion 3D
figure; %crea otra figura
mesh(x,y,B) %representa la matriz con los ejes creados
%surf(x,y,B) % como una superficie

% como encontrar los indices del minimo (o maximo) elemento de una matriz
min_element = min(B(:));
[i_min, j_min] = find(B==min_element)
