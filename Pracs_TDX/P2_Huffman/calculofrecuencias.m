function freq = calculofrecuencias(nombre_fichero)
    fichero = fopen(nombre_fichero,'r');
    freq = zeros(1,256);
    while ~feof(fichero) %%End Of File
        letra = fread(fichero,1); %% Leer fichero caracter a caracter
        freq(letra+1) = freq(letra+1)+1;
    end
    
    freq = freq/(sum(freq));
    
    %figure;
    %plot(freq);
end