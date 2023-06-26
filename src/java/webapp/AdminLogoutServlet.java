
package webapp;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "AdminLogoutServlet", urlPatterns = {"/adminlogout"})
public class AdminLogoutServlet extends HttpServlet {

   

   

    
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                HttpSession session = request.getSession();		
		session.removeAttribute("key");
		session.invalidate();
		response.sendRedirect("index.jsp");
    }

    

}
