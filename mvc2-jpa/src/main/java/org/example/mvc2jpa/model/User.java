package org.example.mvc2jpa.model;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "username", nullable = false)
    private String username;
    @Column(name = "email", nullable = false)
    private String email;

    public User(String username, String email) {
    }

    public User() {

    }

//    @OneToMany
//    private List<Account> accounts = new ArrayList<>();


}
