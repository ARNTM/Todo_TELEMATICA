function [r,i] = PageRank(A,alfa)
    a = sum(A,2);
    N = length(A);
    b = 1./a;
    Q = A.*b;
    M = alfa*Q + (((1-alfa)/N) * ones (N,N));
    M_E = SolveErgodicDTMC(M);
    [r,i] = sort(M_E,'descend')
end