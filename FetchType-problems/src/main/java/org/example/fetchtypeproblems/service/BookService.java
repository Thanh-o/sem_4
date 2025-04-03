package org.example.fetchtypeproblems.service;

import org.example.fetchtypeproblems.model.Book;
import org.example.fetchtypeproblems.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BookService {
    @Autowired
    private BookRepository bookRepository;

//    public Book getBookById(Long id) {
//        return bookRepository.findById(id).orElseThrow();
//    }
    @Transactional(readOnly = true)
    public Book getBookById(Long id) {
//    return bookRepository.findById(id).orElseThrow();
    Book book = bookRepository.findById(id).orElseThrow();
    book.getAuthors().size();
    return book;
    }

    @Transactional
    public Book createBook(Book book) {
        return bookRepository.save(book);
    }

    @Transactional
    public Book updateBook(Long id, Book bookDetails) {
        Book book = bookRepository.findById(id).orElseThrow();
        book.setTitle(bookDetails.getTitle());
        book.setDescription(bookDetails.getDescription());
        book.setAuthors(bookDetails.getAuthors());
        return bookRepository.save(book);
    }

    @Transactional
    public void deleteBook(Long id) {
        Book book = bookRepository.findById(id).orElseThrow();
        bookRepository.delete(book);
    }

    @Transactional(readOnly = true)
    public List<Book> getAllBooks() {
        List<Book> books = bookRepository.findAll();
        books.forEach(book -> book.getAuthors().size()); // Force lazy loading
        return books;
    }
}

