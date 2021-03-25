N = 1000;
f = ascii('hola mundo');

exito = 0;

for i=1:N
    tx = f;
    rx = canalBS(tx,0.9);
    if strcmp(rx,tx)
        exito = exito + 1;
    end
end
r = exito/N;
tasa = r*1000;

disp('###############################')
disp(['RATIO: ', num2str(r)])
disp(['TASA EFECTIVA: ', num2str(tasa)])