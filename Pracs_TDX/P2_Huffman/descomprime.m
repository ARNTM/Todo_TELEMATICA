function  [longitud]  = descomprime( fichero, codigo )
% Descomprime el fichero con la codificacion dada por el codigo
% El nombre del fichero es el original+'.descomp'

F = fopen(fichero,'r');
G = fopen(strcat(fichero,'.descomp'),'w');
texto = '';

% obtenemos la longitud
longitud = fread(F, 1, 'uint32');
leidos = 0;
flujo = '';

while ~feof(F) && leidos<longitud
	c = fread(F,1);

	% Completamos para que posea siempre 8 bit
	relleno = 8 - length(dec2bin(c));
	for j=1:relleno
		flujo = [flujo, '0'];
	end

	flujo = [flujo, dec2bin(c)];
	[l, t, flujo] = decodifica(flujo, codigo);
	leidos = leidos + l;
	if l>0 && (leidos-l)<longitud
	        if leidos>longitud
		        % Hay que presecindir de leidos-longitud caracteres del texto
			fwrite(G,t(1:l-(leidos-longitud)));
                else
			fwrite(G,t);
		end
	end
end


fclose(F);
fclose(G);


end
