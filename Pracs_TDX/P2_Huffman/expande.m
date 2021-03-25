function [nuevocodigo] = expande(codigo,indA,indB)
    nuevocodigo=codigo;
    nuevocodigo{indA}=[codigo{indB},'1'];
    nuevocodigo{indB}=[codigo{indB},'0'];
end

