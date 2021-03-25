function script(codigo,fuente)
    tic;
    p=calculofrecuencias(codigo);
    c=huffman(p);
    comprime(fuente,c);
    descomprime([fuente,'.comp'],c);
    toc;
end