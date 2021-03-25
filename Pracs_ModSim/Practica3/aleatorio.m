function [Z, muestra] = aleatorio(Z, tipo, param1, param2, generador)
    [Z, m] = GCLM(Z,generador);
    u = Z/double(m);
    switch tipo
        case 0 % -> VA uniforme [0,1]
            muestra = u;
        case 1 % -> VA uniforme [param1,param2]
            muestra = param1 + u*(param2-param1);
        case 2 % -> VA exponencial lambda = param1
            muestra = -log(u)/param1;
        case 3 % -> Devuelve siempre param1 (VA “degenerada”) 
            muestra = param1;
        case 4 % -> VA Bernoulli (devuelve 1 con probabilidad dada por param1, sino 0)
            if u <= param1
                muestra = 1;
            else
                muestra = 0;
            end
    end
end