function s = exp_service(mu,N)
% EXP_SERVICE. Genera tiempos aleatorios de servicio que siguen
% una funcion de distribucion exponencial negativa.
%
% FORMATO DE LLAMADA:
% s=exp_service(mu,N)
%
% PARAMETROS DE ENTRADA:
% mu: Tasa o velocidad media de servicio [1/seg]
% N: Numero de llamadas []
%
% PARAMETROS DE SALIDA:
% s: Tiempos de servicio o duracion de las llamadas [seg]
%
%
% Antoni J. Canos. E.P.S.Gandia - U.P.Valencia. Octubre 2002.
format long
F=rand(1,N);
s=-log(1-F)/mu;

