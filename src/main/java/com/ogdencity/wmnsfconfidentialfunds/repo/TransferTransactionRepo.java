package com.ogdencity.wmnsfconfidentialfunds.repo;

import com.ogdencity.wmnsfconfidentialfunds.model.TransferTransaction;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Tyler on 6/4/2015.
 */
public interface TransferTransactionRepo extends JpaRepository<TransferTransaction, Long> {
}
