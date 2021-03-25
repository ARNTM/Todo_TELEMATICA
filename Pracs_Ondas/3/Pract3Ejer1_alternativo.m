q=10*10^(-6);
d=10;
[z,x]=meshgrid(-30:0.3:30,-30:0.3:30);
e=1/(4*pi*9*10^9);
R1=sqrt(x.^2+(z-d).^2);
R2=sqrt(x.^2+(z+d).^2);
pot = q./(4*pi*e*R1)-(q./(4*pi*e*R2));
contour(z,x,pot,1000) %representación en 2d  con ejes x e y de la función "pot", tomando 5 valores