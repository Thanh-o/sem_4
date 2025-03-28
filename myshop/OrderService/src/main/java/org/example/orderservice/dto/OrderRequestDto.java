package org.example.orderservice.dto;

import lombok.Data;

import java.util.Map;

@Data
public class OrderRequestDto {
    private Map<Long, Integer> productQuantities; // Map<productId, quantity>
}