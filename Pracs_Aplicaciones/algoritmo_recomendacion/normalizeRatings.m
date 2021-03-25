function [Ynorm, Ymean] = normalizeRatings(Y, R)
%NORMALIZERATINGS Preprocesa los datos restando la puntuación media de
%todas las peliculas (todas las filas)
%   [Ynorm, Ymean] = NORMALIZERATINGS(Y, R) Y normalizada de forma que cada
%   pelicula tiene una puntuacion media 0 y devuelve la punutacion media en
%   Ymean.
%

[m, n] = size(Y);
Ymean = zeros(m, 1);
Ynorm = zeros(size(Y));
for i = 1:m
    idx = find(R(i, :) == 1);
    Ymean(i) = mean(Y(i, idx));
    Ynorm(i, idx) = Y(i, idx) - Ymean(i);
end

end
