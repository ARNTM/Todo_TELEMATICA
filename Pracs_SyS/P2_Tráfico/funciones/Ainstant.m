function [tiempos,Ainstant]=Ainstant(ti,to)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
% AINSTANT. Calcula y representa el trafico instantaneo (numero de organos
% ocupados) en funcion del tiempo, dados los instantes de llegada
% y finalizacion de las llamadas.
%
% FORMATO DE LLAMADA:
% [tiempos,Ainstant]=Ainstant(ti,to)
%
% PARAMETROS DE ENTRADA:
% ti: Instantes de llegada [seg]
% to: Instantes de salida [seg]
%
% PARAMETROS DE SALIDA:
% tiempos: Instantes iniciales de periodos de tiempo con trafico
% instantaneo contante [seg]
% Ainstant: Valores de trafico instantaneo [E]
%
tiempoaux=[ti,to];
signosaux=[ones(size(ti)),-ones(size(to))];
[tiempos,indexes]=sort(tiempoaux);
signos=signosaux(indexes);
Ainstant=cumsum(signos);
tiempos=[0 tiempos]; % Origen de tiempos en t=0
Ainstant=[0 Ainstant]; % Se considera que antes de llegar la primera llamada, el trafico es cero.
figure
stairs(tiempos,Ainstant);
grid;
xlabel ('Tiempo (s)');
ylabel ('Trafico (E)')
title ('Intensidad de Trafico Instantanea');

