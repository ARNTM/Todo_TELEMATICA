function [salida, ratioerror] = canalBS(fuente, p)
% Genera una instancia aleatoria de la salida para un CBS

salida = fuente;
instancia = (rand(1, length(fuente))<p); % Simbolos ok
for i=1:length(fuente)
	if instancia(i)==0
		if fuente(i)=='1'
			salida(i)='0';
		else
			salida(i)='1';
		end
	end
end

ratioerror = (length(fuente)-sum(instancia))/length(fuente);

end
