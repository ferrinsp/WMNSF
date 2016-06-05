package com.ogdencity.wmnsfconfidentialfunds.model;

import javax.persistence.*;

public class AllocatedFunds {
	private final FundType fund;
	private int balance;
	private int allocatedBalance;

	public AllocatedFunds(FundType f){
		fund = f;
		allocatedBalance = 0;
		balance = 0;
	}
	public void addToBalance(int value){
		balance += value;
	}
	
	public void subFromBalance(int value){
		balance -= value;
	}
	public void addToAllocated(int value){
		allocatedBalance += value;
		balance += value;
	}
	
	public void subFromAllocated(int value){
		allocatedBalance -= value;
		balance -= value;
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
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AllocatedFunds other = (AllocatedFunds) obj;
		if (fund == null) {
			if (other.fund != null)
				return false;
		} else if (!fund.equals(other.fund))
			return false;
		return true;
	}
	
}
