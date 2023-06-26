package webapp;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;
import webapp.dao.RegisterDao;

/**
 *
 * @author Bern Ard
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

  
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException{
         
        String username = request.getParameter("username");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String plainPass1 = request.getParameter("passwd");
        String plainPass2 = request.getParameter("passwd2");
        String gender = request.getParameter("gender");
        
       if(plainPass1.equals(plainPass2)) {
           String passwd = hashPassword(plainPass1); 
           
           User user = new User(username,fname,lname,email,passwd,gender);
           
           RegisterDao dao = new RegisterDao();
           
           String result = "";
                try {
                        result = dao.insert(user);
                } catch (SQLException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                }

                 if(result.equals("Data entry successfull")) {
                         			 
                         response.sendRedirect("login.jsp");			 
                 }else {
                         PrintWriter out1 = response.getWriter();
			out1.println("<script type=\"text/javascript\">");
			out1.println("alert('<%=result%>');");
			out1.println("location='register.jsp';"); 
                        out1.println("</script>");
             }
          
       }else {
           
            PrintWriter out1 = response.getWriter();
            out1.println("<script type=\"text/javascript\">");
            out1.println("alert('Passwords does not match');");
            out1.println("location='register.jsp';");
            out1.println("</script>");
    }       
        
    }
    
    
    private String hashPassword(String plainTextPassword){
		return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
	}
	

    
}
