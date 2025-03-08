package org.example.mvcjsplibrary.dao;

import jakarta.persistence.EntityManager;
import org.example.mvcjsplibrary.entity.Loan;
import org.example.mvcjsplibrary.util.HibernateUtil;

import java.util.List;

public class LoanDAO {
    public void save(Loan loan) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(loan);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public List<Loan> findAll() {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            return em.createQuery("FROM Loan", Loan.class).getResultList();
        } finally {
            em.close();
        }
    }

    public Loan findById(Long id) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            return em.find(Loan.class, id);
        } finally {
            em.close();
        }
    }

    public void update(Loan loan) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(loan);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}