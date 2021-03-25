[x,y] = meshgrid(-2:.2:2,-1:.15:1); %generamos una matriz con un rango de valores para la representaci�n gr�fica de x e y
V=x.* exp(-x.^2 - y.^2); %Funci�n potencial de ejemplo
[px,py] = gradient(V,.2,.15); %generamos el gradiente de V
contour(x,y,V), hold on
quiver(x,y,-px,-py), hold off, axis image
title('Campo Electrico y Potencial')
xlabel('Eje X','FontSize',12);
ylabel('Eje Y','FontSize',12);
colorbar
