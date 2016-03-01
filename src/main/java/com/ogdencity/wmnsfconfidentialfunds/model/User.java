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

    @Email(message = "Please enter a valid email") 
    @NotBlank(message = "Please enter a valid email")
    private String email;
    @Size(min = 2, max = 30, message = "First name must be between {min} and {max}") 
    @Pattern(regexp = "{A-Za-z}*", message = "Invalid first name, letters only") 
    @NotBlank(message = "First name can not be blank")
    private String firstName;
    @Size(min = 2, max = 30, message = "Last name must be between {min} and {max}")
    @Pattern(regexp = "{A-Za-z}*", message = "Invalid last name, letters only") 
    @NotBlank(message = "Last name can not be blank")
    private String lastName;
    @NotBlank @Size(min = 8, max = 20, message = "Password can not be blank")
    private String password;
    private Double balance;

    @Column(nullable = false)
    @Type(type = "org.hibernate.type.NumericBooleanType")
    private boolean enabled;

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinTable(name = "user_permission",
            joinColumns = {@JoinColumn(name = "user_id", nullable = false, updatable = false)},
            inverseJoinColumns = {@JoinColumn(name = "permission_id", nullable = false, updatable = false)})
    private List<Permission> permissions = new ArrayList<>();

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
    
    public Double getBalance() {
        return balance;
    }

    public void setBalance(Double balance) {
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
}