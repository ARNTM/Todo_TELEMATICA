function array = rs2array(rs)
    
    rs.last();
    rsmd = rs.getMetaData();
    
    numCols = rsmd.getColumnCount();
    numFils =rs.getRow();
    
    array = cellstr(num2str(zeros(numFils,numCols)));

    j = 1;
    
    rs.beforeFirst();
    
    while(rs.next())
        for i=1:numCols
            array(j,i)=rs.getString(i);
        end
        j = j + 1;
    end
    
end