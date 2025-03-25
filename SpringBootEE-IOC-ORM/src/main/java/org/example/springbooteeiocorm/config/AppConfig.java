package org.example.springbooteeiocorm.config;

import org.example.springbooteeiocorm.entity.Category;
import org.example.springbooteeiocorm.entity.Product;
import org.example.springbooteeiocorm.repository.CategoryRepository;
import org.example.springbooteeiocorm.repository.ProductRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {
    @Bean
    public CommandLineRunner LoadData(ProductRepository productRepository, CategoryRepository categoryRepository) {
        return (args) -> {
            categoryRepository.save(new Category("phone","ok"));
            productRepository.save(new Product("iphone",200.2,"new product" ));
        };
    }
}
