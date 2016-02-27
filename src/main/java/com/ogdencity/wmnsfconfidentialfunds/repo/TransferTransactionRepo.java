package com.ogdencity.wmnsfconfidentialfunds.repo;

import com.ogdencity.wmnsfconfidentialfunds.model.TransferTransaction;
import com.ogdencity.wmnsfconfidentialfunds.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;

/*Created by Tyler on 6/4/2015.*/
public interface TransferTransactionRepo extends JpaRepository<TransferTransaction, Long> {
    List<TransferTransaction> findByCreditUserIdOrDebitUserId(long creditId, long debitId);
    
    @Query("select t FROM TransferTransaction t ORDER BY t.date")
    List<TransferTransaction> getAllTransactions();

    @Query("select t FROM TransferTransaction t WHERE t.debitUser = :user AND t.date BETWEEN :startDate AND :endDate")
    List<TransferTransaction> getDebitUserBetween(@Param("startDate") Date startDate,@Param("endDate") Date endDate,@Param("user") User user);

    @Query("select t FROM TransferTransaction t WHERE t.creditUser = :user AND t.date BETWEEN :startDate AND :endDate")
    List<TransferTransaction> getCreditUserBetween(@Param("startDate") Date startDate,@Param("endDate") Date endDate,@Param("user") User user);

    @Query("select t FROM TransferTransaction t WHERE t.operatorUser = :user AND t.date BETWEEN :startDate AND :endDate")
    List<TransferTransaction> getOperatorUserBetween(@Param("startDate") Date startDate,@Param("endDate") Date endDate,@Param("user") User user);
}
