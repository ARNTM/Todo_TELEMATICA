%Para cerrar todas las ventanas y gráficas creadas anteriórmente de forma
%automática antes de ejecutarel código:
clear all
close all
clc
%variables
q=10e-9;
zp=20;
x=0.1;
e=1/(4*pi*9*10^9);
a=60;
% Vector de z para los calculos(x será fijo en este caso,
%para poder representar el potencial)
z=[-100:.5:100];
%CALCULO DEL POTENCIAL TOTAL:
R=sqrt(x.^2+(z-zp).^2);
Rp=sqrt(x.^2+(z+zp).^2);
% Calculamos el potencial del conjunto de imágenes básico
pot_BIS=(q./(4*pi*e*R))-(q./(4*pi*e*Rp));
% Calculamos el potencial total
pot=0;
for m=-5:5
%pareja de cargas hacia la derecha del BIS:
R1=sqrt(x.^2+(z-(zp+2*a*m)).^2);%carga de la der.
R1P=sqrt(x.^2+(z+(zp+2*a*m)).^2);%carga de la izq.
%pareja de cargas hacia la izquierda del BIS:
R2=sqrt(x.^2+(z-(zp-2*a*m)).^2);%carga de la der.
R2P=sqrt(x.^2+(z+(zp-2*a*m)).^2);%carga de la izq.
%sumamos pareja de cargas a izq e der del BIS y acumulamos:
pot=pot+((q./(4*pi*e*R1))-(q./(4*pi*e*R1P)))+((q./(4*pi*e*R2))-(q./(4*pi*e*R2P)));
end
pot_T=pot_BIS+pot;
% Represantamos el potencial
plot(z,pot_T);
hold on;