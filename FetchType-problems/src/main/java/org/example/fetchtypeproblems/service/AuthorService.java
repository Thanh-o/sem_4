package org.example.fetchtypeproblems.service;

import org.example.fetchtypeproblems.model.Author;
import org.example.fetchtypeproblems.repository.AuthorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AuthorService {
    @Autowired
    private AuthorRepository authorRepository;

    @Transactional(readOnly = true)
    public Author findAuthorById(Long id) {
        return authorRepository.findById(id).orElseThrow();
    }

    @Transactional(readOnly = true)
    public List<Author> findAllAuthors() {
        return authorRepository.findAll();
    }
}
