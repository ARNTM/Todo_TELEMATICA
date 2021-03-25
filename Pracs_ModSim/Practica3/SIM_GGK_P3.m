%% ESQUELETO DE SIMULACION

listaEV = [];         % Lista vacia al comienzo
                      
                      
t_simulacion = 0.0;   % Reloj de simulación


pasos = 10000000;         % Numero de iteraciones del simulador


% ACCIONES DE INCIO: p.ej. definir estado, generar primeros eventos

% Se proporciona ejemplo del
% Caso cola de trabajos

t_muestra = 1; %Seg de cada muestra

% TIPOS DE EVENTOS, CADA UNO UN NUMERO DIFERENTE
SALE = 0;
LLEGA = 1;
MUESTREO = 2;

% ESTADO
N = 0;                
fifoTiempos = [];

% PARAMETROS DE SIMULACION


%1 -> Fishman-Moore
%2 -> Kobayashi
%3 -> Coveyou-McPherson
%4 -> glibc
%5 -> MMIX
generadorZ = 2;
Z = 1;

%PARAMETROS PARA M/M/4 | lambda = 10 | mu = 2.6
k = 1; % Numero de recursos
tipoX = 2;
param1X = 10;
param2X = 0;

tipoS = 2;
param1S = 2.6;
param2S = 0;

%PARAMETROS PARA M/D/1 | lambda = 3 | mu = 1 | s = 0.25
% k = 1;
% tipoX = 2;
% param1X = 3;
% param2X = 0;
% 
% tipoS = 3;
% param1S = 0.25;
% param2S = 0;

% %PARAMETROS PARA G/G/3 | X~Bernoulli(p = 0.25) | S~Bernoulli(p = 0.4)
% k = 3;
% tipoX = 4;
% param1X = 0.25;
% param2X = 0;
% 
% tipoS = 4;
% param1S = 0.4;
% param2S = 0;
% VARIABLES PARA EL CALCULO DE LOS PROMEDIOS DE INTERES
summuestrasT = 0;
muestrasT = 0;
summuestrasN = 0;
muestrasN = 0; 

% PRIMEROS EVENTOS
[Z,taux] = aleatorio(Z,tipoX,param1X,param2X,generadorZ);
listaEV = encolarEvento(listaEV, taux, LLEGA,0);

[Z,taux] = aleatorio(Z,tipoX,param1X,param2X,generadorZ);
listaEV = encolarEvento(listaEV, taux, MUESTREO,0);

for i=1:pasos
    
    [listaEV, tiempo, tipo, tllegadatarea] = sgteEvento(listaEV);
    
    % Actualizamos el tiempo 
    t_simulacion = tiempo;
    
    switch tipo 
        case LLEGA
            N = N+1;
            [Z,taux] = aleatorio(Z,tipoX,param1X,param2X,generadorZ);
            listaEV = encolarEvento(listaEV, t_simulacion + taux, LLEGA,0);
            if N<=k 
                
                [Z,taux] = aleatorio(Z,tipoS,param1S,param2S,generadorZ); % Tiempo en el recurso
                listaEV = encolarEvento(listaEV, t_simulacion + taux, SALE, t_simulacion);
            else
                fifoTiempos = pushFIFO(fifoTiempos,t_simulacion);
            end
           
            %DESCOMENTAR PARA EJECUCIÓN PASO A PASO     
            %display('LLEGADA');
            %[t_simulacion]
            %pause
        
        case SALE
            N = N-1;
            if N>=k % Otro trabajo pasa a ocupar el "procesador"
                [fifoTiempos, tllegadacola] = popFIFO(fifoTiempos); % Recuperamos el primer tiempo en cola
                [Z,taux] = aleatorio(Z,tipoS,param1S,param2S,generadorZ); % Tiempo en el recurso
                listaEV = encolarEvento(listaEV, t_simulacion + taux, SALE, tllegadacola);  
                
            end
            
        
            %DESCOMENTAR PARA EJECUCIÓN PASO A PASO     
            %display('SALE');
            %[t_simulacion, tllegadatarea, t_simulacion-tentrada]
            %pause
            summuestrasT = summuestrasT + (t_simulacion - tllegadatarea);
            muestrasT = muestrasT + 1;
            
            case MUESTREO
                muestrasN=muestrasN+1;
                summuestrasN=summuestrasN+N;
                [Z,taux] = aleatorio(Z,tipoX,param1X,param2X,generadorZ);
                 listaEV = encolarEvento(listaEV, t_simulacion + taux, MUESTREO,tllegadatarea);
    end
end

% Mostramos los promedios calculador
disp('FIN DE LA SIMULACION');
[i, summuestrasT, muestrasT]
disp('TIEMPO MEDIO');
disp(summuestrasT / muestrasT);
disp('NÚMERO MEDIO DE CLIENTES EN EL SISTEMA');
disp(summuestrasN/muestrasN);
    