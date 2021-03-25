function  [longitud,texto,nuevoflujo] = decodifica(flujo,codigo)
    nuevoflujo='';
    flujoVentana='';
    textoD='';
    flujoUsado='';

    for i=1:length(flujo)
        flujoVentana=[flujoVentana,flujo(i)];

        for j=1:length(codigo)
            if strcmp(flujoVentana,codigo{j})
                textoD=[textoD,j-1];
                flujoUsado=[flujoUsado,flujoVentana]; 

                flujoVentana='';  
            end
        end
    end

    texto=textoD
    longitud = length(texto)
    nuevoflujo=regexprep(flujo,flujoUsado,'')
end
