function [c] = huffman (p)
    nP = p;
    idx=zeros(1,2);
    i = 0;
    L = size(p,2);
    c = repmat({''},1,L);
    iA = 0;
    iB = 0;
    
    while(or(iA~=-1,iB~=-1))
        i = i+1;
        [iA,iB,acumulado,nP] = compacta(nP);
        if(iA~=-1)
            idx(i,1)= iA;
        end
        if(iB~=-1)
            idx(i,2) = iB;
        end
    end
    idx = flipud(idx);
    
    for j = 1:size(idx,1)
        c = expande(c,idx(j,1),idx(j,2));
    end

end