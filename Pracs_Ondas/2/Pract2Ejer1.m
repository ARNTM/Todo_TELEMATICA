%El valor introducido por teclado debe ser el nombre del fichero
%Datos del problema
I=1e-3;
a=5e-3;
b=4*a;
d=6*a;
%u es la constante de permeabilidad magnética en el vacío
u=4*pi*10^(-7)
%densidad de corriente dentro del vivo
p=I/(pi*a^2);
%densidad de corriente en la malla
q=-I/(pi*(d^2-b^2));
%se definen dos rangos de valores para representar los valores del %radio, variable que mide las distancias desde el centro del coaxial %para las distintas regiones
r1=linspace(0,a,20); %para el interior del vivo
r2=linspace(a,b,20); %para la zona del dieléctrico
r3=linspace(b,d,20); %para la zona de la malla
%H1 se utiliza para representar los valores dentro del vivo, H2 para %el dieléctrico
%y H3 para los valores en la malla
H1=p*r1/2;%P es la densidad de carga declarada arriba, en realidad H=(I*ro)/(2*pi*a^2)
H2=I./(2*pi*r2);
H3=-q*(d^2-r3.^2)./(2*r3);
%Visualizamos todos los tramos
plot(r1,H1,'b',r2,H2,'r',r3,H3,'g');
grid;