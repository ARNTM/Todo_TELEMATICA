function I = informacionmutua(P)
    I = 0;
    for i=1:size(P,1)
        for j=1:size(P,2)
            if(P(i,j)~=0) 
                I = I + P(i,j)*log2(P(i,j)/sum(P(i,:))/sum(P(:,j)));
            end
        end
    end
end