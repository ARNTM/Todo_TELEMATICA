%Calculo la energía magnética de este sistema calculando la integral %del campo magnético, dentro de un volumen cilíndrico que encierre un %metro de longitud del cable coaxial
%En primer lugar hacemos el cálculo simbólico para tener
%la inductancia de forma analítica.
%Defino todas las variables como simbólicas porque así las
%necesita interpretar la función de Matlab "int"(integración)
syms pi a b d u I r1 r2 r3;
%Cálculo de la autoinductancia del cable interior
w1=2*pi*(u/2)*int(r1*((I*r1)/(2*pi*a^2))^2,r1,0,a);
L1=2*w1/(I^2)
%Cálculo de la inductancia mutua
w2=2*pi*(u/2)*int(r2*(I/(2*pi*r2))^2,r2,a,b);
L2=2*w2/(I^2)
%Cálculo de la autoinductancia del cable exterior
w3=2*pi*(u/2)*int(r3*(I*(d^2-r3^2)/(2*pi*r3*(d^2-b^2)))^2,r3,b,d);
L3=2*w3/(I^2)
%Repetir estos cálculos pero dando los valores del problema a todos
%los parámetros que aparecen, con el fin de tener el valor
%numérico de la inductancia