package com.fptaptech.securityp1.service;

import com.fptaptech.securityp1.model.Role;
import com.fptaptech.securityp1.model.User;
import com.fptaptech.securityp1.repository.RoleRepository;
import com.fptaptech.securityp1.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    private final CustomUserDetailsService userDetailsService;
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    @Autowired
    public CustomOAuth2UserService(CustomUserDetailsService userDetailsService,
                                   UserRepository userRepository,
                                   RoleRepository roleRepository) {
        this.userDetailsService = userDetailsService;
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) {
        OAuth2User oAuth2User = super.loadUser(userRequest);

        String email = oAuth2User.getAttribute("email");
        if (email == null || email.isEmpty()) {
            throw new IllegalStateException("Email không được cung cấp bởi OAuth2 provider.");
        }

        String username = email;
        UserDetails userDetails = null;
        try {
            userDetails = userDetailsService.loadUserByUsername(username);
        } catch (UsernameNotFoundException e) {
            userDetails = createAndSaveNewUser(username);
            System.out.println("Tạo người dùng mới với username: " + username);
        }

        return new DefaultOAuth2User(
                Collections.singletonList(() -> "ROLE_USER"),
                oAuth2User.getAttributes(),
                "email"
        );
    }

    private UserDetails createAndSaveNewUser(String username) {
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword("{noop}no-password");

        // Lấy ROLE_USER từ database
        Role userRole = roleRepository.findByName("ROLE_USER");
        if (userRole == null) {
            userRole = new Role();
            userRole.setName("ROLE_USER");
            roleRepository.save(userRole);
        }
        newUser.setRoles(Collections.singleton(userRole));

        userRepository.save(newUser);

        Set<GrantedAuthority> authorities = newUser.getRoles().stream()
                .map(role -> new SimpleGrantedAuthority(role.getName()))
                .collect(Collectors.toSet());
        return new org.springframework.security.core.userdetails.User(
                newUser.getUsername(),
                newUser.getPassword(),
                authorities
        );
    }
}