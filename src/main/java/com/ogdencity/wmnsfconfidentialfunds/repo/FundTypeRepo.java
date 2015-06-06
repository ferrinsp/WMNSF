package com.ogdencity.wmnsfconfidentialfunds.repo;

import com.ogdencity.wmnsfconfidentialfunds.model.FundType;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Tyler on 6/5/2015.
 */
public interface FundTypeRepo extends JpaRepository<FundType, Long> {
}
