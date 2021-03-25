function [tau,ti] = exp_source(lambda,T)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% EXP_SOURCE. Genera tiempos aleatorios de llegadas de llamadas que
% siguen una funcion de distribucion exponencial negativa
% y obtiene los intantes de las llegadas en un tiempo de
% observacion.
%
% FORMATO DE LLAMADA:
% s=exp_source(lambda,T)
%
% PARAMETROS DE ENTRADA:
% lambda: Tasa de llegadas o velocidad media de llamadas [1/seg]
% T: Tiempo de observacion de las llegadas [seg]
%
% PARAMETROS DE SALIDA:
% tau: Tiempos entre llegadas [seg]
% ti: Instantes de llegada [seg]
%
%
% Antoni J. Canos. E.P.S.Gandia - U.P.Valencia. Octubre 2002.
format long
tn=0;
ii=0;
while tn<=T
ii=ii+1;
F=rand(1,1);
tau(ii)=-log(1-F)/lambda;
tn=tn+tau(ii);
ti(ii)=tn;
end
tau=tau(1:end-1); % Tiempos entre instantes de llegada
ti=ti(1:end-1); % Instantes de llegada (t_input)

