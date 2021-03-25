function [lista_de_eventos, tiempo, tipo, tllegadatarea, numpaquete, taire] = sgteEvento(lista_de_eventos)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    s = size(lista_de_eventos);
    if isempty(lista_de_eventos) 
        % La lista esta vacia
        tiempo = 0;
        tipo = -1;
        tllegadatarea = 0;
        numpaquete = 0;
        taire = 0;
        return
    end

    tiempo = lista_de_eventos(1,1);
    tipo = lista_de_eventos(1,2);
    tllegadatarea = lista_de_eventos(1,3);
    numpaquete = lista_de_eventos(1,4);
    taire = lista_de_eventos(1,5);
    
    if s(1)==1
    % La lista se va a quedar vacia
        lista_de_eventos = [];
        return
    end
    
    % Creamos una nueva lista
    newlista = zeros(s(1)-1,5);
    newlista(1:s(1)-1,:) = lista_de_eventos(2:s(1),:);
    
    lista_de_eventos = newlista;
end