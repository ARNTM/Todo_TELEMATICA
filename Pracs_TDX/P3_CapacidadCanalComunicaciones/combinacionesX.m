function X = combinacionesX(L)
% Devuelve las posibles masas de probabilidad para X para una fuente de L simbolos
% Puede ajustarse el paso segun convenga

paso = 0.01;
p = 0:paso:1;

q=p;
%q = nchoosek(p,L)';
for i=1:L-1
	q = combvec(p,q);
    %size(q)
	q = q(:,sum(q,1)<=1);  % Las combinaciones >1 se pueden descartar ya
end

X = q(:,sum(q,1)==1)';
%X=q'

end

