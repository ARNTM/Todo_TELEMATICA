function PB=poisson(C,Ao)
%UNTITLED16 Summary of this function goes here
%   Detailed explanation goes here
% POISSON. Calcula la probabilidad de bloqueo (PB) de un modelo de colas de Poisson.
% Esto es, un sistema con infinitos servidores o canales de los cuales C
% son reales y el resto ficticios y sin cola de espera, al que se le ofrece
% un tráfico Ao con tiempos entre llegadas y tiempos de servicio
% exponenciales. Se considera que hay bloqueo cuando hay C o mas servidores
% ocupados.
%
% FORMATO DE LLAMADA:
% PB=poisson(C,Ao)
%
% PARAMETROS DE ENTRADA:
% C: Numero de canales. (Vector de enteros o escalar entero) []
% Ao: Trafico ofrecido. (Vector o escalar real) [E]
%
% PARAMETROS DE SALIDA:
% PB: Probabilidad de bloqueo. PB(i,j)=poisson(C(i),Ao(j). []
%
%
% Antoni J. Canos. E.P.S.Gandia - U.P.Valencia. Julio 2003.
C=C(:).';
Ao=Ao(:).';
LC=length(C); % C [1xLC]
LA=length(Ao); % A [1xLA]
for ii=1:LC
k=[0:1:C(ii)-1]; % [1xLk]
Lk=length(k);
factk=fact(k); % [1xLk]
invfactk=1./factk; % [1xLk]
% Ao [1xLA] ; k [1xLk]
Aok=(ones(Lk,1)*Ao).^((ones(LA,1)*k).'); %[LkxLA]
sumat=invfactk*Aok; %[1xLA]
PB(ii,:)=1-exp(-Ao).*sumat;
end