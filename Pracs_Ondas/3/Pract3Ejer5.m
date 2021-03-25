%Para cerrar todas las ventanas y gráficas creadas anteriórmente de forma
%automática antes de ejecutarel código:
clear all
close all
clc
%variables:
q=10e-9;
zp=20;
a=60;
x=0.1;
z=25;
e=1/(4*pi*9*10^9);
%Distancias hasta el punto de observación:
R=sqrt(x.^2+(z-zp).^2);
Rp=sqrt(x.^2+(z+zp).^2);
% Calculamos el potencial del conjunto de imagnes basico
pot_BIS=(q./(4*pi*e*R))-(q./(4*pi*e*Rp));
% Calculamos el potencial para las imagenes
m=1:40; %m es un vector
%VECTORES DE DISTANCIAS (40 DISTANCIAS AL PUNTO DE OBSERVACIÓN)
%pareja de cargas hacia la derecha del BIS:
R1=sqrt(x.^2+(z-(zp+2*a*m)).^2);%carga de la der.
R1p=sqrt(x.^2+(z+(zp+2*a*m)).^2);%carga de la izq.
%pareja de cargas hacia la izquierda del BIS:
R2=sqrt(x.^2+(z-(zp-2*a*m)).^2);%carga de la der.
R2p=sqrt(x.^2+(z+(zp-2*a*m)).^2);%carga de la izq.
%vector con cada uno de los 40 potenciales diferentes:
pot=((q./(4*pi*e*R1))-(q./(4*pi*e*R1p)))+((q./(4*pi*e*R2))-(q./(4*pi*e*R2p)));
pot_T=pot_BIS+pot;
% Represantamos los 40 potenciales según m
plot(m,pot_T);
grid on;