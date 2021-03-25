function [LongMedia] = LongMedia(p) 
    codigo=huffman(p)
    L=0;
    
    for i=1:length(codigo) 
        L = L+p(i)*numel(codigo{i});
    end
    L
end