%%
%1.DISTORSION LINEAL
%%
clear all
close all
T=2;
V1=1.2;V2=-1/3;V3=1/5;
f1=2;f2=3*f1;f3=5*f1;
Fs=1000;
delta_t=1/Fs;
T_obs=1;
t=0:delta_t:T_obs;
x1=V1*cos(2*pi*f1*t);
x2=V2*cos(2*pi*f2*t);
x3=V3*cos(2*pi*f3*t);
%%
%%TRABAJO PREVIO
% Calculo de la FFT de una onda senoidal
nfft=1024;%el numero de puntos de la fft
Y1=fft(x1,nfft);% tomar la FFT, y llenando con ceros, de manera que el
%largo de la FFT sea nfft
Y2=fft(x2,nfft);
Y3=fft(x3,nfft);
Y1 = Y1(1:nfft/2); % la FFT es simétrica, así que se tira la mitad
Y2 = Y2(1:nfft/2);
Y3 = Y3(1:nfft/2);
my1 = abs(Y1).^2;% tomar la potencia espectral, módulo alcuadrado de la FFT
my2 = abs(Y2).^2;
my3 = abs(Y3).^2;
f = (0:nfft/2-1)*Fs/nfft; %construccion del vector de frecuencias
% Genera los plots, titulos y nombres.
figure(1);
plot(t,x3);
title('señal');
xlabel('Tiempo (s)');
ylabel('Amplitud ')
figure(2);
plot(f,my3);
title('Espectro de potencia');
xlabel('Frecuencia (Hz)');
ylabel('Potencia');
%%
%funcion H(f)
k0=1
k1=0,3
t0=1
t1=1,7
H1=k0*exp(-j*2*pi*f1*t0)+k1*exp(-j*2*pi*f1*t1)
H2=k0*exp(-j*2*pi*f2*t0)+k1*exp(-j*2*pi*f2*t1)
H3=k0*exp(-j*2*pi*f3*t0)+k1*exp(-j*2*pi*f3*t1)
%% 1.1
figure
plot(t,x1,'r')
hold on
plot(t,x2,'g')
plot(t,x3,'b')
plot(t,x1+x2+x3,'k')
plot(t,x1+0.6*x2+0.4*x3,'k--')
legend('x1','x2','x3','x1+x2+x3','x1+0.6*x2+0.4*x3')
title('Distorsión amplitud')

%% 1.2
figure
plot(t,x1,'r')
hold on
plot(t,x2,'g')
plot(t,x3,'b')
plot(t,x1+x2+x3,'k')
x2=V2*cos(2*pi*f2*t-3/4*pi);
x3=V3*cos(2*pi*f3*t-5/4*pi);
plot(t,x1+x2+x3,'k--')
legend('x1','x2','x3','x1+x2+x3','x1(0º)+x2(-3/4*pi)+x3(-5/4*pi)')
title('Distorsión fase')

%% 1.3
figure
plot(t,x1,'r')
hold on
plot(t,x2,'g')
plot(t,x3,'b')
plot(t,x1+x2+x3,'k')
x2=V2*cos(2*pi*f2*t-3/4*pi);
x3=V3*cos(2*pi*f3*t-5/4*pi);
plot(t,x1+0.6*x2+0.4*x3,'k--')
legend('x1','x2','x3','x1+x2+x3','x1(0º)+0.6*x2(-3/4*pi)+0.4*x3(-5/4*pi)')
title('Distorsión fase y amplitud')

