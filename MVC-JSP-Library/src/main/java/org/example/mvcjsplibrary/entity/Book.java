package org.example.mvcjsplibrary.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Book")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    private String author;

    @Column(unique = true)
    private String isbn;

    private boolean available = true;
}