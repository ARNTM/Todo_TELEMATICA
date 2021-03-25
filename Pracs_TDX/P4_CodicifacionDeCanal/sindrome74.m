function [sindromedecimal] = sindrome74(bloque)
    b1 = strcat(bloque(1),bloque(3),bloque(5),bloque(7));
    b2 = strcat(bloque(2),bloque(3),bloque(6),bloque(7));
    b3 = strcat(bloque(4),bloque(5),bloque(6),bloque(7));
    
    if mod(length(strfind(b1,'1')),2) ~= 0
        c0 = '1';
    else
        c0 = '0';
    end
    
    if mod(length(strfind(b2,'1')),2) ~= 0
        c1 = '1';
    else
        c1 = '0';
    end
    
    if mod(length(strfind(b3,'1')),2) ~= 0
        c2 = '1';
    else
        c2 = '0';
    end
    
    sindromebinario = [str2double(c0) str2double(c1) str2double(c2)];
    sindromedecimal = bi2de(sindromebinario);
    
end