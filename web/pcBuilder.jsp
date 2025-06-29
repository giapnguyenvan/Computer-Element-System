<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>PC Builder</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="css/homePage.css" rel="stylesheet">
        <style>
            .list-group-item {
                font-size: 1.1rem;
                padding: 14px 18px;
                border: none;
                border-bottom: 1px solid #f0f0f0;
                background: #fff;
                transition: background 0.2s;
            }
            .list-group-item:hover {
                background: #f5f7fa;
            }
            .list-group {
                border-radius: 12px;
                overflow: hidden;
            }
            .sidebar {
                background: #f8f9fa;
                border-radius: 12px;
                padding-top: 30px;
                padding-bottom: 30px;
                min-height: 100%;
                height: 100%;
            }
            .main-content {
                padding-top: 30px;
            }
            .component-card {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                border: none;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 20px;
            }
            .component-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            }
            .component-header {
                background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
                color: white;
                padding: 15px;
                border-radius: 8px 8px 0 0;
            }
            .component-body {
                padding: 20px;
            }
            .form-select {
                border: 1px solid #dee2e6;
                border-radius: 8px;
                padding: 10px;
                font-size: 1rem;
            }
            .form-select:focus {
                border-color: #0d6efd;
                box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
            }
            .total-price {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-top: 30px;
            }
            .total-price h4 {
                color: #0d6efd;
                margin: 0;
            }
            .btn-build {
                background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
                color: white;
                padding: 12px 30px;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                transition: all 0.3s ease;
            }
            .btn-build:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(13, 110, 253, 0.3);
            }
            .page-header {
                background: linear-gradient(135deg, rgba(102, 126, 234, 0.7) 0%, rgba(118, 75, 162, 0.7) 100%), url('https://images.unsplash.com/photo-1587202372775-e229f172b9d7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80');
                background-size: cover;
                background-position: center;
                color: white;
                padding: 60px 0;
                margin-bottom: 40px;
                text-align: center;
            }
            .page-header h2 {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 1rem;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            }
            .page-header p {
                font-size: 1.2rem;
                opacity: 0.9;
                text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.5);
            }
            .component-icon {
                font-size: 2rem;
                margin-bottom: 10px;
                color: #0d6efd;
            }
            @media (min-width: 768px) {
                .equal-height {
                    display: flex;
                    align-items: stretch;
                }
                .sidebar, .content-col {
                    height: 100%;
                }
            }
            .sidebar-container {
                width: 260px;
                background: #f8f9fa;
                border-radius: 10px;
                padding: 18px 0 0 0;
                box-shadow: 0 2px 12px rgba(0,0,0,0.08);
                position: relative;
            }
            .sidebar-search {
                padding: 0 18px 12px 18px;
            }
            .sidebar-search input {
                width: 100%;
                padding: 8px 12px;
                border-radius: 6px;
                border: 1px solid #ddd;
                font-size: 1rem;
            }
            .sidebar-menu {
                list-style: none;
                margin: 0;
                padding: 0;
            }
            .menu-item {
                position: relative;
                user-select: none;
            }
            .menu-item > a {
                display: flex;
                align-items: center;
                padding: 14px 18px;
                color: #222;
                text-decoration: none;
                font-weight: 500;
                transition: background 0.2s, color 0.2s;
                border-radius: 0 20px 20px 0;
                justify-content: flex-start;
                gap: 10px;
                text-align: left;
            }
            .menu-item > a i {
                min-width: 22px;
                text-align: center;
            }
            .menu-item > a:hover, .menu-item.active > a {
                background: #0d6efd;
                color: #fff;
            }
            .menu-item.has-submenu > a .submenu-arrow {
                margin-left: 8px;
                font-size: 1.2em;
                color: #888;
                transition: color 0.2s;
            }
            .menu-item.has-submenu > a:hover .submenu-arrow {
                color: #fff;
            }
            .submenu {
                display: none;
                opacity: 0;
                pointer-events: none;
                position: absolute;
                left: 100%;
                top: 0;
                min-width: 340px;
                background: #fff;
                box-shadow: 0 2px 12px rgba(0,0,0,0.12);
                border-radius: 8px;
                z-index: 100;
                padding: 20px 30px;
                white-space: nowrap;
                flex-direction: row;
                gap: 30px;
                transition: opacity 0.25s;
            }
            .menu-item.has-submenu:hover > .submenu,
            .menu-item.has-submenu:focus-within > .submenu,
            .menu-item.show > .submenu {
                display: flex;
                opacity: 1;
                pointer-events: auto;
            }
            .submenu-col {
                margin-right: 30px;
            }
            .submenu-col h6 {
                font-weight: bold;
                margin-bottom: 10px;
            }
            .submenu-col ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            .submenu-col ul li a {
                color: #333;
                text-decoration: none;
                display: block;
                padding: 4px 0;
                border-radius: 4px;
                transition: background 0.2s, color 0.2s;
            }
            .submenu-col ul li a:hover {
                color: #0d6efd;
                background: #f0f4ff;
            }
            @media (max-width: 767px) {
                .sidebar-container {
                    width: 100%;
                    border-radius: 0;
                    box-shadow: none;
                    padding: 0;
                }
                .sidebar-menu {
                    width: 100%;
                }
                .menu-item > a {
                    border-radius: 0;
                }
                .submenu {
                    position: static;
                    min-width: 0;
                    box-shadow: none;
                    padding: 10px 18px;
                    flex-direction: column;
                    gap: 0;
                    border-radius: 0;
                    transition: max-height 0.3s, opacity 0.3s;
                    max-height: 0;
                    overflow: hidden;
                    opacity: 0;
                    display: block;
                }
                .menu-item.show > .submenu {
                    max-height: 1000px;
                    opacity: 1;
                    pointer-events: auto;
                }
            }
            .breadcrumb-nav {
                margin: 18px 0 0 0;
                font-size: 1rem;
                color: #666;
            }
            .breadcrumb-nav a {
                color: #0d6efd;
                text-decoration: none;
            }
            .breadcrumb-sep {
                margin: 0 6px;
            }
            .pc-builder-bg {
                position: relative;
                background: url('assets/backgroeoe.jpg.jpg') center/cover no-repeat;
                color: #fff;
                min-height: 964px;
                overflow: hidden;
                border-radius: 12px;
            }
            .pc-builder-bg .bg-overlay {
                position: absolute;
                inset: 0;
                background: rgba(0,0,0,0.45);
                z-index: 1;
                border-radius: 12px;
                height: 100%;
                width: 100%;
            }
            .pc-builder-bg > *:not(.bg-overlay) {
                position: relative;
                z-index: 2;
            }
            .pc-builder-bg h2,
            .pc-builder-bg p {
                z-index: 2;
                position: relative;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="container-fluid py-4">
            <form action="PCBuilderServlet" method="post">
                <div class="row equal-height">
                    <!-- Sidebar Megamenu -->
                    <div class="col-md-3 sidebar mb-4 mb-md-0">
                        <div class="sidebar-section mb-4">
                            <h5 class="mb-3">Build Case PC</h5>
                            <ul class="sidebar-menu">
                                <!-- CPU Section -->
                                <li class="menu-item has-submenu">
                                    <a href="#"><i class="fas fa-microchip fa-fw me-2"></i> CPU</a>
                                    <div class="submenu">
                                        <div class="submenu-col">
                                            <h6>Brand</h6>
                                            <ul>
                                                <c:forEach var="brand" items="${cpuBrands}">
                                                    <li><a href="#" data-component="cpu" data-brand="${brand}">${brand}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                        <div class="submenu-col">
                                            <h6>Series</h6>
                                            <ul>
                                                <c:forEach var="series" items="${cpuSeries}">
                                                    <li><a href="#" data-component="cpu" data-series="${series}">${series}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                                
                                <!-- Mainboard Section -->
                                <li class="menu-item has-submenu">
                                    <a href="#"><i class="fas fa-microchip fa-fw me-2"></i> Mainboard</a>
                                    <div class="submenu">
                                        <div class="submenu-col">
                                            <h6>Brand</h6>
                                            <ul>
                                                <c:forEach var="brand" items="${mainboardBrands}">
                                                    <li><a href="#" data-component="mainboard" data-brand="${brand}">${brand}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                        <div class="submenu-col">
                                            <h6>Series</h6>
                                            <ul>
                                                <c:forEach var="series" items="${mainboardSeries}">
                                                    <li><a href="#" data-component="mainboard" data-series="${series}">${series}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                                
                                <!-- RAM Section -->
                                <li class="menu-item has-submenu">
                                    <a href="#"><i class="fas fa-memory fa-fw me-2"></i> RAM</a>
                                    <div class="submenu">
                                        <div class="submenu-col">
                                            <h6>Brand</h6>
                                            <ul>
                                                <c:forEach var="brand" items="${ramBrands}">
                                                    <li><a href="#" data-component="ram" data-brand="${brand}">${brand}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                        <div class="submenu-col">
                                            <h6>Series</h6>
                                            <ul>
                                                <c:forEach var="series" items="${ramSeries}">
                                                    <li><a href="#" data-component="ram" data-series="${series}">${series}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                                
                                <!-- GPU Section -->
                                <li class="menu-item has-submenu">
                                    <a href="#"><i class="fas fa-video fa-fw me-2"></i> GPU</a>
                                    <div class="submenu">
                                        <div class="submenu-col">
                                            <h6>Brand</h6>
                                            <ul>
                                                <c:forEach var="brand" items="${gpuBrands}">
                                                    <li><a href="#" data-component="gpu" data-brand="${brand}">${brand}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                        <div class="submenu-col">
                                            <h6>Series</h6>
                                            <ul>
                                                <c:forEach var="series" items="${gpuSeries}">
                                                    <li><a href="#" data-component="gpu" data-series="${series}">${series}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                                
                                <!-- Storage Section -->
                                <li class="menu-item has-submenu">
                                    <a href="#"><i class="fas fa-hdd fa-fw me-2"></i> Storage</a>
                                    <div class="submenu">
                                        <div class="submenu-col">
                                            <h6>Brand</h6>
                                            <ul>
                                                <c:forEach var="brand" items="${storageBrands}">
                                                    <li><a href="#" data-component="storage" data-brand="${brand}">${brand}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                        <div class="submenu-col">
                                            <h6>Series</h6>
                                            <ul>
                                                <c:forEach var="series" items="${storageSeries}">
                                                    <li><a href="#" data-component="storage" data-series="${series}">${series}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                                
                                <!-- PSU Section -->
                                <li class="menu-item has-submenu">
                                    <a href="#"><i class="fas fa-server fa-fw me-2"></i> PSU</a>
                                    <div class="submenu">
                                        <div class="submenu-col">
                                            <h6>Brand</h6>
                                            <ul>
                                                <c:forEach var="brand" items="${psuBrands}">
                                                    <li><a href="#" data-component="psu" data-brand="${brand}">${brand}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                        <div class="submenu-col">
                                            <h6>Series</h6>
                                            <ul>
                                                <c:forEach var="series" items="${psuSeries}">
                                                    <li><a href="#" data-component="psu" data-series="${series}">${series}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                                
                                <!-- Case Section -->
                                <li class="menu-item has-submenu">
                                    <a href="#"><i class="fas fa-desktop fa-fw me-2"></i> Case</a>
                                    <div class="submenu">
                                        <div class="submenu-col">
                                            <h6>Brand</h6>
                                            <ul>
                                                <c:forEach var="brand" items="${caseBrands}">
                                                    <li><a href="#" data-component="case" data-brand="${brand}">${brand}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                        <div class="submenu-col">
                                            <h6>Series</h6>
                                            <ul>
                                                <c:forEach var="series" items="${caseSeries}">
                                                    <li><a href="#" data-component="case" data-series="${series}">${series}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                                
                                <!-- Cooler Section -->
                                <li class="menu-item has-submenu">
                                    <a href="#"><i class="fas fa-fan fa-fw me-2"></i> Cooler</a>
                                    <div class="submenu">
                                        <div class="submenu-col">
                                            <h6>Brand</h6>
                                            <ul>
                                                <c:forEach var="brand" items="${coolerBrands}">
                                                    <li><a href="#" data-component="cooler" data-brand="${brand}">${brand}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                        <div class="submenu-col">
                                            <h6>Series</h6>
                                            <ul>
                                                <c:forEach var="series" items="${coolerSeries}">
                                                    <li><a href="#" data-component="cooler" data-series="${series}">${series}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="sidebar-section">
                            <h5 class="mb-3">Accessories</h5>
                            <ul class="sidebar-menu">
                                <li class="menu-item has-submenu">
                                    <a href="#"><i class="fas fa-mouse fa-fw me-2"></i> Mouse</a>
                                    <div class="submenu">
                                        <div class="submenu-col">
                                            <h6>Brand</h6>
                                            <ul>
                                                <li><a href="#">Logitech</a></li>
                                                <li><a href="#">Razer</a></li>
                                            </ul>
                                        </div>
                                        <div class="submenu-col">
                                            <h6>Type</h6>
                                            <ul>
                                                <li><a href="#">Gaming Mouse</a></li>
                                                <li><a href="#">Wireless Mouse</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                                <li class="menu-item has-submenu">
                                    <a href="#"><i class="fas fa-keyboard fa-fw me-2"></i> Keyboard</a>
                                    <div class="submenu">
                                        <div class="submenu-col">
                                            <h6>Brand</h6>
                                            <ul>
                                                <li><a href="#">DareU</a></li>
                                                <li><a href="#">Logitech</a></li>
                                            </ul>
                                        </div>
                                        <div class="submenu-col">
                                            <h6>Type</h6>
                                            <ul>
                                                <li><a href="#">Mechanical</a></li>
                                                <li><a href="#">Wireless</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                                <li class="menu-item has-submenu">
                                    <a href="#"><i class="fas fa-headphones fa-fw me-2"></i> Headphone</a>
                                    <div class="submenu">
                                        <div class="submenu-col">
                                            <h6>Brand</h6>
                                            <ul>
                                                <li><a href="#">HyperX</a></li>
                                                <li><a href="#">Sony</a></li>
                                            </ul>
                                        </div>
                                        <div class="submenu-col">
                                            <h6>Type</h6>
                                            <ul>
                                                <li><a href="#">Gaming</a></li>
                                                <li><a href="#">Bluetooth</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                                <li class="menu-item has-submenu">
                                    <a href="#"><i class="fas fa-tv fa-fw me-2"></i> Monitor</a>
                                    <div class="submenu">
                                        <div class="submenu-col">
                                            <h6>Brand</h6>
                                            <ul>
                                                <li><a href="#">LG</a></li>
                                                <li><a href="#">Samsung</a></li>
                                            </ul>
                                        </div>
                                        <div class="submenu-col">
                                            <h6>Type</h6>
                                            <ul>
                                                <li><a href="#">Gaming</a></li>
                                                <li><a href="#">Graphic Design</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                                <li class="menu-item has-submenu">
                                    <a href="#"><i class="fas fa-chair fa-fw me-2"></i> Chair & Desk</a>
                                    <div class="submenu">
                                        <div class="submenu-col">
                                            <h6>Brand</h6>
                                            <ul>
                                                <li><a href="#">E-Dra</a></li>
                                                <li><a href="#">DXRacer</a></li>
                                            </ul>
                                        </div>
                                        <div class="submenu-col">
                                            <h6>Type</h6>
                                            <ul>
                                                <li><a href="#">Gaming Chair</a></li>
                                                <li><a href="#">Gaming Desk</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!-- Content chọn linh kiện -->
                    <div class="col-md-9 content-col">
                        <div class="pc-builder-bg component-card text-center p-4 mb-4" style="position: relative;">
                            <div class="bg-overlay" style="background: none; position: static; z-index: auto; height: auto; width: auto;">
                                <!-- Build Case PC Progress Tracker -->
                                <div class="container py-3">
                                    <div class="row justify-content-center">
                                        <div class="col-12">
                                            <div class="progress-tracker mb-3">
                                                <ul class="progress-steps d-flex flex-wrap justify-content-center list-unstyled mb-0" style="gap: 18px;">
                                                    <li class="step" id="step-cpu">
                                                        <span class="step-label">CPU</span>
                                                        <div class="step-selected" id="selected-cpu" style="font-size:0.95em;color:#0d6efd;"></div>
                                                    </li>
                                                    <li class="step" id="step-mainboard">
                                                        <span class="step-label">Mainboard</span>
                                                        <div class="step-selected" id="selected-mainboard"></div>
                                                    </li>
                                                    <li class="step" id="step-ram">
                                                        <span class="step-label">RAM</span>
                                                        <div class="step-selected" id="selected-ram"></div>
                                                    </li>
                                                    <li class="step" id="step-gpu">
                                                        <span class="step-label">GPU</span>
                                                        <div class="step-selected" id="selected-gpu"></div>
                                                    </li>
                                                    <li class="step" id="step-storage">
                                                        <span class="step-label">Storage</span>
                                                        <div class="step-selected" id="selected-storage"></div>
                                                    </li>
                                                    <li class="step" id="step-psu">
                                                        <span class="step-label">PSU</span>
                                                        <div class="step-selected" id="selected-psu"></div>
                                                    </li>
                                                    <li class="step" id="step-case">
                                                        <span class="step-label">Case</span>
                                                        <div class="step-selected" id="selected-case"></div>
                                                    </li>
                                                    <li class="step" id="step-cooler">
                                                        <span class="step-label">Cooler</span>
                                                        <div class="step-selected" id="selected-cooler"></div>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="progress" style="height: 8px;">
                                                <div class="progress-bar bg-primary" id="build-progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <h2 class="mb-3 position-relative">Chào mừng đến với PC Builder!</h2>
                            <p class="lead position-relative">Hãy chọn các linh kiện phù hợp hoặc khám phá các chương trình khuyến mại hấp dẫn của chúng tôi.</p>
                            <div class="component-card promotion-card d-flex flex-column flex-md-row align-items-center p-4 mb-4" style="background: transparent; box-shadow: none;">
                                <img src="https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=600&q=80"
                                     alt="Khuyến mại lớn"
                                     class="img-fluid rounded shadow mb-3 mb-md-0 me-md-4"
                                     style="max-width: 260px; height: 160px; object-fit: cover; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.08);">
                                <div class="text-start">
                                    <h4 class="mb-2 text-danger">Chương trình khuyến mại: "Mua PC - Tặng Chuột Gaming!"</h4>
                                    <p class="mb-2">Khi mua bất kỳ bộ PC nào tại shop trong tháng này, bạn sẽ nhận ngay một chuột gaming cao cấp trị giá 500.000đ. Số lượng có hạn!</p>
                                    <a href="PromotionDetailServlet?id=1" class="btn btn-primary">Xem chi tiết khuyến mại</a>
                                </div>
                            </div>
                            <!-- Vùng hiển thị sản phẩm động -->
                            <div id="productList" class="mt-4"></div>
                        </div>
                    </div>
                </div>
            </form>
            <!-- Total Price Display -->
            <div class="total-price text-center">
                <h4>Total Price: $<span id="totalPrice">0.00</span></h4>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
        <script>
            // Add JavaScript to calculate total price when components are selected
            document.querySelectorAll('select').forEach(select => {
                select.addEventListener('change', calculateTotal);
            });
            function calculateTotal() {
                let total = 0;
                document.querySelectorAll('select').forEach(select => {
                    const selectedOption = select.options[select.selectedIndex];
                    if (selectedOption.value) {
                        const price = parseFloat(selectedOption.text.split('$')[1]);
                        total += price;
                    }
                });
                document.getElementById('totalPrice').textContent = total.toFixed(2);
            }
            // Tìm kiếm danh mục
            if (document.getElementById('sidebarSearch')) {
                document.getElementById('sidebarSearch').addEventListener('input', function() {
                    const filter = this.value.toLowerCase();
                    document.querySelectorAll('.sidebar-menu .menu-item').forEach(item => {
                        const text = item.textContent.toLowerCase();
                        item.style.display = text.includes(filter) ? '' : 'none';
                    });
                });
            }
            // Mobile: toggle submenu khi click
            if (window.innerWidth < 768) {
                document.querySelectorAll('.menu-item.has-submenu > a').forEach(link => {
                    link.addEventListener('click', function(e) {
                        e.preventDefault();
                        const parent = this.parentElement;
                        parent.classList.toggle('show');
                        // Đóng các submenu khác
                        document.querySelectorAll('.menu-item.has-submenu').forEach(item => {
                            if (item !== parent) item.classList.remove('show');
                        });
                    });
                });
            }
            // Desktop: giữ submenu khi di chuyển giữa cha và submenu
            if (window.innerWidth >= 768) {
                document.querySelectorAll('.menu-item.has-submenu').forEach(item => {
                    let timer;
                    item.addEventListener('mouseenter', function() {
                        clearTimeout(timer);
                        item.classList.add('show');
                    });
                    item.addEventListener('mouseleave', function() {
                        timer = setTimeout(() => item.classList.remove('show'), 200);
                    });
                    // Đảm bảo submenu không bị ẩn khi di chuyển chuột giữa cha và submenu
                    const submenu = item.querySelector('.submenu');
                    if (submenu) {
                        submenu.addEventListener('mouseenter', () => clearTimeout(timer));
                        submenu.addEventListener('mouseleave', () => {
                            timer = setTimeout(() => item.classList.remove('show'), 200);
                        });
                    }
                });
            }
            // Breadcrumb: cập nhật khi click submenu
            if (document.getElementById('breadcrumbNav')) {
                document.querySelectorAll('.submenu-col ul li a').forEach(link => {
                    link.addEventListener('click', function(e) {
                        // Breadcrumb hiển thị: Trang chủ > Danh mục > Subcategory
                        const category = this.closest('.menu-item').querySelector('a').textContent.trim();
                        const sub = this.textContent.trim();
                        document.getElementById('breadcrumbCategory').textContent = category;
                        document.getElementById('breadcrumbSub').textContent = sub;
                        document.getElementById('breadcrumbNav').style.display = '';
                        document.getElementById('breadcrumbSubSep').style.display = '';
                        // Nếu muốn chuyển trang thực sự, bỏ comment dòng dưới
                        // window.location = this.href;
                        // e.preventDefault();
                    });
                });
            }
            // Hiển thị sản phẩm khi bấm submenu (giống GearVN)
            const typeMap = {
                "CPU": 1,
                "GPU": 4,
                "Mainboard": 2,
                "RAM": 3,
                "Storage": 5,
                "PSU": 6,
                "Case": 7,
                "Cooler": 8
            };
            
            document.querySelectorAll('.submenu-col ul li a').forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    const component = this.getAttribute('data-component');
                    const brand = this.getAttribute('data-brand');
                    const series = this.getAttribute('data-series');
                    
                    console.log('Đã click vào:', component, brand, series);
                    
                    if (component) {
                        let url = `PCBuilderServlet?action=getProducts&componentType=${component}`;
                        if (brand) url += `&brand=${encodeURIComponent(brand)}`;
                        if (series) url += `&series=${encodeURIComponent(series)}`;
                        
                        fetch(url)
                            .then(res => res.json())
                            .then(products => {
                                let html = `<h4 class="mb-3">Products: ${component.toUpperCase()}`;
                                if (brand) html += ` - ${brand}`;
                                if (series) html += ` - ${series}`;
                                html += `</h4>`;
                                
                                if (products.length > 0) {
                                    html += '<div class="row">';
                                    products.forEach(p => {
                                        html += `
                                            <div class="col-md-4 mb-3">
                                                <div class="card component-card">
                                                    <img src="${p.image_url || 'assets/images/default-product.jpg'}" 
                                                         class="card-img-top" alt="${p.name}" 
                                                         style="height: 200px; object-fit: cover;">
                                                    <div class="card-body">
                                                        <h5 class="card-title">${p.name}</h5>
                                                        <p class="card-text">
                                                            <strong>Brand:</strong> ${p.brandName}<br>
                                                            <strong>Series:</strong> ${p.seriesName || 'N/A'}<br>
                                                            <strong>Model:</strong> ${p.modelName || 'N/A'}<br>
                                                            <strong>Price:</strong> $${p.price}<br>
                                                            <strong>Stock:</strong> ${p.stock}
                                                        </p>
                                                        <p class="card-text">${p.description || ''}</p>
                                                        <button class="btn btn-primary" onclick="selectComponent('${component}', ${p.product_id}, '${p.name}', ${p.price})">
                                                            Select ${component.toUpperCase()}
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        `;
                                    });
                                    html += '</div>';
                                } else {
                                    html += '<p>No products found.</p>';
                                }
                                document.getElementById('productList').innerHTML = html;
                            })
                            .catch(error => {
                                console.error('Error fetching products:', error);
                                document.getElementById('productList').innerHTML = '<p>Error loading products.</p>';
                            });
                    } else {
                        document.getElementById('productList').innerHTML = '<p>Component type not supported.</p>';
                    }
                });
            });
            
            // Function to select a component and update progress
            function selectComponent(componentType, productId, productName, price) {
                // Update the progress tracker
                const stepElement = document.getElementById(`step-${componentType.toLowerCase()}`);
                const selectedElement = document.getElementById(`selected-${componentType.toLowerCase()}`);
                
                if (stepElement && selectedElement) {
                    stepElement.classList.add('selected');
                    selectedElement.textContent = productName;
                    selectedElement.style.color = '#28a745';
                }
                
                // Update progress bar
                updateProgressBar();
                
                // Store selection in session storage
                const selection = {
                    productId: productId,
                    productName: productName,
                    price: price,
                    componentType: componentType
                };
                sessionStorage.setItem(`selected_${componentType}`, JSON.stringify(selection));
                
                // Show success message
                showNotification(`Selected ${componentType.toUpperCase()}: ${productName}`, 'success');
            }
            
            // Function to update progress bar
            function updateProgressBar() {
                const components = ['cpu', 'mainboard', 'ram', 'gpu', 'storage', 'psu', 'case', 'cooler'];
                let selectedCount = 0;
                
                components.forEach(component => {
                    const selected = sessionStorage.getItem(`selected_${component}`);
                    if (selected) {
                        selectedCount++;
                    }
                });
                
                const progressPercentage = (selectedCount / components.length) * 100;
                const progressBar = document.getElementById('build-progress-bar');
                if (progressBar) {
                    progressBar.style.width = progressPercentage + '%';
                    progressBar.setAttribute('aria-valuenow', progressPercentage);
                }
            }
            
            // Function to show notifications
            function showNotification(message, type = 'info') {
                const notification = document.createElement('div');
                notification.className = `alert alert-${type} alert-dismissible fade show position-fixed`;
                notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
                notification.innerHTML = `
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                `;
                document.body.appendChild(notification);
                
                // Auto remove after 3 seconds
                setTimeout(() => {
                    if (notification.parentNode) {
                        notification.remove();
                    }
                }, 3000);
            }
            
            // Load saved selections on page load
            window.addEventListener('load', function() {
                updateProgressBar();
            });
        </script>
    </body>
</html> 