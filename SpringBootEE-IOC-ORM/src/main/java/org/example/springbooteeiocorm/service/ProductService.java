package org.example.springbooteeiocorm.service;

import jakarta.transaction.Transactional;
import org.example.springbooteeiocorm.entity.Product;
import org.example.springbooteeiocorm.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductService {
    private final ProductRepository productRepository;

    @Autowired
    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }
    @Transactional
    public Product saveProduct(Product product) {
        return productRepository.save(product);
    }

}
