N = 1000;
strtx = ascii('Hola mundo');

for R = 2
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
                [bloquep] = hamming74(parte);
                [valor, bloquep] = paridad(bloquep);
                rx = canalBS(bloquep,0.90);
                errordetectado = false;
                sindrome = sindrome74(rx);
                P = paridad(rx);
                
                if P == 0 && sindrome > 0
                    errordetectado = true;
                else
                    if sindrome == 0
                    strrx = strcat(strrx,rx(3),rx(5),rx(6),rx(7));
                    else
                        if(rx(sindrome) == '0')
                            rx(sindrome) = '1';
                        else
                            rx(sindrome) = '0';
                        end
                        strrx = strcat(strrx,rx(3),rx(5),rx(6),rx(7));     
                    end
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
    tasa = r*1000/(8*t/4);
    disp('###############################')
    disp(['TAMAÑO DE BLOQUE: ', num2str(B)])
    disp(['RATIO: ', num2str(r)])
    disp(['TASA: ', num2str(t)])
    disp(['TASA EFECTIVA: ', num2str(tasa)])
    
end