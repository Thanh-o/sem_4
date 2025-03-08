package com.example.librarysystem.dao;

import com.example.librarysystem.model.Book;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class BookDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("libraryPU");

    public void addBook(Book book) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(book);
        em.getTransaction().commit();
        em.close();
    }

    public void updateBook(Long id, String title, String author) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        Book book = em.find(Book.class, id);
        if (book != null) {
            book.setTitle(title);
            book.setAuthor(author);
        }
        em.getTransaction().commit();
        em.close();
    }

    public void deleteBook(Long id) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        Book book = em.find(Book.class, id);
        if (book != null) {
            em.remove(book);
        }
        em.getTransaction().commit();
        em.close();
    }
}

