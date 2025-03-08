package org.example.mvcjsplibrary.dao;

import org.example.mvcjsplibrary.config.HibernateConfig;
import org.example.mvcjsplibrary.entity.Book;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.util.List;

public class BookDAO {
    public void saveBook(Book book) {
        Transaction transaction = null;
        try (Session session = HibernateConfig.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.persist(book);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public List<Book> getAllBooks() {
        try (Session session = HibernateConfig.getSessionFactory().openSession()) {
            return session.createQuery("from Book", Book.class).list();
        }
    }
}