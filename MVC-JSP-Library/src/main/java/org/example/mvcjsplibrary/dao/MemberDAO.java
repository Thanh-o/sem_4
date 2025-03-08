package org.example.mvcjsplibrary.dao;

import jakarta.persistence.EntityManager;
import org.example.mvcjsplibrary.entity.Member;
import org.example.mvcjsplibrary.util.HibernateUtil;

import java.util.List;

public class MemberDAO {
    public void save(Member member) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(member);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public List<Member> findAll() {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            return em.createQuery("FROM Member", Member.class).getResultList();
        } finally {
            em.close();
        }
    }

    public Member findById(Long id) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            return em.find(Member.class, id);
        } finally {
            em.close();
        }
    }

    public void update(Member member) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(member);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}