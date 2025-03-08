package com.example.librarysystem.dao;

import com.example.librarysystem.model.Book;
import com.example.librarysystem.model.Loan;
import com.example.librarysystem.model.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.Date;

public class LoanDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("libraryPU");

    public void loanBook(Long userId, Long bookId, Date returnDate) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        User user = em.find(User.class, userId);
        Book book = em.find(Book.class, bookId);

        if (book != null && book.isAvailable()) {
            book.setAvailable(false);
            Loan loan = new Loan(user, book, new Date(), returnDate);
            em.persist(loan);
        }

        em.getTransaction().commit();
        em.close();
    }

    public void returnBook(Long loanId) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        Loan loan = em.find(Loan.class, loanId);
        if (loan != null) {
            loan.getBook().setAvailable(true);
            em.remove(loan);
        }

        em.getTransaction().commit();
        em.close();
    }
}

