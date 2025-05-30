<%-- 
    Document   : homePage
    Created on : May 30, 2025, 7:54:42 AM
    Author     : fpt shop
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>CES - Computer Element System</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <style>
            :root {
                --primary-color: #0d6efd;
                --secondary-color: #6c757d;
                --accent-color: #ffc107;
            }
            
            .top-bar {
                background: #2b2b2b;
                color: #fff;
                padding: 8px 0;
                font-size: 14px;
            }
            
            .hero-section {
                background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
                            url('https://images.unsplash.com/photo-1597872200969-2b65d56bd16b?auto=format&fit=crop&q=80');
                background-size: cover;
                background-position: center;
                color: white;
                padding: 120px 0;
            }

            .feature-card {
                text-align: center;
                padding: 30px;
                background: #f8f9fa;
                border-radius: 10px;
                transition: transform 0.3s;
            }

            .feature-card:hover {
                transform: translateY(-10px);
            }

            .feature-icon {
                font-size: 2.5rem;
                color: var(--primary-color);
                margin-bottom: 20px;
            }

            .category-card {
                border: none;
                transition: all 0.3s;
                margin-bottom: 20px;
            }

            .category-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .category-card img {
                height: 200px;
                object-fit: cover;
            }

            .deal-section {
                background: #f8f9fa;
                padding: 60px 0;
            }

            .product-card {
                border: none;
                transition: all 0.3s;
            }

            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .price {
                color: var(--primary-color);
                font-weight: bold;
                font-size: 1.2rem;
            }

            .old-price {
                text-decoration: line-through;
                color: var(--secondary-color);
                margin-right: 10px;
            }

            footer {
                background: #2b2b2b;
                color: #fff;
                padding: 60px 0 30px;
            }

            .social-icons a {
                color: #fff;
                margin-right: 15px;
                font-size: 1.2rem;
            }

            .newsletter-form {
                position: relative;
            }

            .newsletter-form input {
                padding-right: 120px;
            }

            .newsletter-form button {
                position: absolute;
                right: 0;
                top: 0;
                height: 100%;
            }
        </style>
    </head>
    <body>
        <!-- Top Bar -->
        <div class="top-bar">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <i class="fas fa-phone-alt me-2"></i> 24/7 Customer Service: 1-800-123-4567
                    </div>
                    <div class="col-md-6 text-end">
                        <span class="me-3"><i class="fas fa-truck me-1"></i> Free shipping on orders over $100</span>
                        <span><i class="fas fa-map-marker-alt me-1"></i> Track Order</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Navigation -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <i class="fas fa-microchip me-2"></i>
                    <span class="fw-bold">CES</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
                                All Products
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">CPUs</a></li>
                                <li><a class="dropdown-item" href="#">Motherboards</a></li>
                                <li><a class="dropdown-item" href="#">Graphics Cards</a></li>
                                <li><a class="dropdown-item" href="#">Memory (RAM)</a></li>
                                <li><a class="dropdown-item" href="#">Storage</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">New Arrivals</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Today's Deals</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Custom Builds</a>
                        </li>
                    </ul>
                    <form class="d-flex me-3">
                        <div class="input-group">
                            <input type="search" class="form-control" placeholder="Search products...">
                            <button class="btn btn-outline-primary" type="submit">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </form>
                    <div class="d-flex align-items-center">
                        <a href="#" class="btn btn-outline-primary me-2">
                            <i class="fas fa-user me-1"></i> Login
                        </a>
                        <a href="#" class="btn btn-primary me-2">
                            <i class="fas fa-user-plus me-1"></i> Register
                        </a>
                        <a href="#" class="btn btn-outline-primary position-relative">
                            <i class="fas fa-shopping-cart"></i>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                0
                            </span>
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <section class="hero-section">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h1 class="display-4 fw-bold mb-4">Build Your Dream PC</h1>
                        <p class="lead mb-4">Premium computer components at competitive prices. Free expert consultation on custom builds.</p>
                        <a href="#" class="btn btn-primary btn-lg me-2">Shop Now</a>
                        <a href="#" class="btn btn-outline-light btn-lg">Custom Build</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features -->
        <section class="py-5">
            <div class="container">
                <div class="row g-4">
                    <div class="col-md-3">
                        <div class="feature-card">
                            <i class="fas fa-shipping-fast feature-icon"></i>
                            <h5>Free Shipping</h5>
                            <p class="mb-0">On orders over $100</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="feature-card">
                            <i class="fas fa-headset feature-icon"></i>
                            <h5>24/7 Support</h5>
                            <p class="mb-0">Expert assistance</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="feature-card">
                            <i class="fas fa-shield-alt feature-icon"></i>
                            <h5>Secure Payments</h5>
                            <p class="mb-0">100% secure checkout</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="feature-card">
                            <i class="fas fa-undo feature-icon"></i>
                            <h5>Easy Returns</h5>
                            <p class="mb-0">30-day return policy</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Today's Deals -->
        <section class="deal-section">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0">Today's Best Deals</h2>
                    <a href="#" class="btn btn-link">View All</a>
                </div>
                <div class="row">
                    <c:forEach var="product" items="${product}">
                    <div class="col-md-3">
                        <div class="card product-card">
                            <img src="${product.image_url}" class="card-img-top" alt="${product.name}">
                            <div class="card-body">
                                <h5 class="card-title">${product.name}</h5>
                                <p class="card-text">${product.description}</p>
                                <div class="d-flex align-items-center mb-3">
                                    <span class="old-price">$${product.price}</span>
                                    <span class="price">$${product.price}</span>
                                </div>
                                <button class="btn btn-primary w-100">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                    <!-- Add more product cards here -->
                </div>
            </div>
        </section>

        <!-- Categories -->
        <section class="py-5">
            <div class="container">
                <h2 class="mb-4">Shop by Category</h2>
                <div class="row">
                    <div class="col-md-4">
                        <div class="card category-card">
                            <img src="https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea" class="card-img-top" alt="Processors">
                            <div class="card-body">
                                <h5 class="card-title">Processors</h5>
                                <p class="card-text">Latest CPUs from Intel & AMD</p>
                                <a href="#" class="btn btn-outline-primary">Shop Now</a>
                            </div>
                        </div>
                    </div>
                    <!-- Add more category cards -->
                </div>
            </div>
        </section>

        <!-- Newsletter -->
        <section class="py-5 bg-light">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6 text-center">
                        <h3>Subscribe to Our Newsletter</h3>
                        <p>Get the latest updates on new products and upcoming sales</p>
                        <form class="newsletter-form">
                            <div class="input-group">
                                <input type="email" class="form-control" placeholder="Your email address">
                                <button class="btn btn-primary" type="submit">Subscribe</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer>
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <h5>About CES</h5>
                        <p>Your trusted source for premium computer components and custom PC builds.</p>
                        <div class="social-icons">
                            <a href="#"><i class="fab fa-facebook"></i></a>
                            <a href="#"><i class="fab fa-twitter"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                            <a href="#"><i class="fab fa-youtube"></i></a>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <h5>Quick Links</h5>
                        <ul class="list-unstyled">
                            <li><a href="#" class="text-white">About Us</a></li>
                            <li><a href="#" class="text-white">Contact Us</a></li>
                            <li><a href="#" class="text-white">Terms & Conditions</a></li>
                            <li><a href="#" class="text-white">Privacy Policy</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h5>Customer Service</h5>
                        <ul class="list-unstyled">
                            <li><a href="#" class="text-white">My Account</a></li>
                            <li><a href="#" class="text-white">Track Order</a></li>
                            <li><a href="#" class="text-white">Returns</a></li>
                            <li><a href="#" class="text-white">Help Center</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h5>Contact Info</h5>
                        <ul class="list-unstyled">
                            <li><i class="fas fa-map-marker-alt me-2"></i>123 Tech Street, Silicon Valley, CA</li>
                            <li><i class="fas fa-phone me-2"></i>1-800-123-4567</li>
                            <li><i class="fas fa-envelope me-2"></i>support@ces.com</li>
                        </ul>
                    </div>
                </div>
                <hr class="mt-4">
                <div class="text-center">
                    <p class="mb-0">&copy; 2025 Computer Element System (CES). All rights reserved.</p>
                </div>
            </div>
        </footer>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
