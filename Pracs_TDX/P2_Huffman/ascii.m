function  [nuevotexto, longitud]  = ascii( texto )
% Devuelve la codificacion binaria de un texto ascii y su longitud

nuevotexto = '';

for i=1:length(texto)
	c = texto(i);
        relleno = 8 - length(dec2bin(c));
	for j=1:relleno
		nuevotexto = strcat(nuevotexto, '0');
	end
	nuevotexto = strcat(nuevotexto, dec2bin(texto(i)));
end
    
longitud = length(nuevotexto);
    
end
