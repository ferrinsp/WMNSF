package com.ogdencity.wmnsfconfidentialfunds.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

import org.hibernate.annotations.Type;

/**
 * Created by Tyler on 6/5/2015.
 */
@Entity
@Table(name="fund_type")
public class FundType implements Serializable {
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;
	
    private String description;
    private Date effectiveStart;
    private Date effectiveEnd;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getEffectiveStart() {
        return effectiveStart;
    }

    public void setEffectiveStart(Date effectiveStart) {
        this.effectiveStart = effectiveStart;
    }

    public Date getEffectiveEnd() {
        return effectiveEnd;
    }

    public void setEffectiveEnd(Date effectiveEnd) {
        this.effectiveEnd = effectiveEnd;
    }
}
