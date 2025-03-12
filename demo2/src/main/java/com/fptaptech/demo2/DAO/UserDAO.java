package com.fptaptech.demo2.DAO;

import com.fptaptech.demo2.model.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

public class UserDAO {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("libraryPU");

    private EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    // ✅ Lấy user theo username
    public User getUserByUsername(String username) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u WHERE u.username = :username", User.class
            );
            query.setParameter("username", username);
            return query.getSingleResult(); // Trả về user hoặc ném exception nếu không tìm thấy
        } catch (jakarta.persistence.NoResultException e) {
            return null; // ❌ Trả về null nếu không tìm thấy user
        } catch (Exception e) {
            e.printStackTrace();
            return null;
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