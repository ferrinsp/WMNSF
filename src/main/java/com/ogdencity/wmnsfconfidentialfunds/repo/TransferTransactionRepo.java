package com.ogdencity.wmnsfconfidentialfunds.repo;

import com.ogdencity.wmnsfconfidentialfunds.model.TransferTransaction;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by Tyler on 6/4/2015.
 */
public interface TransferTransactionRepo extends JpaRepository<TransferTransaction, Long> {
    List<TransferTransaction> findByCreditUserIdOrDebitUserId(long creditId, long debitId);
}
