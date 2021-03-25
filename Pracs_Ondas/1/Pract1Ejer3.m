%El valor introducido por teclado debe ser el nombre del fichero
%Valor del radio de la esfera (m)
A=5e-3;
%Valor de la densidad de carga volum�trica (C/m^3)
p=1e-9;
%defino la constante diel�ctrica "e" en el vac�o y le asigno su %valor
e=1/(4*pi*9*10^9);
%se definen dos rangos de valores para representar los valores
%dentro y fuera de la esfera cargada. Con "r1" y "r2" se
%representa a la variable radial, medida desde el centro de la esfera
%utilizamos el comando linspace para hacer el barrido en la coordenada
%radial.
r1=linspace(0,A,20);
r2=linspace(A,5*A,20);
%"E1" se utiliza para representar los valores dentro, mientras %"E2" para los valores fuera, del campo el�ctrico.
E1=p*r1/(3*e);
E2=p*A^3./(3*e*r2.^2);
%Finalmente se representan simult�neamente los resultados obtenidos %para el campo el�ctrico tanto dentro como fuera de la esfera
plot(r1,E1,'b',r2,E2,'b');
grid;
%Podemos ver que la gr�fica es continua en la superficie de la esfera ya
%que adem�s de que la permitividad del interior y exterior de la esfera es
%la misma, no hay densidad de carga superficial