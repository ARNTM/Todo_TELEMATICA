function recomendar(user)

fprintf('Cargando datos desde BBDD.\n\n');

[movieList, Y, R, num_movies, num_users, num_features, my_ratings] = getData(user);

% fprintf('Puntuación media para la película 1 (Toy Story): %f / 5\n\n', mean(Y(1, R(1, :))));

checkCostFunction(1.5);

% fprintf('\n\nNuevas puntuaciones:\n');
% for i = 1:length(my_ratings)
%     if my_ratings(i) > 0 
%         fprintf('Puntuación %d para la película %s\n', my_ratings(i), movieList{i});
%     end
% end
% 
% fprintf('\nEntrenando el filtrado colaborativo...\n');

%  Añade tus puntuaciones a la matriz de datos
Y = [my_ratings Y];
R = [(my_ratings ~= 0) R];

% Inicializa parámetros (Theta, X)
X = randn(num_movies, num_features);
Theta = randn(num_users, num_features);

initial_parameters = [X(:); Theta(:)];

% Selecciona las opciones de fmincg
options = optimset('GradObj', 'on', 'MaxIter', round(0.2*num_users));

% Ajusta regularización y ejecuta la optimización
lambda = 10;
theta = fmincg (@(t)(cofiCostFunc(t, Y, R, num_users, num_movies, num_features, lambda)), initial_parameters, options);

% Extrae X y Theta del vector resultante de la optimización (theta)
X = reshape(theta(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(theta(num_movies*num_features+1:end), num_users, num_features);

p = X * Theta';
my_predictions = p(:,1).*(my_ratings == 0);

updateRecommendation(my_predictions, user);

end
