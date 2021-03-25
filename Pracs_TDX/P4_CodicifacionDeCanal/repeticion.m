function [nuevacadena] = repeticion(cadena, R)
% Repite R veces cada bit del flujo y lo devuelve en nuevo flujo end
    nuevacadena='';
    for i=1:length(cadena)
        nuevacadena=strcat(nuevacadena,repelem(cadena(i),R));
    end
end
