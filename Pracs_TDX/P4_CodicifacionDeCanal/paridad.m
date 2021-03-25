function [valor, bloquep] = paridad(bloque)
% Calcula la paridad de un bloque y devuelve 1 si el numero de ‘1’s es
% impar o 0 si es par. Devuelve también el bloque con un bit añadido al
% final para que el numero de unos sea par
    if mod(length(strfind(bloque,'1')),2) ~= 0
        bloquep = strcat(bloque,'1');
        valor = 1;
    else
        bloquep = strcat(bloque,'0');
        valor = 0;
    end
end