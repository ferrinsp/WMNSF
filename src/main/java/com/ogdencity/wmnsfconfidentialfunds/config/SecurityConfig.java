package com.ogdencity.wmnsfconfidentialfunds.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter{

    @Override
    public void configure(WebSecurity web) throws Exception {
        super.configure(web);

    }

    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder(10);
    }

    @Override
    protected void configure(final HttpSecurity http) throws Exception {
        http
                // don't secure these routes
                .authorizeRequests()
                .antMatchers("/", "/doLogin", "/static/**").permitAll()
                .anyRequest().authenticated()
                .and()
                        // use form Login
                .formLogin()
                .loginPage("/")
                .loginProcessingUrl("/doLogin")
                .usernameParameter("username")
                .passwordParameter("password")
                .defaultSuccessUrl("/Transaction", true)
                .permitAll()
                .and()
                .logout()
                .logoutUrl("/logout")
                .permitAll()
                .and()
                .csrf().disable();


    }

    @Autowired
    private DataSource dataSource;

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {

        auth.jdbcAuthentication()
                .passwordEncoder(passwordEncoder())
                .dataSource(dataSource)
                .usersByUsernameQuery("select email, password, enabled from user where email=?")
//                 .authoritiesByUsernameQuery("select CONCAT('ROLE_', p.description) from user u\n" +
                .authoritiesByUsernameQuery("select u.email, p.description from user u\n" +
                        "inner join user_permission up on up.user_id = u.id\n" +
                        "inner join permission p on p.id = up.permission_id\n" +
                        "where u.email=?");
    }

}
