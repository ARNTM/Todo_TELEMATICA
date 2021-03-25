function array = ejecutar (conn, query)

    import java.sql.Connection;
    import java.sql.DriverManager;
    import java.sql.Statement;
    import java.sql.ResultSet;

    stmt = conn.createStatement();

    if (stmt.execute(query) && stmt.execute(query)~=0) 
        rs = stmt.getResultSet();
        array = rs2array(rs);
        rs.close();
    end

    stmt.close();

end