function y = tco_wgn(M,N,eta,Fs)
%TCO_WGN Genera ruido blanco gaussiano.
%   Y = tco_wgn(M,N,ETA,Fs) genera una matriz M-por-N de ruido blanco gaussiano de
%   densidad espectral de potencia ETA, en la banda de frecuencias
%
%   Adaptada de wgn() del Communication Toolbox de Matlab
%   Rev: X-23-05-07 (compatible con Matlab 6.5)

% --- Initial checks
Pn=10*log10(eta*Fs/2);

eta*Fs/2


y=tco_wgn_interno(M,N,Pn);