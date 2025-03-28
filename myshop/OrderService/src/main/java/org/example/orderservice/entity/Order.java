package org.example.orderservice.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Getter
@Setter
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long userId; // Liên kết với User từ UserService

    @Column(nullable = false)
    private double totalPrice; // Tổng giá trị đơn hàng

    @Column(nullable = false)
    private LocalDateTime orderDate; // Thời gian đặt hàng

    private String status; // Trạng thái đơn hàng (PENDING, COMPLETED, CANCELLED, ...)

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<OrderProduct> products = new HashSet<>(); // Quan hệ One-to-Many với OrderProduct
}