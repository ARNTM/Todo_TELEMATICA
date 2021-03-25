N = 1000;
strtx = ascii('Hola mundo');

for R = 3:2:11
    exito = 0;
    for i=1:N
        strrx = '';
        tx = repeticion(strtx,R);
        rx = canalBS(tx,0.90);
        
        for j=1:length(rx)/R
            parte=rx((j-1)*R+1:j*R);
            
            if(length(strfind(parte,'1'))>length(strfind(parte,'0')))
                strrx = strcat(strrx,'1');
            else
                strrx = strcat(strrx,'0');
            end
        end
        
        if strcmp(strrx,strtx)
            exito = exito + 1;
        end
    end
    r = exito/N;
    tasa = r*1000/R;
    disp('###############################')
    disp(['NUMERO DE REPETICIONES: ', num2str(R)])
    disp(['RATIO: ', num2str(r)])
    disp(['TASA EFECTIVA: ', num2str(tasa)])

end