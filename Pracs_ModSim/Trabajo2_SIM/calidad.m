function [unomenosalfa, intizqda, intderecha] = calidad(tolrelativa, nummuestras, summuestras, sumcuadrado)
    mediaaritmetica = summuestras/nummuestras;
    S = cuasivarianza(nummuestras, summuestras, sumcuadrado);
    tolabsoluta = tolrelativa * mediaaritmetica;
    z = tolabsoluta/(sqrt(S/nummuestras));
    unomenosalfa = 1 - (1-normcdf(z))*2;
    intizqda = mediaaritmetica - tolabsoluta;
    intderecha = mediaaritmetica + tolabsoluta;
end