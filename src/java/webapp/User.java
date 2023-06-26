
package webapp;

/**
 *
 * @author Bern Ard
 */
public class User {
    
        private String username;
	private String fname;
	private String lname;
	private String email;
	private String passwd;
	private String gender;
        
        public User() {
		super();
		
	}	
	

	public User(String username,String fname, String lname, String email, String passwd,String gender) {
		super();
                this.username = username;
		this.fname = fname;
		this.lname = lname;
		this.email = email;
		this.passwd = passwd;
		this.gender = gender;
	}

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }
	
	
	
	
	


	

	
    
}
