function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Funcion de coste del filtrado colaborativo
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) devuelve el coste y el gradiente
%   del problema de filtrado colaborativo

% Extrae las matrices U y W de params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), num_users, num_features);

            
% Debes generar los siguientes valores correctamente
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% ====================== TU CODIGO AQUI ======================
% Instrucciones: Debes implementar en primer lugar la funcion de coste
%                (sin regularizacion) para filtrado colaborativo, y comprobar
%               que coincide con el coste indicado en la memoria. Despues de esto
%               debes implementar el gradiente y usar checkCostFunction para 
%               comprobar que es correcto. Finalmente, debes implementar 
%               regularizacion.
%
% Notas: X - num_movies  x num_features : matriz de caracteristicas de la pelicula
%        Theta - num_users  x num_features: matriz de parametros del usuario 
%        Y - num_movies x num_users: matriz de puntuaciones
%        R - num_movies x num_users: matriz en la que R(i, j) = 1 si la
%            i-esima pelicula ha sido puntuada por el j-esimo usuario
%
% Debes generar las siguientes variables correctamente:
%
%        X_grad - num_movies x num_features: matriz con las derivadas parciales 
%                 con respecto a cada elemento de X
%        Theta_grad - num_users x num_features: matriz con las derivadas parciales
%                 con respecto a cada elemento deTheta
%
M=X*Theta'; %vectorized form for predicted ratings, see slides for collaborative filtering
J=(1/2)*sum(sum(((M-Y).*R).^2)); %cost function

J = J + (lambda/2) * sum(sum(Theta .^ 2)) + (lambda/2) * sum(sum(X .^ 2));

%now let's try to use a vectorized implementation to compute the gradient w.r.t. to X and Theta

for i=1:num_movies
	idx=find(R(i,:)==1); %here I get a  vector with the indices of values = 1, that is I get the users who voted movie i
	Theta_temp=Theta(idx,:);
	Y_temp=Y(i,idx);
	X_grad(i,:)=(X(i,:)*Theta_temp' - Y_temp)*Theta_temp; 
	%add regularization
	X_grad(i,:) = X_grad(i,:) + lambda*X(i,:);

end

for j=1:num_users
	idx=find(R(:,j)==1); %find the movies that user j has rated
	X_temp=X(idx,:); %r x numfeatures
	Y_temp=Y(idx,j); %r x 1 
	Theta_grad(j,:)=(X_temp*Theta(j,:)' - Y_temp)'*X_temp;  %note the transpose 
	%add regularization
	Theta_grad(j,:)=Theta_grad(j,:) + lambda*Theta(j,:);

end

% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end
