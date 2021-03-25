%Para cerrar todas las ventanas y gr�ficas creadas anteri�rmente de forma
%autom�tica antes de ejecutarel c�digo:
clear all
close all
clc
%variables:
q=10*10^(-9);
d=10;
e=1/(4*pi*9*10^9);
%matriz de valores de x y z para los c�lculos:
[z,x]=meshgrid(-40:40,-40:40);
%distancias al punto de observaci�n del potencial:
R1=sqrt(x.^2+(z-d).^2);
R2=sqrt(x.^2+(z+d).^2);
%C�lculo del potencial:
pot = (q./(4*pi*e*R1))-(q./(4*pi*e*R2));
%representaci�n en 2d con ejes z y x de la funci�n "pot", tomando
%15 valores negativos y 15 positivos:
contour(z,x,pot,[-15:15])
hold on;
%generamos los vectores del gradiente del potencial:
[pz,px] = gradient(pot,.2,.2) 
%Representamos con flechas (funci�n quiver) el -gradiente de potencial, es
%decir las flechas de campo el�ctrico:
quiver(z,x,-pz,-px,'marker','.','markersize',0.1)
axis image
%(En la funci�n quiver, ponemos la propiedad 'marker' con el valor '.', para
%que se puedan ver las lineas de campo el�ctrico, ya que al ser estas
%perpend�culares al plano de la pantalla, no se ven representadas, as� que las
%marcamos con puntos
