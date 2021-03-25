N = 2000;
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

            [bloquep] = hamming74(parte);
            rx = canalBS(bloquep,0.90);
            sindrome = sindrome74(rx);
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
        
        if strcmp(strrx,strtx)
            exito = exito + 1;
        end
    end
    
    r = exito/N;
    tasa = r*1000/(7/4);
    disp('###############################')
    disp(['TAMAÑO DE BLOQUE: ', num2str(B)])
    disp(['RATIO: ', num2str(r)])
    disp(['TASA EFECTIVA: ', num2str(tasa)])
    
end