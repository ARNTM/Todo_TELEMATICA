function [nuevotexto,longitud] = codifica(texto,codigo)
    nuevotexto = '';
    
    for i=1:length(texto)
        nuevotexto=[nuevotexto,codigo{texto(i)+1}];
    end

    longitud = length(nuevotexto);

end