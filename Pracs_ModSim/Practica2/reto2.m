clear all;
close all;
clc;

%datos partida
K = 1.38e-23; %constante de Boltzmann
T = 290; %temperatura de ruido en la antena
F = 12; %figura de ruido del receptor (en dB)
g = 10; %ganancia del transmisor y del receptor (en dB)
d = 1000; %distancia en metros
lP = 1500; %tamaño total de la trama en bits
R=[100000, 200000, 300000, 400000, 50000];
N_o = K*(T+T*(10^(F/10)-1)); %densidad espectral de ruido
vector_p_tx = [3 5 7 9 11 13 15 17 19]; %vector de posibles potencias de transmisión en dBm

%matriz de transición del canal radio

Pradio = [0.33 1-0.33 0 0 0 0 0 0 0 0 0;
    0.12 1-0.12-0.2 0.2 0 0 0 0 0 0 0 0;
    0 0.15 1-0.15-0.18 0.18 0 0 0 0 0 0 0;
    0 0 0.18 1-0.15-0.18 0.15 0 0 0 0 0 0;
    0 0 0 0.19 1-0.19-0.14 0.14 0 0 0 0 0;
    0 0 0 0 0.2 1-0.2-0.13 0.13 0 0 0 0;
    0 0 0 0 0 0.21 1-0.21-0.12 0.12 0 0 0;
    0 0 0 0 0 0 0.22 1-0.22-0.11 0.11 0 0;
    0 0 0 0 0 0 0 0.23 1-0.23-0.1 0.1 0;
    0 0 0 0 0 0 0 0 0.24 1-0.24-0.09 0.09;
    0 0 0 0 0 0 0 0 0 0.2 1-0.2;];

%ganancias del canal en cada estado
H = [-80 -76 -73 -71 -69 -67 -66 -65 -64 -63 -62];

%U conjunto de acciones de control
U = 1:length(vector_p_tx); %En el caso de este ejercicio U tiene un tamaño de 9 elementos
%Nota sobre cell --> Lo que hace es celdas capaces de guardar tanto
%vectores como matrices
Pu = cell(1,length(R)); %conjunto de matrices de markov;
Gu = cell(1,length(R)); %conjunto de vectores de coste; 

for i=1:length(R)
     Pu_p = cell(1,length(U)); %conjunto de matrices de markov;
     Gu_p = cell(1,length(U)); %conjunto de vectores de coste; 
    for u = U
        p_tx = vector_p_tx(u);
        p_tx_W = 10^(p_tx/10)*0.001; %potencia de transmisión en W
        vector_p_rx = (p_tx_W*10^(g/10)*10^(g/10)/d^2).*10.^(H./10); %vector de potencias recibidas en cada estado
        vector_BER = min(1, 0.5*exp(-vector_p_rx/(R(i)*N_o))./sqrt(pi()*vector_p_rx/(R(i)*N_o))); %vector de tasas de error en cada estado
        vector_Prx = (1-vector_BER).^lP; %vector de probabilidad de recepción de trama en cada estado
        vector_PNrx = (1-vector_Prx)'; %vector de probabilidad de no recepción de trama en cada estado
        Pu_p{u} = Pradio.*repmat(vector_PNrx,1,11); %matriz de probabilidad de transición para el control u
        Gu_p{u} = (lP*p_tx_W/R(i))*ones(11,1); %matriz de coste en cada estado para el control u 
    end;
    Pu{i}=Pu_p;
    Gu{i}=Gu_p;
   
end


%%%%%POLICY ITERATION%%%%%

%Atención MUY IMPORTANTE en un SSP se elimina de la matriz el estado de
%terminación

N = length(H);
max_iter = 10000;
iter = 0;
sigue = true;

