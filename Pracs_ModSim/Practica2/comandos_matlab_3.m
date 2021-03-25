function comandos_matlab_3

%% maximos y minimos

a = [1 15 2 0.5]
val = max(a) %devuelve el maximo valor. El minimo se obtiene con min(a)
[val,ind] = max(a) %devuelve el maximo y su posicion en el vector
A = [1 8 2;9 5 6; 3 4 7]
vector = max(A) %devuelve un vector fila con los maximos de cada columna
[vector, ind] = max(A) %devuelve un vector fila con los maximos de cada columna y otro vector con las posiciones en cada columna
columns = min(A,[],2) %devuelve un vector columna con los minimos de cada fila
[columns, ind] = min(A,[],2) %devuelve un vector columna con los minimos de cada fila y otro vector con las posiciones en cada fila

%% bucle for

w = [];
z = 0;
vector = 1:5
for i=vector
    w = [w 2*i]
    z = z + i;
end

%% bucle while y condicionales

sigue = true;
indice = 0;
objetivo = 5;

while sigue %el bucle continúa mientras esta variable sea true
    indice = indice + 1
    if (indice == objetivo)
        sigue = false;
    elseif (mod(indice,2)==1)
        objetivo = objetivo + 1
    else
        objetivo = objetivo - 1
    end
end    


%% uso de cell

U = 1:3;
Pu = cell(1,length(U));

for u = U
    Pu{u} = u*ones(3)  %en cada posición de cell se almacena una matriz
    Pu{u}
end

indices = [2, 3, 1];

P = [];
for i = 1:length(indices)
    u = indices(i);
    P = [P;Pu{u}(i,:)] %componemos una matriz con las filas de las matrices almacenadas 
end

J = [];
for u = U
    J = [J, Pu{u}*ones(3,1)] %componemos una matriz con vectores creados a partir de las matrices almacenadas
end


%% curvas 2D
x = 0:pi/20:4*pi
curva = sin(x);
curva2 = cos(x);
hold on;
plot(curva,'r'); %representa sin asignar ningun valor al eje
plot(curva2);
figure; %crea otra figura
plot(x,curva,x,curva2); %representa dos (o más) curvas en la misma figura



