package com.ogdencity.wmnsfconfidentialfunds.repo;

import com.ogdencity.wmnsfconfidentialfunds.model.FundType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.persistence.JoinTable;
import java.util.Date;
import java.util.List;

/**
 * Created by Tyler on 6/5/2015.
 */
public interface FundTypeRepo extends JpaRepository<FundType, Long> {
    List<FundType> findByEffectiveStartBeforeAndEffectiveEndAfter(Date start, Date end);
    FundType findById(long id);
}
