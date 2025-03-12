package com.fptaptech.demo2.DAO;

import com.fptaptech.demo2.model.Book;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class BookDAO {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("libraryPU");

    private EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    // 1️⃣ Lấy danh sách tất cả sách
    public List<Book> getAllBooks() {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Book> query = em.createQuery("SELECT b FROM Book b", Book.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // 2️⃣ Thêm sách mới
    public boolean addBook(Book book) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            book.setStatus(book.getQuantity() > 0 ? "AVAILABLE" : "OUT_OF_STOCK");
            em.persist(book);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // 3️⃣ Sửa thông tin sách
    public boolean updateBook(Book book) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Book existingBook = em.find(Book.class, book.getId());
            if (existingBook != null) {
                existingBook.setTitle(book.getTitle());
                existingBook.setAuthor(book.getAuthor());
                existingBook.setQuantity(book.getQuantity());
                existingBook.setStatus(book.getQuantity() > 0 ? "AVAILABLE" : "OUT_OF_STOCK");
                em.merge(existingBook);
                em.getTransaction().commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // 4️⃣ Xóa sách theo ID
    public boolean deleteBook(int bookId) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Book book = em.find(Book.class, bookId);
            if (book != null) {
                em.remove(book);
                em.getTransaction().commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // 5️⃣ Cập nhật số lượng sách sau khi mượn/trả
    public boolean updateBookQuantity(int bookId, int newQuantity) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Book book = em.find(Book.class, bookId);
            if (book != null) {
                book.setQuantity(newQuantity);
                book.setStatus(newQuantity > 0 ? "AVAILABLE" : "OUT_OF_STOCK");
                em.merge(book);
                em.getTransaction().commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // 6️⃣ Lấy sách theo ID
    public Book getBookById(int bookId) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Book.class, bookId);
        } finally {
            em.close();
        }
    }

    // Optional: Close EntityManagerFactory when application shuts down
    public static void closeEntityManagerFactory() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}