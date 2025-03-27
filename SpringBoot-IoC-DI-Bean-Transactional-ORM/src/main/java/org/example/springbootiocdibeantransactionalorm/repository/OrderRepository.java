package org.example.springbootiocdibeantransactionalorm.repository;

import org.example.springbootiocdibeantransactionalorm.entity.Order;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    // Tải Order cùng với products và customer bằng JOIN FETCH
    @Query("SELECT o FROM Order o LEFT JOIN FETCH o.products LEFT JOIN FETCH o.customer WHERE o.id = :id")
    Optional<Order> findByIdWithDetails(@Param("id") Long id);

    // Tải tất cả Order cùng với products và customer bằng JOIN FETCH
    @Query("SELECT o FROM Order o LEFT JOIN FETCH o.products LEFT JOIN FETCH o.customer")
    List<Order> findAllWithDetails();

    // Sử dụng EntityGraph để tải Order theo ID với products và customer
    @EntityGraph(attributePaths = {"products", "customer"})
    Optional<Order> findById(Long id);

    // Sử dụng EntityGraph để tải tất cả Order với products và customer
    @EntityGraph(attributePaths = {"products", "customer"})
    List<Order> findAll();
}