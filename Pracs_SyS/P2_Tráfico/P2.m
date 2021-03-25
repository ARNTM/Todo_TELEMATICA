%%
%CUESTION 2
clear all
close all
lambda=0.3;
t=linspace(1,20,100);
f_t=lambda*exp(-lambda*t);
F_t=1-exp(-lambda*t);
plot(t,f_t)
figure
plot(t,F_t)
pause
%%
%CUESTION 3b
lambda=0.3;
T=20000;
tau,ti=exp_source(lamda,T)
%%
%CUESTION 4
hist(tau,51)
%%
%CUESTION 5
T1=20000;
T2=200;
tau1,ti=exp_source(lamda,T1);
tau2,ti=exp_source(lamda,T1);
tau3,ti=exp_source(lamda,T2);
tau4,ti=exp_source(lamda,T2);
lambda1=1/mean(tau1)
lambda2=1/mean(tau2)
lambda3=1/mean(tau3)
lambda4=1/mean(tau4)
%%
%CUESTION 6
tt=10;centros=[tt/2:tt:T];
m=hist(ti,centros);
k=[0:1:max(m)];
contadas=hist(m,k);
pk=contadas/sum(contadas);
lambda_prima=k*pk.'%que significa el .' final?
%%
%CUESTION 7
for ii=1:length(k)
pkfitted(ii)=lambda_prima^k(ii)*exp(-lambda_prima)/factorial(k(ii));
end
bar(k,pk); hold on;
plot(k,pkfitted,'r'); plot(k,pkfitted,'.r');
grid; hold off
%%
%CUESTION 8
clear all
T=50;
lambda=0.3;
mu=0.15;
tau,ti=exp_source(lamda,T);
s=exp_service(mu,length(ti));
to=ti+s; to=sort(to);
%%
%CUESTION 9
%gráfica de tiempos de inicio y fin:
stem(ti,ones(size(ti)),'.b'); hold on
stem(to,-ones(size(to)),'.r');
grid; hold off;
%%
%CUESTION 10
tiempos,Ainstant=Ainstant(ti,to)
%%
%CUESTION 11
taus=diff(tiempos);
Ao_aprox=Ainstant(1:end-1)*taus.'/tiempos(end)
Ao=lambda/mu
%%
%CUESTION 12
T1=50;
T2=20000:
tau,ti1=exp_source(lamda,T1);
tau,ti2=exp_source(lamda,T1);
tau,ti3=exp_source(lamda,T2);
tau,ti4=exp_source(lamda,T2);

s1=exp_service(mu,length(ti1));
s2=exp_service(mu,length(ti2));
s3=exp_service(mu,length(ti3));
s4=exp_service(mu,length(ti4));

to1=ti1+s1; to1=sort(to1);
to2=ti2+s2; to2=sort(to2);
to3=ti3+s3; to3=sort(to3);
to4=ti4+s4; to4=sort(to4);

tiempos1,Ainstant1=Ainstant(ti1,to1);
tiempos2,Ainstant2=Ainstant(ti2,to2);
tiempos3,Ainstant3=Ainstant(ti3,to3);
tiempos4,Ainstant4=Ainstant(ti4,to4);

taus1=diff(tiempos1);
taus2=diff(tiempos2);
taus3=diff(tiempos3);
taus4=diff(tiempos4);

Ao_aprox1=Ainstant1(1:end-1)*taus1.'/tiempos1(end)
Ao_aprox2=Ainstant2(1:end-1)*taus2.'/tiempos2(end)
Ao_aprox3=Ainstant3(1:end-1)*taus3.'/tiempos3(end)
Ao_aprox4=Ainstant4(1:end-1)*taus4.'/tiempos4(end)

%%
%CUESTION 14
%ver funcion erlangb y erlangbinv
%%
%CUESTION 15
Pb=[1.5 2.5 7.5 15]/100;
for n=1:10,
for p=1:length(Pb),
E(n,p)=findrhob(n,Pb(p));
end
end
E
%%
%CUESTION 17
%ver funcion erlangc y erlangcinv
%%
%CUESTION 18
Pb=[1.5 2.5 7.5 15]/100;
for n=1:10,
for p=1:length(Pb),
E(n,p)=findrhoc(n,Pb(p));
end
end
E