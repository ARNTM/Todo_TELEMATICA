function comandos_matlab_1

%%  vectores y matrices

A = [1 2; 3 4; 5 6]

v = [1 2 3]
v = [1; 2; 3]
v = v'
v = [1:0.1:2]  % de 1 a 2, en pasos de 0.1.
v = 1:3   % de 1 a 3, asumiendo pasos de 1

w = ones(1,3)   % vector fila de unos
w = ones(3,1)   % vector columna de unos
W = ones(3,3)   % matriz de unos
W = 5*ones(3,3) % matriz de cincos
w = zeros(1,3)  %vector fila de ceros
w = zeros(3,1)  %vector columna de ceros
W = zeros(3,3)  %matriz de unos

I = eye(4)    % matriz identidad 4x4

%% dimensiones
sz = size(A) %filas y columnas de A
size(A,1)  % numero de filas
size(A,2) % numero de columnas
length(v)  % tamaño de la dimension maxima

%% acceso a elementos
A(3,2) % indexar indicando fila y columna
A(2,:)  % obtiene la segunda fila. %% ":" significa todos los elementos en esa dimension
A(:,2)  % obtiene la segunda columna
A(1,end) % primera fila, ultimo elemento
A(end,:) % ultima fila
A([1 3],:) %filas 1 y tres de A

A(3,2) = 7 %sustituye un elemento
A(:,2) = [10 11 12]'  % sustituye la segunda columna
A = [A, [13; 14; 15]] % añade una nueva columna

%% operaciones
B = A/2 %multiplica A por 0.5
B = 2./A %divide 2 por cada elemento de A
B = A - B;
B = A*B %multiplicacion de matrices
B = A.*B %multiplicacion elemento a elemento
B = A^5; %multiplica 5 veces la matriz A por si misma
B = A.^5; %eleva a 5 cada elemento de A
B = v*A %multiplicacion vector fila - matriz
B = A*v'%multiplicacion matriz - vector columna
esc = v*v' %producto escalar (vector fila por vector columna)
M = v'*v %las columnas de la matriz resultante son el vector columna multiplicado por los elementos del vector fila

%% funciones utiles

sum = sum(v) %suma los elementos de v
prod = prod(v) %multiplica los elementos de v
sumfilas = sum(A) %vector fila igual a la suma de las filas
sumcolmn = sum(A,2) %vector columna igual a la suma de las columna
V = repmat(v,1,3) %replica el vector v en una linea y tres columnas: V = [v v v]

%% ordenar vectores

a = [1 15 2 0.5]
[asc i] = sort(a) %ordena los elementos de a en orden ascendente y da los indices ordenados
[des i] = sort(a,'descend') %ordena en orden descendente


%% ecuaciones lineales

A = [2 4 4; 5 1 2; 3 1 1];
b = [8 10 6]';
x = inv(A)*b %resuelve el sistema Ax = b invirtendo A y multiplicando por el vector columna b
x = b'*inv(A) %resuelve el sistema xA = b invirtendo A, donde x y b son vectores fila
x = A\b %resuelve el sistem Ax = b por eliminacion Gaussiana
x = linsolve(A,b) %resuelve el sistem Ax = b por factorizacion LU
