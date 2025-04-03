package org.example.fetchtypeproblems.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;


import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "books")
@Getter
@Setter
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String description;

    @ManyToMany(fetch = FetchType.LAZY)

    private Set<Author> authors = new HashSet<>();

}
