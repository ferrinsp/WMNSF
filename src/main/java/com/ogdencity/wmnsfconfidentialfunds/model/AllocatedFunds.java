package com.ogdencity.wmnsfconfidentialfunds.model;

import javax.persistence.*;

@Entity
@Table(name="allocatedfunds")
public class AllocatedFunds {

	@Id
    @GeneratedValue( strategy = GenerationType.IDENTITY)
    private Long id;
	private FundType fund;
	private int allocatedBalance;
	private int remainingBalance;
	
	public FundType getFund() {
		return fund;
	}
	public void setFund(FundType fund) {
		this.fund = fund;
	}
	public int getAllocatedBalance() {
		return allocatedBalance;
	}
	public void setAllocatedBalance(int allocatedBalance) {
		this.allocatedBalance = allocatedBalance;
	}
	public int getRemainingBalance() {
		return remainingBalance;
	}
	public void setRemainingBalance(int remainingBalance) {
		this.remainingBalance = remainingBalance;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((fund == null) ? 0 : fund.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		String other = (String) obj;
		if (fund == null) {
			if (other != null)
				return false;
		} else if (fund.getDescription().equals(other))
			return true;
		return false;
	}
	
	public boolean changeAllocatedBalance(int value){
		if(value > 0) return addToAllocatedBalance(value);
		if(value < 0) return subFromAllocatedBalance(value * -1);
		return false;
	}
	public boolean changeRemainingBlanace(int value){
		if(value > 0) return addToRemainingBalance(value);
		if(value < 0) return subFromRemainingBalance(value * -1);
		return false;
	}
	private boolean subFromRemainingBalance(int value) {
		if(remainingBalance >= value){
			remainingBalance -= value;
			return true;
		}
		return false;
	}
	private boolean addToRemainingBalance(int value) {
		if(allocatedBalance >= remainingBalance + value){
			remainingBalance += value;
			return true;
		}
		return false;
	}
	private boolean subFromAllocatedBalance(int value) {
		if(remainingBalance >= value){
			allocatedBalance -= value;
			remainingBalance -= value;
			return true;
		}
		return false;
	}
	private boolean addToAllocatedBalance(int value) {
		if(value > 0) {
			allocatedBalance += value;
			return true;
		}
		return false;
	}
}
