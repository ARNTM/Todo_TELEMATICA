function v = SolveErgodicDTMC(P)
    m = length(P);
    M = eye(m)-P;
    M(:,end) = ones (m,1);
    y = zeros(1,m);
    y(end) = 1;
    v = M'\y';
end