%Actuamos para cada grupo R
Jp = cell(1,length(R)); %conjunto de matrices de markov;
for vR=1:length(R)
    %Retomamos los valores de Gu y Pu parciales
     Pu_p = cell(1,length(U)); %conjunto de matrices de markov;
     Gu_p = cell(1,length(U)); %conjunto de vectores de coste; 
     
     %Los asignamos con el valor de cada una de las celdas
     Pu_p=Pu{vR};
     Gu_p=Gu{vR};
    %Definimos la política inicial sabiendo que los valores deben estar
    %entre 1 y lenght(U) ya que Pu y Gu se elaboran en base a estas dimensiones
    % de U
    policy =[1;2;3;4;5;6;7;8;9;8;7]; %inserte aquí su politica inicial (vector columna)
    
    g = [];
    P = [];
    I = eye(N);
    for i = 1:N
        u = policy(i); %Recorre el vector de politicas iniciales
        g = [g;Gu_p{u}(i)]; %Compone g añadiendo en cada fila el valor de la posicion i del vector que hay celda u
                          % Esto ordena los valores de Gu siguiendo las posiciones de la politica, por eso max(polici)=9 
        P = [P;Pu_p{u}(i,:)]; %Compone P añadiendo en cada fila, la fila i de la celda u de Pu
    end

    Jpolicy = (I-P)\g; %obtenga la J (vector de costes) de la politica inicial --> Formula y a correr

    initial_cost = Jpolicy; %Definimos el vector de costes iniciales como Jpolicy

    %%%%
    % implemente aquí el bucle de policy iteration
    %%%%

    %Tenemos que inicializar los valores para las iteraciones

    politica_actual=policy; % Tomamos como politica de partida (actual) policy

    while sigue
        %Al comienzo del bucle, reiniciamos todos los valores que se tengan que
        %machar en cada iteracion
        g=[];
        P=[];
        J=zeros(N, length(U)); %En cada iteración debemos calcular un vector de costes

        for u=1:length(U) %Para cada valor de U
            %Despejamos la formula gu=(I-Pu)Ju, tomamos Ju como los costes ant.
            J(:,u)=Gu_p{u} + Pu_p{u}*Jpolicy; %Obtenemos el valor de cada columna de la matriz de costesz
        end;

        [cost_minimo, politica_iteracion]=min(J,[],2); %Nos interesa la posicion de los indices que son los que definen la nueva politica

       %Repetimos los cálculos que se han usado en el caso inicial
        for i = 1:N
            u = politica_iteracion(i); %Recorre el vector de politicas iniciales usando la nueva politica
            g = [g;Gu_p{u}(i)]; %Compone g añadiendo en cada fila el valor de la posicion i del vector que hay celda u
                              % Esto ordena los valores de Gu siguiendo las posiciones de la politica, por eso max(polici)=9 
            P = [P;Pu_p{u}(i,:)]; %Compone P añadiendo en cada fila, la fila i de la celda u de Pu
        end

        %Regeneramos la política para determinar si es óptima
        Jpolicy_iteracion=(I-P)\g;

        %Determinamos si estamos en la politica óptima
        % Será óptima si no podemos encontrar en una iteración valores de
        % costes J mínimos que en la política anterior
        if(politica_iteracion==politica_actual) 
           %Tomamos la política actual como óptima y salimos del bucle
           p_optima=politica_actual;
           sigue=false;

        else
            %Si no hemos repetido, entonces guardamos los valores de la
            %política que hemos sacado como actual y volvemos a iterar
            politica_actual=politica_iteracion;
            Jpolicy=Jpolicy_iteracion; %Almacenamos la política para la siguiente iteración
        end

        %Para evitar que esto se quede en un bucle infinito limitamos las
        %iteraciones
        iter=iter+1;
        if(iter==max_iter)
            sigue=false; % Obligamos a que al entrar se cancele
        end;

    end;
    
    % Nos guardamos el valor de las politicas
    Jp{vR}=Jpolicy;

    
end;

%% Represente el coste de la política óptima y la de la su política inicial

figure(1);
plot(initial_cost, 'r');
hold;
for i=1:length(Jp)
   plot(Jp{i}); 
end;

