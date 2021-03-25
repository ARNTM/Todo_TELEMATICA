function  [longitud]  = comprime( fichero, codigo )
% Comprime el fichero con la codificacion dada por el codigo
% El nombre del fichero es el original+'.comp'

F = fopen(fichero,'r');
G = fopen(strcat(fichero,'.comp'),'w');
texto = '';

% obtenemos la longitud
s = dir(fichero); 
longitud = s.bytes;

fwrite(G, longitud, 'uint32');

while ~feof(F)
	c = fread(F,1);
	[nuevotexto, longitud] = codifica(c, codigo);
	texto = [texto, nuevotexto];
	
	% Si ya hay mas de 8 digitos binarios podemos volcar el siguiente byte  al fichero
	while length(texto)>=8
		fwrite(G, bin2dec(texto(1:8)));
		texto = texto(9:length(texto));
	end
end

% Podrian quedar un poco del buffer sin volcar
if length(texto)>0
        for j=length(texto)+1:8
		texto = [texto,'0'];
	end
	fwrite(G, bin2dec(texto(1:8)));
end

fclose(F);
fclose(G);


end
