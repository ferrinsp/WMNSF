package com.ogdencity.wmnsfconfidentialfunds.model;

import javax.persistence.*;

/**
 * Created by tyler on 5/16/15.
 */
@Entity
public class Permission {

    @Id
    @GeneratedValue( strategy = GenerationType.IDENTITY)
    private Long id;
    private String description;

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
}
