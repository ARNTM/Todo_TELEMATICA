function [movieList, Y, R, numP, numU, numG, puntUser] = getData(id_user)

    conn = conectaBBDD('ai51', 'ai2020', com.mysql.jdbc.Driver,  'jdbc:mysql://localhost/ai51?useSSL=false&');

    query = 'SELECT title FROM movie';
    movieList = ejecutar(conn,query);

    query = strcat('SELECT id_user,id_movie,score FROM user_score WHERE id_user!=', num2str(id_user));
    scores = str2double(ejecutar(conn,query));

    query = 'SELECT MAX(id) FROM movie';
    numP = str2double(cell2mat(ejecutar(conn,query)));

    query = 'SELECT MAX(id) FROM users';
    numU = str2double(cell2mat(ejecutar(conn,query)));
    
    query = 'SELECT COUNT(*) FROM genre';
    numG = str2double(cell2mat(ejecutar(conn,query)));
    
    query = strcat('SELECT id_movie,score FROM user_score WHERE id_user=', num2str(id_user));
    puntUserA = str2double(ejecutar(conn,query));
    
    disp(numU)

    close(conn);
    
    Y = zeros(numP,numU);
    R = zeros(numP,numU);
    A = size(scores);
    puntUser = zeros(numP,1);
    
    for i=1:A(1)
        Y(scores(i,2),scores(i,1)) = scores(i,3);
        if(scores(i,3) ~= 0) 
           R(scores(i,2),scores(i,1)) = 1; 
        end
    end

    Y(:,id_user) = [];
    R(:,id_user) = [];

    R = logical(R);
    A = size(puntUserA);
    
    for i=1:A(1)
        puntUser(puntUserA(i,1)) = puntUserA(i,2);
    end
end
