package org.example.orderservice.service;

import org.example.orderservice.dto.*;
import org.example.orderservice.entity.Order;
import org.example.orderservice.entity.OrderProduct;
import org.example.orderservice.repository.OrderProductRepository;
import org.example.orderservice.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderProductRepository orderProductRepository;

    @Autowired
    private RestTemplate restTemplate;

    private static final String PRODUCT_SERVICE_URL = "http://localhost:8082/api/products";

    public List<OrderResponseDto> getAllOrders() {
        List<Order> orders = orderRepository.findAll();
        return orders.stream()
                .map(this::mapToOrderResponseDto)
                .collect(Collectors.toList());
    }

    @Transactional
    public OrderResponseDto createOrder(Long userId, OrderRequestDto requestDto) {
        if (requestDto == null || requestDto.getProductQuantities() == null || requestDto.getProductQuantities().isEmpty()) {
            throw new IllegalArgumentException("Danh sách sản phẩm không được trống!");
        }

        Order order = new Order();
        order.setUserId(userId);
        order.setOrderDate(LocalDateTime.now());
        order.setStatus("PENDING");

        Set<OrderProduct> orderProducts = new HashSet<>();
        double totalPrice = 0.0;

        for (var entry : requestDto.getProductQuantities().entrySet()) {
            Long productId = entry.getKey();
            int quantity = entry.getValue();

            if (quantity <= 0) {
                throw new IllegalArgumentException("Số lượng sản phẩm " + productId + " phải lớn hơn 0!");
            }

            ProductDto product = restTemplate.getForObject(PRODUCT_SERVICE_URL + "/" + productId, ProductDto.class);
            if (product == null) {
                throw new RuntimeException("Sản phẩm " + productId + " không tồn tại!");
            }
            if (product.getStock() < quantity) {
                throw new RuntimeException("Sản phẩm " + productId + " không đủ số lượng trong kho!");
            }

            OrderProduct orderProduct = new OrderProduct();
            orderProduct.setOrder(order);
            orderProduct.setProductId(productId);
            orderProduct.setQuantity(quantity);
            orderProducts.add(orderProduct);

            totalPrice += product.getPrice() * quantity;
            updateProductStock(productId, product.getStock() - quantity);
        }

        order.setProducts(orderProducts);
        order.setTotalPrice(totalPrice);

        Order savedOrder = orderRepository.save(order);
        return mapToOrderResponseDto(savedOrder);
    }

    public OrderResponseDto getOrderById(Long orderId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng với ID: " + orderId));
        return mapToOrderResponseDto(order);
    }

    @Transactional
    public OrderResponseDto updateOrderStatus(Long orderId, String newStatus) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng với ID: " + orderId));

        if (!isValidStatus(newStatus)) {
            throw new IllegalArgumentException("Trạng thái không hợp lệ: " + newStatus);
        }

        order.setStatus(newStatus);
        Order updatedOrder = orderRepository.save(order);
        return mapToOrderResponseDto(updatedOrder);
    }

    @Transactional
    public OrderResponseDto cancelOrder(Long orderId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng với ID: " + orderId));

        if (!order.getStatus().equals("PENDING")) {
            throw new IllegalStateException("Chỉ có thể hủy đơn hàng ở trạng thái PENDING!");
        }

        order.setStatus("CANCELLED");
        for (OrderProduct orderProduct : order.getProducts()) {
            ProductDto product = restTemplate.getForObject(PRODUCT_SERVICE_URL + "/" + orderProduct.getProductId(), ProductDto.class);
            if (product != null) {
                updateProductStock(orderProduct.getProductId(), product.getStock() + orderProduct.getQuantity());
            }
        }

        Order cancelledOrder = orderRepository.save(order);
        return mapToOrderResponseDto(cancelledOrder);
    }

    public List<OrderResponseDto> getOrdersByUserId(Long userId) {
        List<Order> orders = orderRepository.findByUserId(userId);
        return orders.stream()
                .map(this::mapToOrderResponseDto)
                .collect(Collectors.toList());
    }

    @Transactional
    public void deleteOrder(Long orderId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng với ID: " + orderId));

        if (!order.getStatus().equals("PENDING")) {
            throw new IllegalStateException("Chỉ có thể xóa đơn hàng ở trạng thái PENDING!");
        }

        orderRepository.delete(order); // Cascade sẽ xóa các OrderProduct liên quan
    }

    private void updateProductStock(Long productId, int newStock) {
        ProductDto currentProduct = restTemplate.getForObject(PRODUCT_SERVICE_URL + "/" + productId, ProductDto.class);
        if (currentProduct == null) {
            throw new RuntimeException("Không tìm thấy sản phẩm với ID: " + productId);
        }
        currentProduct.setStock(newStock);
        restTemplate.put(PRODUCT_SERVICE_URL + "/" + productId, currentProduct);
    }

    private OrderResponseDto mapToOrderResponseDto(Order order) {
        OrderResponseDto responseDto = new OrderResponseDto();
        responseDto.setId(order.getId());
        responseDto.setUserId(order.getUserId());
        responseDto.setTotalPrice(order.getTotalPrice());
        responseDto.setOrderDate(order.getOrderDate());
        responseDto.setStatus(order.getStatus());

        List<OrderProductDto> productDtos = order.getProducts().stream()
                .map(op -> {
                    OrderProductDto dto = new OrderProductDto();
                    dto.setProductId(op.getProductId());
                    dto.setQuantity(op.getQuantity());
                    return dto;
                })
                .collect(Collectors.toList());
        responseDto.setProducts(productDtos);

        return responseDto;
    }

    private boolean isValidStatus(String status) {
        return status != null && List.of("PENDING", "COMPLETED", "CANCELLED").contains(status.toUpperCase());
    }
}