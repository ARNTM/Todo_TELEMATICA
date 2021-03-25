function [HXY, HX, HY, HXcondY, HYcondX] = entropiaconjunta(P)
    suma = 0;
    
    PX = zeros(1,size(P,2));
    PY = zeros(1,size(P,1));
    
    HXcondY = 0;
    HYcondX = 0; 
    
    for i=1:size(P,1)
        for j=1:size(P,2)
            if(P(i,j)~=0) 
                suma = suma + P(i,j)*(log2(P(i,j)));
            end
            PY(1,i) = PY(1,i) + P(i,j);
            PX(1,j) = PX(1,j) + P(i,j);
        end
    end
    
    HXY = -suma;  
    HX = entropia(PX);
    HY = entropia(PY);
    
    for j=1:size(P,1)
        HXcondY = HXcondY + entropia(P(j,:)/sum(P(j,:)))*sum(P(j,:));
    end
    
    for i=1:size(P,2)
        HYcondX = HYcondX + entropia(P(:,i)/sum(P(:,i)))*sum(P(:,i));
    end
end
