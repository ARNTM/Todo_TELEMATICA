function pe = ProbErrorBit(R, p_tx_W) 
%datos de partida
Lcanal = 70; %perdidas del canal (en dB)
K = 1.38e-23; %constante de Boltzmann
T = 295; %temperatura de ruido en la antena
F = 10; %figura de ruido del receptor (en dB)
g = 10; %ganancia del transmisor y del receptor (en dB)
d = 900; %distancia en metros
p_rx = p_tx_W*10^(g/10)*10^(g/10)*10^(-Lcanal/10)/d^2; %potencia recibida
E = p_rx / R; %energia recibida por bit
N_o = K*(T+T*(10^(F/10)-1)); %densidad espectral de ruido

pe = 0.5*erfc(sqrt(E/N_o));