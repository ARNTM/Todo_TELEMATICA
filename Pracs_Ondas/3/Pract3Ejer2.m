%Para cerrar todas las ventanas y gr�ficas creadas anteri�rmente de forma
%autom�tica antes de ejecutarel c�digo:
clear all
close all
clc
%variables
q=10e-9;
zp=20;
x=5;
e=1/(4*pi*9*10^9);
% Vector de z para los calculos(x ser� fijo en este caso,
%para poder representar el potencial)
z=[-100:.5:100];
%Distancia al punto de observaci�n para el potencial:
R=sqrt(x^2+(z-zp).^2);
% Calculamos el potencial
pot=(q./(4*pi*e*R));
% Represantamos el potencial
plot(z,pot);
hold on;