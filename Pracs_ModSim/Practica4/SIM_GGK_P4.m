%% ESQUELETO DE SIMULACION

listaEV = [];         % Lista vacia al comienzo
                                     
t_simulacion = 0.0;   % Reloj de simulación

%pasos = 10000000;         % Numero de iteraciones del simulador


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

%PARAMETROS PARA M/M/5
% calidadobjetivo = 0.9; % Suele estar entre el 90% y el 99%
% tolrelativa = 0.1; % Suele estar entre el 1% y el 10%
% TEST = 1000; % Cada cuantas muestras comprobamos calidad
% H = 10000;
% D = 20;
% k = 5; % Numero de recursos
% tipoX = 2;
% param1X = 100;
% param2X = 0;
% 
% tipoS = 2;
% param1S = 21;
% param2S = 0;

%PARAMETROS PARA M/M/10
calidadobjetivo = 0.95; % Suele estar entre el 90% y el 99%
tolrelativa = 0.01; % Suele estar entre el 1% y el 10%
TEST = 1000; % Cada cuantas muestras comprobamos calidad
H = 100000;
D = 50;
k = 10; % Numero de recursos
tipoX = 2;
param1X = 100;
param2X = 0;

tipoS = 2;
param1S = 15;
param2S = 0;

summuestrasT = 0;
muestrasT = 0;
summuestrasTcuadrado = 0;

nummuestrasT_bloque = 0;
summuestrasT_bloque = 0;

nt = 0;

summuestrasN = 0;
muestrasN = 0; 

eventos = 0;
% PRIMEROS EVENTOS
[Z,taux] = aleatorio(Z,tipoX,param1X,param2X,generadorZ);
listaEV = encolarEvento(listaEV, taux, LLEGA,0);

[Z,taux] = aleatorio(Z,tipoX,param1X,param2X,generadorZ);
listaEV = encolarEvento(listaEV, taux, MUESTREO,0);

pasos = 0;

while true
    
    pasos = pasos + 1;
    
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
            nt = nt + 1;
            if nt > H
%                 summuestrasT_bloque = summuestrasT_bloque + (t_simulacion - tllegadatarea);
                nummuestrasT_bloque = nummuestrasT_bloque + 1;
                if nummuestrasT_bloque == D
                    summuestrasT = summuestrasT + (t_simulacion - tllegadatarea);
                    muestrasT = muestrasT + 1;
                    summuestrasTcuadrado = summuestrasTcuadrado + (t_simulacion - tllegadatarea)^2;
                    nummuestrasT_bloque = 0;
                    summuestrasT_bloque = 0;
                    
                    if ~mod(muestrasT,TEST)
                        [unomenosalfa, intizqda, intderecha] = calidad(tolrelativa, muestrasT, summuestrasT, summuestrasTcuadrado);
                        if(unomenosalfa >= calidadobjetivo) 
                            break;
                        end
                    end
                end  
            end
            
            case MUESTREO
                muestrasN=muestrasN+1;
                summuestrasN=summuestrasN+N;
                [Z,taux] = aleatorio(Z,tipoX,param1X,param2X,generadorZ);
                 listaEV = encolarEvento(listaEV, t_simulacion + taux, MUESTREO,tllegadatarea);
    end
    
end

% Mostramos los promedios calculador
disp('FIN DE LA SIMULACION');
disp(strcat('PASOS -> ',num2str(pasos)));
disp(strcat('NUMERO DE MUESTRAS -> ',num2str(muestrasT)));
disp(strcat('SUMATORIO DE MUESTRAS -> ',num2str(summuestrasT)));
disp(strcat('SUMATORIO DEL CUADRADO DE MUESTRAS -> ',num2str(summuestrasTcuadrado)));
disp(strcat('TIEMPO MEDIO -> ',num2str(summuestrasT / muestrasT)));
disp(strcat('NÚMERO MEDIO DE CLIENTES EN EL SISTEMA -> ',num2str(summuestrasN/muestrasN)));
disp(strcat('P(',num2str(intizqda),'<= T <=',num2str(intderecha),')=',num2str(unomenosalfa)));

    