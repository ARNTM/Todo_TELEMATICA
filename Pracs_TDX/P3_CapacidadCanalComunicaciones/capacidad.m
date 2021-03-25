function [C, pX] = capacidad(Q)
    T=combinacionesX(size(Q,1));
    I=zeros(1,length(T));
    
    for i=1:length(T)
        I(i)=informacionmutua (Q.*T(i,:)');
    end
    
    [C,ind]=max(I);
    pX=T(ind,:);
    
end