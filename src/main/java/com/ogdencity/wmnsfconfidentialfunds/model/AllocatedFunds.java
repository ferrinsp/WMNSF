package com.ogdencity.wmnsfconfidentialfunds.model;

import javax.persistence.*;

public class AllocatedFunds {
	private final FundType fund;
	private int balance;
	public int getBalance() {
		return balance;
	}
	public void setBalance(int balance) {
		this.balance = balance;
	}
	public int getAllocatedBalance() {
		return allocatedBalance;
	}
	public void setAllocatedBalance(int allocatedBalance) {
		this.allocatedBalance = allocatedBalance;
	}
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
	public String getDescription(){
		return fund.getDescription();
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
		FundType other = (FundType) obj;
		return sameFund(other);
	}
	private boolean sameFund(FundType ft){
		return ft.equals(fund);
	}
	
}
