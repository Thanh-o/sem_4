package org.example.springbootiocdibeantransactionalorm.controller;

import org.example.springbootiocdibeantransactionalorm.entity.Product;
import org.example.springbootiocdibeantransactionalorm.service.CategoryService;
import org.example.springbootiocdibeantransactionalorm.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
@RequestMapping("/products")
public class ProductController {

    private final ProductService productService;
    private final CategoryService categoryService;

    @Autowired
    public ProductController(ProductService productService, CategoryService categoryService) {
        this.productService = productService;
        this.categoryService = categoryService;
    }

    @GetMapping
    public String listProducts(Model model) {
        model.addAttribute("products", productService.getAllProducts());
        return "product/list";
    }

    @GetMapping("/{id}")
    public String getProductById(@PathVariable Long id, Model model) {
        model.addAttribute("product", productService.getProductById(id));
        return "product/detail";
    }

    @GetMapping("/new")
    public String showProductForm(Model model) {
        model.addAttribute("product", new Product());
        model.addAttribute("categories", categoryService.getAllCategories());
        return "product/form";
    }

    @PostMapping
    public String createProduct(@ModelAttribute Product product) {
        productService.createProduct(product);
        return "redirect:/products";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Optional<Product> product = productService.getProductById(id);

        if (product.isEmpty()) {
            return "redirect:/products?error=ProductNotFound";
        }

        model.addAttribute("product", product.get());
        model.addAttribute("categories", categoryService.getAllCategories());
        return "product/form";
    }

    @PostMapping("/update/{id}")
    public String updateProduct(@PathVariable Long id,
                                @ModelAttribute Product product,
                                Model model) {
        try {
            productService.updateProduct(id, product);
            return "redirect:/products?success=ProductUpdated";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("categories", categoryService.getAllCategories());
            return "product/form";
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable Long id) {
        productService.deleteProduct(id);
        return "redirect:/products";
    }
}