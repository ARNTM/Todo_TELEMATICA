function [bloquep] = hamming74(bloque)

    b1 = strcat(bloque(1),bloque(2),bloque(4));
    b2 = strcat(bloque(1),bloque(3),bloque(4));
    b3 = strcat(bloque(2),bloque(3),bloque(4));
    
    if mod(length(strfind(b1,'1')),2) ~= 0
        p0 = '1';
    else
        p0 = '0';
    end
    
    if mod(length(strfind(b2,'1')),2) ~= 0
        p1 = '1';
    else
        p1 = '0';
    end
    
    if mod(length(strfind(b3,'1')),2) ~= 0
        p2 = '1';
    else
        p2 = '0';
    end
    
    bloquep = strcat(p0,p1,bloque(1),p2,bloque(2),bloque(3),bloque(4));
    
end