%% 1.4
f=0:0.1:10;
K0=1;K1=0.3;t0=1;t1=1.7;
H=K0*exp(-j*2*pi.*f*t0)+K1*exp(-j*2*pi.*f*t1);
figure
subplot(2,1,1)
plot(f,abs(H))
subplot(2,1,2)
plot(f,angle(H))
[abs(H(f1*10)) abs(H(f2*10)) abs(H(f3*10))
angle(H(f1*10)) angle(H(f2*10)) angle(H(f3*10))]
x1=V1*cos(2*pi*f1*t);
x2=V2*cos(2*pi*f2*t);
x3=V3*cos(2*pi*f3*t);
figure
plot(t,x1,'r')
hold on
plot(t,x2,'g')
plot(t,x3,'b')
plot(t,x1+x2+x3,'k')
x1=abs(H(f1*10+1))*V1*cos(2*pi*f1*t+angle(f1*10));
% Aqui: +1 y multiplicación
x2=abs(H(f2*10+1))*V2*cos(2*pi*f2*t+angle(f2*10));
x3=abs(H(f3*10+1))*V3*cos(2*pi*f3*t+angle(f3*10));
plot(t,x1+x2+x3,'k--')
legend('x1','x2','x3','x1+x2+x3','x*H(f)')
title('Distorsión amplitud de la funcion H')
%%
%2.DISTORSION NO LINEAL
%trabajo previo
k1=10
k2=4.3
k3=-5
y1=k1*x1+k2*x1.^2+k3*x1.^3
y2=k1*(x1+x2)+k2*(x1+x2).^2+k3*(x1+x2).^3
figure
plot(t,y1,'r')
hold on
plot(t,y2,'g')
%% 2.1
% 2.1 Exercise 5: Distortion of a tone
clear all
close all
k1=10;k2=4.3;k3=-5;
t=0:0.001:0.4;
V1=1.5;f1=20;
x1=V1*cos(2*pi*f1*t);
f=0:(1/(max(t))):(1/(t(2)-t(1)));
figure
subplot (2,1,1)
plot(t,x1)
xlabel('tiempo');ylabel('amplitud')
subplot(2,1,2)
stem(f,abs(fft(x1)))
xlim([0 100])
xlabel('frecuencia');ylabel('amplitud')
y=k1*x1+k2*x1.^2+k3*x1.^3;
subplot (2,1,1)
hold on
plot(t,y,'k')
xlabel('tiempo');ylabel('amplitud')
subplot(2,1,2)
hold on
stem(f,abs(fft(y)),'k')
xlim([0 100])
xlabel('frecuencia');ylabel('amplitud')

%% 2.2
% 2.2 Exercise 6: Distortion of Two-tones
V1=1.3;f1=5;
V2=1/2;f2=5*f1;
%x3 es el x1 de los apuntes. Así no sobreescribimos las x
x3=V1*cos(2*pi*f1*t);
x2=V2*cos(2*pi*f2*t);
x1=x2+x3;
f=0:(1/(max(t))):(1/(t(2)-t(1)));
figure
subplot (2,1,1)
plot(t,x1)
xlabel('tiempo');ylabel('amplitud')
subplot(2,1,2)
stem(f,abs(fft(x1)))
xlim([0 100])
xlabel('frecuencia');ylabel('amplitud')
y=k1*x1+k2*x1.^2+k3*x1.^3;
subplot (2,1,1)
hold on
plot(t,y,'k')
xlabel('tiempo');ylabel('amplitud')
subplot(2,1,2)
hold on
stem(f,abs(fft(y)),'k')
xlim([0 100])
xlabel('frecuencia');ylabel('amplitud')

%%
% 3.- Noise
clear all
close all
T=0.4;
Fs=1000;
t=0:1/Fs:T;
V1=1.2;V2=1.5;f1=5;f2=5*f1;
x1=V1*cos(2*pi*f1*t);
x2=V2*cos(2*pi*f2*t);
figure
subplot(2,1,1)
plot(t,x1+x2);
xlabel('tiempo');ylabel('amplitud')
subplot(2,1,2)
f=0:(1/(max(t))):(1/(t(2)-t(1)));
stem(f,abs(fft(x1+x2)))
xlabel('frecuencia');ylabel('amplitud')
xlim([0 100])
%%
x=x1+x2;
eta=.1;
n=tco_wgn(size(x,1),size(x,2),eta,Fs);
y=x+n;
figure(1)
subplot(2,1,1)
plot(t,y);
xlabel('tiempo');ylabel('amplitud')
subplot(2,1,2)
f=0:(1/(max(t))):(1/(t(2)-t(1)));
stem(f,abs(fft(y)))
xlabel('frecuencia');ylabel('amplitud')
xlim([0 100])
% Comprobación ruido
%En tiempo
Px=sum(x.^2)
Py=sum(y.^2)
Pn=Py-Px
%En frecuencia
Px=mean(abs(fft(x)).^2)
Py=mean(abs(fft(y)).^2)
Pn=Py-Px
eta_comp=(2*Pn/Fs)
input('prompt')
