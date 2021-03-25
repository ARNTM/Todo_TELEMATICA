function [iA,iB,acumulado,nP] = compacta(p)
    nP = p;
    [vA,iA]=min(nP);
    nP(iA)=NaN;
    [vB,iB]=min(nP);
    acumulado=vA+vB;
    nP(iB)=acumulado;
    
    if or(isnan(vA),isnan(vB))
        iA=-1;
        iB=-1;
        acumulado=0;
        nP=[];
    end
    
    
end