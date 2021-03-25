%Para cerrar todas las ventanas y gráficas creadas anteriórmente de forma
%automática antes de ejecutarel código:
clear all
close all
clc
%variables
q=10e-9;
zp=20;
x=5;
e=1/(4*pi*9*10^9);
% Vector de z para los calculos(x será fijo en este caso,
%para poder representar el potencial)
z=[-100:.5:100];
%Distancias de ambos puntos (desde -q en interior del plano y +q exterior)
%desde el punto de observación:
R=sqrt(x.^2+(z-zp).^2); %distancia a +q
Rp=sqrt(x.^2+(z+zp).^2);%distancia a -q
% Calculamos el potencial
pot_BIS=(q./(4*pi*e*R))-(q./(4*pi*e*Rp));
% Represantamos el potencial
plot(z,pot_BIS);
hold on;