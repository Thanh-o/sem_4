package org.example.fetchtypeproblems.config;

import org.example.fetchtypeproblems.model.Author;
import org.example.fetchtypeproblems.model.Book;
import org.example.fetchtypeproblems.repository.AuthorRepository;
import org.example.fetchtypeproblems.repository.BookRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;

@Configuration
public class AppConfig {

//    @Bean
//    @Transactional
//    public CommandLineRunner dataLoader(AuthorRepository authorRepository, BookRepository bookRepository) {
//        return args -> {
//            Author author1 = new Author();
//            author1.setName("Le Cong Hong Phuc");
//
//            Author author2 = new Author();
//            author2.setName("Le Dinh Nguyen");
//
//            Author author3 = new Author();
//            author3.setName("Tran Minh Vu");
//
//            authorRepository.saveAll(Set.of(author1, author2, author3));
//
//            Book book1 = new Book();
//            book1.setTitle("Harry Potter and the Sorcerer's Stone");
//            book1.setDescription("Fantasy novel about a young wizard.");
//            book1.setAuthors(Set.of(author1));
//
//            Book book2 = new Book();
//            book2.setTitle("A Game of Thrones");
//            book2.setDescription("First book in A Song of Ice and Fire series.");
//            book2.setAuthors(Set.of(author2));
//
//            Book book3 = new Book();
//            book3.setTitle("The Lord of the Rings");
//            book3.setDescription("Epic fantasy novel.");
//            book3.setAuthors(Set.of(author3));
//
//            Book book4 = new Book();
//            book4.setTitle("Fantastic Beasts and Where to Find Them");
//            book4.setDescription("Companion book to the Harry Potter series.");
//            book4.setAuthors(Set.of(author1));
//
//            bookRepository.saveAll(Set.of(book1, book2, book3, book4));
//
//            author1.getBooks().addAll(Set.of(book1, book4));
//            author2.getBooks().add(book2);
//            author3.getBooks().add(book3);
//
//            authorRepository.saveAll(Set.of(author1, author2, author3));
//
//            System.out.println("✅ Sample data loaded successfully!");
//        };
//    }
}
