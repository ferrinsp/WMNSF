package com.ogdencity.wmnsfconfidentialfunds.repo;

import com.ogdencity.wmnsfconfidentialfunds.model.Permission;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by tyler on 5/17/15.
 */
public interface PermissionRepo extends JpaRepository<Permission, Long> {
    List<Permission> findById(long id);
}
