N = 1000;
strtx = ascii('Hola mundo');

for R = 1:1:5
    B=2^R;
    exito = 0;
    transmisiones = 0;
    mensajes = 0;
    
    for i=1:N
        
        strrx = '';
        tx = strtx;
        iteraciones = ceil(length(tx)/B);
        for j=1:iteraciones
            
            inf = (j-1)*B+1;
            sup = j*B;
            
            if(j*B > length(tx))
                inf = B*(j-1)+1;
                sup = length(tx);    
            end
            
            parte=tx(inf:sup);
            mensajes = mensajes + 1;
            
            while true  
                transmisiones = transmisiones + 1;
                [valor, bloquep] = paridad(parte);
                rx = canalBS(bloquep,0.90);
                errordetectado = false;
                
                if paridad(rx)== 0
                    strrx = strcat(strrx,rx(1:length(rx) - 1 ));
                else
                    errordetectado = true;
                end
                
                if ~errordetectado
                    break;
                end
            end
        end
        
        if strcmp(strrx,strtx)
            exito = exito + 1;
        end
    end
    
    r = exito/N;
    t = transmisiones / mensajes;
    tasa = r*1000/((B+1)*t/B);
    disp('###############################')
    disp(['TAMAÑO DE BOQUE: ', num2str(B)])
    disp(['RATIO: ', num2str(r)])
    disp(['TASA: ', num2str(t)])
    disp(['TASA EFECTIVA: ', num2str(tasa)])
    
end