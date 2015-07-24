package com.ogdencity.wmnsfconfidentialfunds.repo;

import com.ogdencity.wmnsfconfidentialfunds.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by tyler on 5/16/15.
 */
public interface UserRepo extends JpaRepository<User, Long>{
    List<User> findByEmail(String email);
    List<User> findByEnabledTrue();
    User findById(long id);
}
