package org.example.fetchtypeproblems.controller;

import org.example.fetchtypeproblems.model.Author;
import org.example.fetchtypeproblems.service.AuthorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/authors")
public class AuthorController {
    @Autowired
    private AuthorService authorService;

    @GetMapping("/{id}")
    public ResponseEntity<Author> getAuthorById(@PathVariable Long id) {
        return ResponseEntity.ok(authorService.findAuthorById(id));
    }
    @GetMapping
    public ResponseEntity<List<Author>> getAllAuthors() {
        return ResponseEntity.ok(authorService.findAllAuthors());
    }

}
