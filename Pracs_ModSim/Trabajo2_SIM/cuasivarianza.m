function [cuasivarianza] = cuasivarianza(nummuestras, summuestras, sumcuadrado)
    cuasivarianza = (1/(nummuestras-1))*(sumcuadrado-(((summuestras/nummuestras)^2)*nummuestras));
end