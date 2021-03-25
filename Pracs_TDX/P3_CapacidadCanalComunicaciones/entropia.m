function H = entropia(freq)
    suma = 0;
    for i = 1:length(freq)
        if(freq(i)~=0)
            suma=suma+freq(i)*(log2(freq(i)));
        end
    end
    H=-(suma);
end