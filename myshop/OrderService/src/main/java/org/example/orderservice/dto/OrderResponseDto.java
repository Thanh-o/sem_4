package org.example.orderservice.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class OrderResponseDto {
    private Long id;
    private Long userId;
    private double totalPrice;
    private LocalDateTime orderDate;
    private String status;
    private List<OrderProductDto> products;
}