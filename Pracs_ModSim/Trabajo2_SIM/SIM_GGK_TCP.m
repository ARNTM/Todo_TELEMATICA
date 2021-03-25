%% ESQUELETO DE SIMULACION

listaEV = [];         % Lista vacia al comienzo
                                     
t_simulacion = 0.0;   % Reloj de simulación

%pasos = 10000000;         % Numero de iteraciones del simulador


% ACCIONES DE INCIO: p.ej. definir estado, generar primeros eventos

% Se proporciona ejemplo del
% Caso cola de trabajos

t_muestra = 1; %Seg de cada muestra

% TIPOS DE EVENTOS, CADA UNO UN NUMERO DIFERENTE
TX = 0;
RX = 1;

% ESTADO
N = 0;                

% PARAMETROS DE SIMULACION

%1 -> Fishman-Moore
%2 -> Kobayashi
%3 -> Coveyou-McPherson
%4 -> glibc
%5 -> MMIX
generadorZ = 2;
Z = 1;

%VALIDACION PROFESOR
calidadobjetivo = 0.95; % Suele estar entre el 90% y el 99%
tolrelativa = 0.01; % Suele estar entre el 1% y el 10%
TEST = 100; % Cada cuantas muestras comprobamos calidad
H = 50000;
D = 10;

tipoX = 2;
param1X = 1;
param2X = 0;

tipoE = 2;
param1E = 0.5;
param2E = 0;

Tmax = 1.5;

%ESCENARIO 1
% calidadobjetivo = 0.95; % Suele estar entre el 90% y el 99%
% tolrelativa = 0.01; % Suele estar entre el 1% y el 10%
% TEST = 100; % Cada cuantas muestras comprobamos calidad
% H = 50000;
% D = 10;
% 
% tipoX = 4;
% param1X = 0.3;
% param2X = 0;
% 
% tipoE = 1;
% param1E = 0;
% param2E = 1;
% 
% Tmax = 0.8;

%ESCENARIO 2
% calidadobjetivo = 0.99; % Suele estar entre el 90% y el 99%
% tolrelativa = 0.01; % Suele estar entre el 1% y el 10%
% TEST = 100; % Cada cuantas muestras comprobamos calidad
% H = 50000;
% D = 100;
% 
% tipoX = 2;
% param1X = 100;
% param2X = 0;
% 
% tipoE = 1;
% param1E = 0;
% param2E = 1;
% 
% Tmax = 0.5;


summuestrasT = 0;
muestrasT = 0;
summuestrasTcuadrado = 0;

nummuestrasT_bloque = 0;
summuestrasT_bloque = 0;

nt = 0;

numpaquete = 0; % Parte del estado
numpaquetes_entregados = 0; % Parte del estado

n_paquetes = []; % Parte del estado
t_paquetes = []; % Parte del estado


% PRIMEROS EVENTOS
[Z,taux] = aleatorio(Z,tipoX,param1X,param2X,generadorZ);
listaEV = encolarEvento(listaEV, taux, TX, taux, numpaquete,0);
numpaquete = numpaquete + 1;

pasos = 0;
acabo = false;

while true
    
    pasos = pasos + 1;
    
    [listaEV, tiempo, tipo, tgeneracionpaquete, numeropaqueteenviado, taire] = sgteEvento(listaEV);
    
    % Actualizamos el tiempo 
    t_simulacion = tiempo;
    
    switch tipo 
        case TX
            tiempodeenvio = 0; % Parte del estado
            [Z,taux] = aleatorio(Z,tipoE,param1E,param2E,generadorZ); % Tiempo de envio
            tiempodeenvio = tiempodeenvio + taux;
            
            while taux > Tmax
                tiempodeenvio = tiempodeenvio - taux;
                tiempodeenvio = tiempodeenvio + Tmax;
                [Z,taux] = aleatorio(Z,tipoE,param1E,param2E,generadorZ); % Tiempo de envio
                tiempodeenvio = tiempodeenvio + taux;
            end
            
            listaEV = encolarEvento(listaEV, t_simulacion + tiempodeenvio, RX, tgeneracionpaquete, numeropaqueteenviado, tiempodeenvio); 

            [Z,tsiguientetx] = aleatorio(Z,tipoX,param1X,param2X,generadorZ);
            listaEV = encolarEvento(listaEV , t_simulacion + tsiguientetx, TX , t_simulacion  + tsiguientetx, numpaquete , 0);
            numpaquete = numpaquete + 1;

        case RX
                n_paquetes = [n_paquetes, numeropaqueteenviado];
                t_paquetes = [t_paquetes, tgeneracionpaquete];

                if numpaquetes_entregados == numeropaqueteenviado
                    indice = find (n_paquetes == numeropaqueteenviado); 
                    while ~isempty(indice)
                    nt = nt + 1;
                    tiempoairepaquete_num = t_paquetes(indice);
                        if nt > H
                            nummuestrasT_bloque = nummuestrasT_bloque + 1;
                            if nummuestrasT_bloque == D
                                
                                summuestrasT = summuestrasT + (t_simulacion - tiempoairepaquete_num);
                                muestrasT = muestrasT + 1;
                                summuestrasTcuadrado = summuestrasTcuadrado + (t_simulacion - tiempoairepaquete_num)^2;
                                nummuestrasT_bloque = 0;
                                summuestrasT_bloque = 0;

                                if ~mod(muestrasT,TEST)
                                    [unomenosalfa, intizqda, intderecha] = calidad(tolrelativa, muestrasT, summuestrasT, summuestrasTcuadrado);
                                    if(unomenosalfa >= calidadobjetivo)
                                        acabo = true;
                                        break;
                                    end
                                end
                            end  
                        end
                    n_paquetes(indice) = [];
                    t_paquetes(indice) = [];
                    numpaquetes_entregados = numpaquetes_entregados + 1;
                    indice = find (n_paquetes == numpaquetes_entregados);
                    end
                    
                    if acabo
                        break;
                    end
                    
                end         
    end
end

% Mostramos los promedios calculados
disp('####################');
disp('FIN DE LA SIMULACION');
disp('####################');
disp(['R en [ ',num2str(intizqda),' , ',num2str(intderecha),' ] con calidad ',num2str(unomenosalfa)]);
disp(['PASOS -> ',num2str(pasos)]);
disp(['TIEMPO SIMULADO -> ',num2str(t_simulacion)]);

    