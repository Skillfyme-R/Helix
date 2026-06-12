/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/.
 *
 * HelixEMR – Helix Health Electronic Medical Record System
 * Copyright (C) 2024 Helix Health <https://helixhealth.io>
 */
package io.helixhealth.emr.web;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.header.writers.ReferrerPolicyHeaderWriter;

/** Spring Security configuration for HelixEMR. */
@Configuration
@EnableWebSecurity
public class HelixSecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            // Authorization rules
            .authorizeHttpRequests(auth -> auth
                // Public endpoints
                .requestMatchers(
                    "/helixemr/login",
                    "/helixemr/setup/**",
                    "/helixemr/health/**",
                    "/helixemr/images/**",
                    "/helixemr/css/**",
                    "/helixemr/js/**",
                    "/helixemr/static/**"
                ).permitAll()
                // REST API requires authentication
                .requestMatchers("/helixemr/api/**").authenticated()
                // All other requests require authentication
                .anyRequest().authenticated()
            )
            // Form login
            .formLogin(form -> form
                .loginPage("/helixemr/login")
                .loginProcessingUrl("/helixemr/loginServlet")
                .defaultSuccessUrl("/helixemr/dashboard", true)
                .failureUrl("/helixemr/login?error=true")
                .usernameParameter("username")
                .passwordParameter("password")
            )
            // Logout
            .logout(logout -> logout
                .logoutUrl("/helixemr/logout")
                .logoutSuccessUrl("/helixemr/login?logout=true")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID", "HELIX_SESSION")
            )
            // Session management
            .sessionManagement(session -> session
                .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
                .maximumSessions(3)
                .expiredUrl("/helixemr/login?sessionExpired=true")
            )
            // Security headers
            .headers(headers -> headers
                .frameOptions(frame -> frame.sameOrigin())
                .contentSecurityPolicy(csp -> csp
                    .policyDirectives(
                        "default-src 'self'; "
                        + "script-src 'self' 'unsafe-inline' https://code.jquery.com; "
                        + "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; "
                        + "font-src 'self' https://fonts.gstatic.com; "
                        + "img-src 'self' data:; "
                        + "connect-src 'self';"
                    )
                )
                .referrerPolicy(referrer ->
                    referrer.policy(ReferrerPolicyHeaderWriter.ReferrerPolicy.STRICT_ORIGIN_WHEN_CROSS_ORIGIN)
                )
            )
            // CSRF protection (enabled by default; exclude REST API if using token-based auth)
            .csrf(csrf -> csrf
                .ignoringRequestMatchers("/helixemr/api/**")
            );

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(12);
    }
}
