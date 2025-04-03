package org.example.fetchtypeproblems.repository;

import jakarta.persistence.Entity;
import org.example.fetchtypeproblems.model.Author;
import org.example.fetchtypeproblems.model.Book;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
//    Cach 1: dung JPQL
    @Query("select b from Book b join b.authors where b.id = :id")
    Optional<Book> findBookWithAuthors(@Param("id") Long id);

//    Cach 2: EntityGraph
    @EntityGraph(attributePaths = "authors")
    Optional<Book> findById(@Param("id") Long id);

    @EntityGraph(attributePaths = "authors")
    List<Book> findAll();
}
