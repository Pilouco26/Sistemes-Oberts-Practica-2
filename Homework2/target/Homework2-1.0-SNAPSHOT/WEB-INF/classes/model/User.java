package deim.urv.cat.homework2.model;

public class User {
    private String firstName;
    private String password;
    private String email;

    public String getFirstName() {
        return fixNull(this.firstName);
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getPassword() {
        return fixNull(this.password);
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return fixNull(this.email);
    }

    public void setEmail(String email) {
        this.email = email;
    }

    private String fixNull(String in) {
        return (in == null) ? "" : in;
    }
}
