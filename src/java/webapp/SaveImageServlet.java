
package webapp;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import webapp.dao.SaveImgDao;


@WebServlet(name = "SaveImageServlet", urlPatterns = {"/saveimage"})
@MultipartConfig(maxFileSize=161772150)
public class SaveImageServlet extends HttpServlet {

  

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
            int id = Integer.parseInt(request.getParameter("userid"));
            
                response.getWriter().println(id);
	
		InputStream img = null ;
		
		SaveImgDao dao = new SaveImgDao();
		
		Part part = request.getPart("img");
		String result = "";
		if(!part.getContentType().contains("image")) {
			response.getWriter().print("Image type NOT supported!!");
			
		}else {
			img = part.getInputStream();
			
			try {
				result = dao.insert(id, img);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(result.equals("Data entry successfull")) {
				response.sendRedirect("profile.jsp");
			}
			
			
		}
        
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                int id = Integer.parseInt(request.getParameter("id"));
                final String usernameDB = "root";
                final String passwordDB = "1234";
                final String urlPort = "localhost:3307";
                final String databaseName = "hitastic";
                final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
                final String dbDriver = "com.mysql.cj.jdbc.Driver";
                String sql = "SELECT img FROM users WHERE id=?";

                try {
                Class.forName(dbDriver);
                Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);

                PreparedStatement ps;
		  
		   ps = con.prepareStatement(sql);
		   ps.setInt(1, id);
		   
		   ResultSet rs1 = ps.executeQuery();
		   if(rs1.next()){
		    byte [] imageData = rs1.getBytes("img"); // extract byte data from the resultset..
		    OutputStream os = response.getOutputStream(); // output with the help of outputStream 
		             os.write(imageData);
		             os.flush();
		             os.close();
		   }
		  } catch (Exception e) {
		   // TODO Auto-generated catch block
		   e.printStackTrace();
		   response.getOutputStream().flush();
		   response.getOutputStream().close();
		  }
        
    }

    
}
