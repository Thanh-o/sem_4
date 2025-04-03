package org.example.fetchtypeproblems.repository;

import org.example.fetchtypeproblems.model.Author;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AuthorRepository extends JpaRepository<Author, Long> {
    @EntityGraph(attributePaths = "books")
    Optional<Author> findById(@Param("id") Long id);

    @EntityGraph(attributePaths = "books")
    List<Author> findAll();
}
