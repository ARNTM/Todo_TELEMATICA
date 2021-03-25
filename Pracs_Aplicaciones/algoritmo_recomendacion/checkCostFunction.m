function checkCostFunction(lambda)
%CHECKCOSTFUNCTION Crea un problema de filtrado colaborativo para comprobar
%tu función de computo del coste y del gradiente. 
%   CHECKCOSTFUNCTION(lambda) da como resultado el gradiente analitico
%   producido por tu codigo y el gradiente numerico (calulado mediante
%   computeNumericalGradient). Deben producir resultados muy similares.

% Set lambda
if ~exist('lambda', 'var') || isempty(lambda)
    lambda = 0;
end

%% Create small problem
X_t = rand(4, 3);
Theta_t = rand(5, 3);

% Zap out most entries
Y = X_t * Theta_t';
Y(rand(size(Y)) > 0.5) = 0;
R = zeros(size(Y));
R(Y ~= 0) = 1;

%% Run Gradient Checking
X = randn(size(X_t));
Theta = randn(size(Theta_t));
num_users = size(Y, 2);
num_movies = size(Y, 1);
num_features = size(Theta_t, 2);

numgrad = computeNumericalGradient( ...
                @(t) cofiCostFunc(t, Y, R, num_users, num_movies, ...
                                num_features, lambda), [X(:); Theta(:)]);

[cost, grad] = cofiCostFunc([X(:); Theta(:)],  Y, R, num_users, ...
                          num_movies, num_features, lambda);

disp([numgrad grad]);
fprintf(['Las dos columnas de arriba deberían ser muy similares.\n' ...
         '(A tu izquierda, el gradiente numérico, a la derecha, el gradiente analítico.)\n\n']);

diff = norm(numgrad-grad)/norm(numgrad+grad);
fprintf(['Si tu implementación es correcta, la diferencia relativa \n' ...
         'debería ser muy pequeña (menor que 1e-9). \n' ...
         '\nDiferencia Relativa: %g\n'], diff);

end