N = 1000;
strtx = ascii('Hola mundo');

for R = 2:2:10
    
    exito = 0;
    transmisiones = 0;
    mensajes = 0;
    
    for i=1:N
        
        strrx = '';
        tx = repeticion(strtx,R);
        
        for j=1:length(tx)/R
            parte=tx((j-1)*R+1:j*R);
            mensajes = mensajes + 1;
            
            while true
                
                transmisiones = transmisiones + 1;
                rx = canalBS(parte,0.90);
                errordetectado = false;
                
                if(length(strfind(rx,'1')) == R)
                    strrx = strcat(strrx,rx);
                elseif(length(strfind(rx,'0')) == R)
                    strrx = strcat(strrx,rx);
                else
                    errordetectado = true;
                end
                
                if ~errordetectado
                    break;
                end
            end
        end
        
        if strcmp(strrx,tx)
            exito = exito + 1;
        end
    end
    
    r = exito/N;
    t = transmisiones / mensajes;
    tasa = r*1000/(R*t);
    disp('###############################')
    disp(['NUMERO DE REPETICIONES: ', num2str(R)])
    disp(['RATIO: ', num2str(r)])
    disp(['TASA: ', num2str(t)])
    disp(['TASA EFECTIVA: ', num2str(tasa)])
end