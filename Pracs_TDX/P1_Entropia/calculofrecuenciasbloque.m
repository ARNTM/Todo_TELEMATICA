function freq = calculofrecuenciasbloque(nombre_fichero,bloque)
    fichero = fopen(nombre_fichero,'r');
    freq = zeros(1,(2^(8*bloque)));
    while ~feof(fichero) %%End Of File
        indice = 0;
        b = fread(fichero,bloque); %% Leer fichero caracter a caracter
        for i = 0:length(b)-1
            indice=indice+b(i+1)*256^i;
        end
        freq(indice+1) = freq(indice+1)+1; 
    end
    
    freq = freq/(sum(freq));
    
    figure;
    plot(freq);
end