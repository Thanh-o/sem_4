package org.example.mvcjsplibrary.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class HibernateUtil {
    private static final EntityManagerFactory entityManagerFactory;

    static {
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("libraryPU");
        } catch (Throwable ex) {
            System.err.println("Initial EntityManagerFactory creation failed: " + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    // Lấy EntityManager từ factory
    public static EntityManager getEntityManager() {
        return entityManagerFactory.createEntityManager();
    }

    // Đóng EntityManagerFactory khi ứng dụng shutdown
    public static void shutdown() {
        if (entityManagerFactory != null && entityManagerFactory.isOpen()) {
            entityManagerFactory.close();
        }
    }

    // Getter để lấy EntityManagerFactory (nếu cần)
    public static EntityManagerFactory getEntityManagerFactory() {
        return entityManagerFactory;
    }
}