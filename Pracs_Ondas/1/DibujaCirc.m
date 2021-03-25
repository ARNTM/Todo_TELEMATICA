function DibujaCirc(Radio,DescX,Color)
%Para dibujar una circunferencia de radio Radio y con el centro en
% y=0 x=DescX
Xmin=DescX-Radio;
Xmax=DescX+Radio;
xCirc=Xmin:Radio/50:Xmax;
yCirc=sqrt(Radio^2-(xCirc-DescX).^2);
hold on;
plot(xCirc,yCirc,Color,'LineWidth',1.5);
plot(xCirc,-yCirc,Color,'LineWidth',1.5);