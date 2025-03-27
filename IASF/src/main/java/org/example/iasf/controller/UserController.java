package org.example.iasf.controller;

import org.example.iasf.entity.User;
import org.example.iasf.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    // List all users
    @GetMapping("/")
    public String listUsers(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        model.addAttribute("user", new User()); // For the add form
        return "list";
    }

    // Create - Process form
    @PostMapping("/")
    public String addUser(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        try {
            userService.saveUser(user);
            redirectAttributes.addFlashAttribute("successMessage", "User created successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Error while creating User: Unable to create. A User with name '" + user.getName() + "' already exists");
        }
        return "redirect:/";
    }

    // Update - Show edit form
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        model.addAttribute("user", userService.getUserById(id));
        model.addAttribute("users", userService.getAllUsers());
        return "list";
    }

    // Update - Process form
    @PostMapping("/update/{id}")
    public String updateUser(@PathVariable Long id, @ModelAttribute User user,
                             RedirectAttributes redirectAttributes) {
        try {
            userService.updateUser(id, user);
            redirectAttributes.addFlashAttribute("successMessage", "User updated successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Error while updating User: Unable to update. A User with name '" + user.getName() + "' already exists");
        }
        return "redirect:/";
    }

    // Delete
    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable Long id,
                             RedirectAttributes redirectAttributes) {
        try {
            User user = userService.getUserById(id);
            userService.deleteUser(id);
            redirectAttributes.addFlashAttribute("successMessage", "User '" + user.getName() + "' deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Error while deleting User: Unable to delete user with ID " + id);
        }
        return "redirect:/";
    }
}