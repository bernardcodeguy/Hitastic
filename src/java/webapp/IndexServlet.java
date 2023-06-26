
package webapp;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Bern Ard
 */
@WebServlet(name = "IndexServlet", urlPatterns = {"/start"})
public class IndexServlet extends HttpServlet {


    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        HttpSession session = request.getSession();
        String username = "root";
        String passwordDB = "1234";
        String urlPort = "localhost:3307";
        String databaseName = "hitastic";
        String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        String dbDriver = "com.mysql.cj.jdbc.Driver";
        String sql = "SELECT username FROM users ORDER BY id DESC LIMIT 1";
        
        
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        
        String lastUserName = "";
        String newUserName = "";
        String prefix = "user";
        String str = String.format("%04d", 1);
        
        try {
            Class.forName(dbDriver);
            con = DriverManager.getConnection(url,username,passwordDB);
            st = con.createStatement();
            rs = st.executeQuery(sql);
            
            if(rs.next()){
                lastUserName = rs.getString("username");
                response.getWriter().println(lastUserName);
                String [] name = lastUserName.split("r");
                int number = Integer.parseInt(name[1])+1;
                String uid = String.format("%04d", number);
                
                
                newUserName = prefix+uid;
                
                session.setAttribute("username", newUserName);
                response.sendRedirect("register.jsp");
            }else{
                
                newUserName = prefix+str;
                session.setAttribute("username", newUserName);
                response.sendRedirect("register.jsp");
            }
            con.close();
        } catch (Exception ex) {
            Logger.getLogger(IndexServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
	
        
        
            
    }

    
}
