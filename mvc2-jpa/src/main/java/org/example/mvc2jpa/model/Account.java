package org.example.mvc2jpa.model;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Account {
    @Id
    private int id;
    private  Double amount;
    private User user;
}
