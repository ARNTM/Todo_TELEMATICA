function conn = conectaBBDD(user, password, driverName, url)

import java.sql.*;
import java.sql.DriverManager;
import java.sql.DriverManager.*;

d = driverName;
urlValid = d.acceptsURL(url);
props = java.util.Properties;
props.put('user',user); props.put('password',password);
conn = d.connect(url,props);

end