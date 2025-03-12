package com.fptaptech.demo2.DAO;

import com.fptaptech.demo2.model.Transaction;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.time.LocalDateTime;
import java.util.List;

public class TransactionDAO {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("libraryPU");

    private EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    // ✅ Mượn sách
    public boolean borrowBook(int userId, int bookId) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Transaction transaction = new Transaction();
            transaction.setUserId(userId);
            transaction.setBookId(bookId);
            transaction.setBorrowDate(LocalDateTime.now());
            transaction.setDueDate(LocalDateTime.now().plusDays(14));
            transaction.setStatus("BORROWED");
            em.persist(transaction);
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

    // ✅ Trả sách
    public boolean returnBook(int transactionId) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Transaction transaction = em.find(Transaction.class, transactionId);
            if (transaction != null && "BORROWED".equals(transaction.getStatus())) {
                transaction.setReturnDate(LocalDateTime.now());
                transaction.setStatus("RETURNED");
                em.merge(transaction);
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

    // ✅ Lấy danh sách giao dịch của user (hoặc tất cả nếu userId == -1)
    public List<Transaction> getUserTransactions(int userId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = """
                SELECT NEW com.fptaptech.demo2.model.Transaction(
                    t.id, t.userId, u.username, t.bookId, COALESCE(b.title, 'Sách đã bị xóa'),
                    t.borrowDate, t.dueDate, t.returnDate, t.status
                )
                FROM Transaction t
                LEFT JOIN Book b ON t.bookId = b.id
                LEFT JOIN User u ON t.userId = u.id
            """ + (userId != -1 ? " WHERE t.userId = :userId" : "") + " ORDER BY t.borrowDate DESC";

            TypedQuery<Transaction> query = em.createQuery(jpql, Transaction.class);
            if (userId != -1) {
                query.setParameter("userId", userId);
            }
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // ✅ Xóa giao dịch
    public boolean deleteTransaction(int transactionId) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Transaction transaction = em.find(Transaction.class, transactionId);
            if (transaction != null) {
                em.remove(transaction);
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

    // Optional: Close EntityManagerFactory when application shuts down
    public static void closeEntityManagerFactory() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}