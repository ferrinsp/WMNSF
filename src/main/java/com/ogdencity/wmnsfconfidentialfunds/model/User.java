package com.ogdencity.wmnsfconfidentialfunds.model;

import org.hibernate.annotations.Type;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import javax.persistence.*;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="user")
public class User implements Serializable{

    @Id
    @GeneratedValue( strategy = GenerationType.IDENTITY)
    private Long id;
    @Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	@Email(message = "Please enter a valid email") 
    @NotBlank(message = "Please enter a valid email")
    private String email;
    @Size(min = 2, max = 30, message = "First name must be between {min} and {max}") 
    @Pattern(regexp = "^[A-Za-z]*$", message = "Invalid first name, letters only") 
    @NotBlank(message = "First name can not be blank")
    private String firstName;
    @Size(min = 2, max = 30, message = "Last name must be between {min} and {max}")
    @Pattern(regexp = "^[A-Za-z]*$*", message = "Invalid last name, letters only") 
    @NotBlank(message = "Last name can not be blank")
    private String lastName;
    @NotBlank(message = "Password cannot be blank")
    private String password;
    private int balance = 0;

    @Column(nullable = false)
    @Type(type = "org.hibernate.type.NumericBooleanType")
    private boolean enabled;

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinTable(name = "user_permission",
            joinColumns = {@JoinColumn(name = "user_id", nullable = false, updatable = false)},
            inverseJoinColumns = {@JoinColumn(name = "permission_id", nullable = false, updatable = false)})
    
    private List<Permission> permissions = new ArrayList<>();
    private List<AllocatedFunds> funds = new ArrayList<>();
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFullName()
    {
        return firstName + " " + lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public int getBalance() {
        return balance;
    }

    public void setBalance(int balance) {
    	this.balance = balance;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public List<Permission> getPermissions() {
        return permissions;
    }

    public void setPermissions(List<Permission> permissions) {
        this.permissions = permissions;
    }

    public boolean isAdmin(){
        boolean result = false;

        for(Permission permission : this.permissions){
            if(permission.getId() == 1)
                result = true;
        }
        return  result;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void toggleStatus(){
        enabled = !enabled;
    }
    
    private void updateBalance() {
    	for(AllocatedFunds af: funds) balance += af.getRemainingBalance();
    }
    
    public boolean depositFunds(int value, String fundName){
    	boolean result = funds.get(funds.indexOf(fundName)).changeAllocatedBalance(value);
    	this.updateBalance();
    	return result;
    }
    
    public boolean transferFunds(int value, String fundName){
    	if(value < 1) return false;
    	boolean result = funds.get(funds.indexOf(fundName)).changeAllocatedBalance(value * -1);
    	this.updateBalance();
    	return result;
    }
    
    public boolean expendFunds(int value, String fundName){
    	boolean result = funds.get(funds.indexOf(fundName)).changeRemainingBlanace(value * -1);
    	this.updateBalance();
    	return result;
    }
}