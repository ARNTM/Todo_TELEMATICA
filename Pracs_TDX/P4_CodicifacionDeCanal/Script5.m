N = 1000;
strtx = ascii('Hola mundo');

for R = 1:1:4
    B=2^R;
    exito = 0;
    transmisiones = 0;
    mensajes = 0;
    
    for i=1:N
        
        strrx = '';
        tx = strtx;
        for j=1:length(tx)/B
            
            parte=tx((j-1)*B+1:j*B);
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
    disp(['TAMAÑO DE BLOQUE: ', num2str(B)])
    disp(['RATIO: ', num2str(r)])
    disp(['TASA: ', num2str(t)])
    disp(['TASA EFECTIVA: ', num2str(tasa)])
    
end