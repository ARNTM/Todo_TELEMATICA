function [f,e]=fbinomial(p,n)
f=zeros(1,n);
e=zeros(0,length(p));
for j=1:length(p)
    for i=1:n 
        res=nchoosek(n,i)*(p(j)^i)*((1-p(j))^(n-i));
        f(i)=res;
    end
   e(j)=entropia(f);
end