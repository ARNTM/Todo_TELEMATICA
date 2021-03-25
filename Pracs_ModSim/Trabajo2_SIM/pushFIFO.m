function [ fifo ] = pushFIFO( fifo, tiempo )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    newfifo = zeros(length(fifo)+1,1);
    newfifo(length(fifo)+1) = tiempo;
    newfifo(1:length(fifo)) = fifo(1:length(fifo));
    fifo = newfifo;

end

