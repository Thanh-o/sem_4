package com.example.librarysystem.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "books")
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    private String author;

    private boolean available = true;

    public Book() {}

    public Book(String title, String author) {
        this.title = title;
        this.author = author;
    }
}
