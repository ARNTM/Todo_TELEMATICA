function [ fifo, tiempo ] = popFIFO( fifo )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

    if ~isempty(fifo) 
        tiempo = fifo(1);
        if length(fifo)>1
            newfifo = zeros(length(fifo)-1,1);
            newfifo(1:length(fifo)-1) = fifo(2:length(fifo));
            fifo = newfifo;
        else
            fifo = [];
        end
    else
        tiempo = -1;
    end
        
end

