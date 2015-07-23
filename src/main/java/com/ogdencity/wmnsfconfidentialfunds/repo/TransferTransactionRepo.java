package com.ogdencity.wmnsfconfidentialfunds.repo;

import com.ogdencity.wmnsfconfidentialfunds.model.TransferTransaction;
import com.ogdencity.wmnsfconfidentialfunds.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Date;
import java.util.List;

/**
 * Created by Tyler on 6/4/2015.
 */
public interface TransferTransactionRepo extends JpaRepository<TransferTransaction, Long> {
    List<TransferTransaction> findByCreditUserIdOrDebitUserId(long creditId, long debitId);

    //@Query("select t from TransferTransaction t where t.date and date > ?1 and t.date < ?2 ")//and (t.DebitUser = ?1 or t.CreditUser = ?1)

    @Query("select t FROM TransferTransaction t WHERE t.date BETWEEN (:?1, :?2) AND (t.debitUser = :?3 OR t.creditUser = :?3")
    List<TransferTransaction> test(Date start, Date end);
}
