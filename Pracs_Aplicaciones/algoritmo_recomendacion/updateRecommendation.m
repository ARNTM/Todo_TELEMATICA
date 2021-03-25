function updateRecommendation(recs, id_user)
    conn = conectaBBDD('ai51', 'ai2020', com.mysql.jdbc.Driver,  'jdbc:mysql://localhost/ai51?useSSL=false&');
    for i=1:size(recs)
        if(recs(i) ~= 0)
            query = strcat('INSERT INTO recs (user_id,movie_id,rec_score) VALUES (',num2str(id_user),',',num2str(i),',',num2str(recs(i)),') ON DUPLICATE KEY UPDATE rec_score=',num2str(recs(i)),';');
            ejecutar(conn,query);
        end
    end
    close(conn);
end
