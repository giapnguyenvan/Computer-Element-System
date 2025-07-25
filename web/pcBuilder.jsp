<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Customer, model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            .btn-pcbuilder-white {
                background: #fff !important;
                color: #0d6efd !important;
                border: 2px solid #0d6efd !important;
                font-weight: 600;
                box-shadow: 0 2px 8px rgba(13,110,253,0.08);
                transition: background 0.2s, color 0.2s, box-shadow 0.2s;
            }
            .btn-pcbuilder-white:hover, .btn-pcbuilder-white:focus {
                background: #0d6efd !important;
                color: #fff !important;
                box-shadow: 0 4px 16px rgba(13,110,253,0.15);
            }
            /* Modern tech style for modal popup in pcBuilder.jsp */
            #viewProductModal .modal-content {
                border-radius: 18px;
                box-shadow: 0 8px 32px rgba(0,0,0,0.18), 0 1.5px 8px rgba(0,123,255,0.08);
                border: none;
                background: rgba(255,255,255,0.98);
                overflow: hidden;
                animation: modalFadeIn 0.4s cubic-bezier(.4,0,.2,1);
            }
            #viewProductModal .modal-header {
                background: linear-gradient(90deg, #0d6efd 0%, #00c6ff 100%);
                color: #fff;
                border-bottom: none;
                padding: 1.2rem 2rem 1.2rem 2rem;
                align-items: center;
                justify-content: space-between;
            }
            #viewProductModal .modal-title {
                font-size: 1.5rem;
                font-weight: 700;
                letter-spacing: 1px;
                text-shadow: 0 2px 8px rgba(0,0,0,0.08);
                margin: 0 auto;
            }
            #viewProductModal .btn-back {
                background: #fff url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="%230d6efd" stroke-width="3" viewBox="0 0 24 24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg>') center/1.2em auto no-repeat;
                border-radius: 50%;
                width: 2.5rem;
                height: 2.5rem;
                opacity: 0.85;
                transition: background 0.2s, box-shadow 0.2s;
                box-shadow: 0 2px 8px rgba(13,110,253,0.08);
                border: none;
                margin-right: auto;
            }
            #viewProductModal .btn-back:hover {
                background-color: #e3f0ff;
                opacity: 1;
            }
            #viewProductModal .btn-forward {
                background: #fff url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="%230d6efd" stroke-width="3" viewBox="0 0 24 24"><path d="M5 12h14M12 5l7 7-7 7"/></svg>') center/1.2em auto no-repeat;
                border-radius: 50%;
                width: 2.5rem;
                height: 2.5rem;
                opacity: 0.85;
                transition: background 0.2s, box-shadow 0.2s;
                box-shadow: 0 2px 8px rgba(13,110,253,0.08);
                border: none;
                margin-left: 0.5rem;
            }
            #viewProductModal .btn-forward:hover {
                background-color: #e3f0ff;
                opacity: 1;
            }
            #viewProductModal .btn-reset {
                background: #fff url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="%230d6efd" stroke-width="3" viewBox="0 0 24 24"><path d="M3 12a9 9 0 1 1 9 9M3 12h9M3 12l3-3M3 12l3 3"/></svg>') center/1.2em auto no-repeat;
                border-radius: 50%;
                width: 2.5rem;
                height: 2.5rem;
                opacity: 0.85;
                transition: background 0.2s, box-shadow 0.2s;
                box-shadow: 0 2px 8px rgba(13,110,253,0.08);
                border: none;
                margin-left: 0.5rem;
            }
            #viewProductModal .btn-reset:hover {
                background-color: #e3f0ff;
                opacity: 1;
            }
            #viewProductModal .btn-close {
                background: #fff url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="none" stroke="%230d6efd" stroke-width="3" viewBox="0 0 24 24"><path d="M6 6l12 12M6 18L18 6"/></svg>') center/1.5em auto no-repeat;
                border-radius: 50%;
                width: 2.5rem;
                height: 2.5rem;
                opacity: 0.85;
                transition: background 0.2s, box-shadow 0.2s;
                box-shadow: 0 2px 8px rgba(13,110,253,0.08);
                margin-left: 0.5rem;
            }
            #viewProductModal .btn-close:hover {
                background-color: #e3f0ff;
                opacity: 1;
            }
            #viewProductModal .modal-body {
                background: linear-gradient(120deg, #f8fafd 60%, #e3f0ff 100%);
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 80vh;
                min-height: 400px;
                max-height: 90vh;
                overflow: hidden;
            }
            #viewProductModal iframe {
                border-radius: 0 0 18px 18px;
                background: transparent;
                box-shadow: none;
                transition: box-shadow 0.2s;
                max-width: 100%;
                max-height: 100%;
                width: 100%;
                height: 100%;
                overflow-x: auto;
                display: block;
                scrollbar-color: #0d6efd #e3f0ff;
                scrollbar-width: thin;
            }
            @keyframes modalFadeIn {
                from { transform: translateY(40px) scale(0.98); opacity: 0; }
                to { transform: none; opacity: 1; }
            }
            #productSelectModal .table-responsive {
                margin: 0;
                padding: 0;
            }
            #productSelectModal table {
                width: 100%;
                table-layout: auto;
                word-break: break-word;
            }
            #productSelectModal th, #productSelectModal td {
                white-space: normal !important;
                word-break: break-word;
                vertical-align: middle;
                font-size: 1rem;
                padding: 0.5rem 0.75rem;
            }
            #productSelectModal .modal-dialog {
                max-width: 98vw;
                width: 98vw;
                margin: 0 auto;
            }
            #productSelectModal .modal-content {
                width: 100%;
                min-height: 80vh;
                max-height: 95vh;
            }
            #productSelectModal .modal-body {
                overflow: visible !important;
                max-height: none !important;
                padding: 0;
            }
            #productSelectModal .table-responsive {
                overflow-x: visible !important;
            }
            #productSelectModal table {
                width: 100%;
                table-layout: auto;
            }
            #productSelectModal table,
            #productSelectModal th,
            #productSelectModal td {
                font-size: 0.92em;
                padding: 0.3em 0.5em;
            }
            /* Tuỳ chọn: scale nhỏ bảng để vừa modal */
            #productSelectModal .table-responsive {
                transform: scale(0.85);
                transform-origin: top left;
                width: 117.6%; /* 1/0.85 để bù lại scale */
            }
            #productList {
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 2px 12px rgba(0,0,0,0.08);
                padding: 24px 12px;
                margin-bottom: 32px;
                min-height: 300px;
                transition: box-shadow 0.2s;
            }
            @media (max-width: 767px) {
                #productList {
                    padding: 8px 2px;
                    font-size: 0.98em;
                }
                #productList table {
                    font-size: 0.95em;
                }
            }
            #productList,
            #productList .table,
            #productList .table th,
            #productList .table td,
            #productList .alert,
            #productList .status-badge {
                color: #111 !important;
            }
            .status-active {
                background-color: #28a745;
                color: white;
                padding: 2px 8px;
                border-radius: 4px;
            }
            .status-inactive {
                background-color: #dc3545;
                color: white;
                padding: 2px 8px;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="container-fluid py-4">
            
            <form id="pcBuilderForm" action="PCBuilderServlet" method="post">
                <input type="hidden" name="cpu" id="input-cpu" />
                <input type="hidden" name="mainboard" id="input-mainboard" />
                <input type="hidden" name="ram" id="input-ram" />
                <input type="hidden" name="gpu" id="input-gpu" />
                <input type="hidden" name="storage" id="input-storage" />
                <input type="hidden" name="psu" id="input-psu" />
                <input type="hidden" name="case" id="input-case" />
                <input type="hidden" name="cooler" id="input-cooler" />
                <div class="row equal-height">
                    <!-- Sidebar Megamenu -->
                    <div class="col-md-3 sidebar mb-4 mb-md-0">
                        <div class="sidebar-section mb-4">
                            <h5 class="mb-3">Build Case PC</h5>
                            <ul class="sidebar-menu">
                                <li class="menu-item">
                                    <a href="#"><i class="fas fa-microchip fa-fw me-2"></i> CPU <span class="selected-component-label" id="sidebar-selected-CPU" style="font-size:0.95em;color:#28a745;margin-left:4px;"></span></a>
                                </li>
                                <li class="menu-item">
                                    <a href="#"><i class="fas fa-server fa-fw me-2"></i> Mainboard <span class="selected-component-label" id="sidebar-selected-Mainboard" style="font-size:0.95em;color:#28a745;margin-left:4px;"></span></a>
                                </li>
                                <li class="menu-item">
                                    <a href="#"><i class="fas fa-memory fa-fw me-2"></i> RAM <span class="selected-component-label" id="sidebar-selected-RAM" style="font-size:0.95em;color:#28a745;margin-left:4px;"></span></a>
                                </li>
                                <li class="menu-item">
                                    <a href="#"><i class="fas fa-video fa-fw me-2"></i> GPU <span class="selected-component-label" id="sidebar-selected-GPU" style="font-size:0.95em;color:#28a745;margin-left:4px;"></span></a>
                                </li>
                                <li class="menu-item">
                                    <a href="#"><i class="fas fa-hdd fa-fw me-2"></i> Storage <span class="selected-component-label" id="sidebar-selected-Storage" style="font-size:0.95em;color:#28a745;margin-left:4px;"></span></a>
                                </li>
                                <li class="menu-item">
                                    <a href="#"><i class="fas fa-plug fa-fw me-2"></i> PSU <span class="selected-component-label" id="sidebar-selected-PSU" style="font-size:0.95em;color:#28a745;margin-left:4px;"></span></a>
                                </li>
                                <li class="menu-item">
                                    <a href="#"><i class="fas fa-desktop fa-fw me-2"></i> Case <span class="selected-component-label" id="sidebar-selected-Case" style="font-size:0.95em;color:#28a745;margin-left:4px;"></span></a>
                                </li>
                                <li class="menu-item">
                                    <a href="#"><i class="fas fa-fan fa-fw me-2"></i> Cooler <span class="selected-component-label" id="sidebar-selected-Cooler" style="font-size:0.95em;color:#28a745;margin-left:4px;"></span></a>
                                </li>
                            </ul>
                        </div>
                        <div class="sidebar-section">
                            <h5 class="mb-3">Accessories</h5>
                            <ul class="sidebar-menu">
                                <li class="menu-item">
                                    <a href="#"><i class="fas fa-mouse fa-fw me-2"></i> Mouse</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#"><i class="fas fa-keyboard fa-fw me-2"></i> Keyboard</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#"><i class="fas fa-headphones fa-fw me-2"></i> Headphone</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#"><i class="fas fa-tv fa-fw me-2"></i> Monitor</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#"><i class="fas fa-chair fa-fw me-2"></i> Chair & Desk</a>
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
                            <!-- Dãy nút chọn linh kiện tích hợp vào đây -->
                            <div class="container mb-4">
                                <div class="row mb-2 justify-content-center">
                                    <div class="col-auto mb-2">
                                        <button type="button" class="btn btn-pcbuilder-white btn-lg" onclick="loadProducts('CPU'); return false;"><i class="fas fa-microchip me-2"></i>Select CPU</button>
                                    </div>
                                    <div class="col-auto mb-2">
                                        <button type="button" class="btn btn-pcbuilder-white btn-lg" onclick="loadProducts('Mainboard'); return false;"><i class="fas fa-server me-2"></i>Select Mainboard</button>
                                    </div>
                                    <div class="col-auto mb-2">
                                        <button type="button" class="btn btn-pcbuilder-white btn-lg" onclick="loadProducts('RAM'); return false;"><i class="fas fa-memory me-2"></i>Select RAM</button>
                                    </div>
                                    <div class="col-auto mb-2">
                                        <button type="button" class="btn btn-pcbuilder-white btn-lg" onclick="loadProducts('GPU'); return false;"><i class="fas fa-video me-2"></i>Select GPU</button>
                                    </div>
                                    <div class="col-auto mb-2">
                                        <button type="button" class="btn btn-pcbuilder-white btn-lg" onclick="loadProducts('Storage'); return false;"><i class="fas fa-hdd me-2"></i>Select Storage</button>
                                    </div>
                                    <div class="col-auto mb-2">
                                        <button type="button" class="btn btn-pcbuilder-white btn-lg" onclick="loadProducts('PSU'); return false;"><i class="fas fa-plug me-2"></i>Select PSU</button>
                                    </div>
                                    <div class="col-auto mb-2">
                                        <button type="button" class="btn btn-pcbuilder-white btn-lg" onclick="loadProducts('Case'); return false;"><i class="fas fa-desktop me-2"></i>Select Case</button>
                                    </div>
                                    <div class="col-auto mb-2">
                                        <button type="button" class="btn btn-pcbuilder-white btn-lg" onclick="loadProducts('Cooler'); return false;"><i class="fas fa-fan me-2"></i>Select Cooler</button>
                                    </div>
                                </div>
                            </div>
                            <!-- Vùng hiển thị sản phẩm động -->
                            <div id="currentCategoryBar">
                              <div id="currentCategoryBarTitle"></div>
                              <div id="temporaryOrderBar"></div>
                            </div>
                            <div id="productList" class="mt-4"></div>
                        </div>
                    </div>
                </div>
            </form>
            <!-- Total Price Display -->
            <div class="total-price text-center">
                <h4>Total Price: $<span id="totalPrice">0.00</span></h4>
                <button type="submit" class="btn btn-build mt-3" form="pcBuilderForm" id="btn-submit-pcbuilder">Xác nhận cấu hình</button>
            </div>
        </div>
     
        <jsp:include page="footer.jsp"/>
        <!-- Thêm SweetAlert2 cho popup đẹp -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- Thêm DataTable & jQuery nếu chưa có -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

        <script>
        //<![CDATA[
            // Ensure currentUserId is defined
let currentUserId = '<%= session.getAttribute("customer") != null ? ((shop.entities.Customer)session.getAttribute("customer")).getId() : "" %>';
console.log('currentUserId on page load:', currentUserId);

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
            
            // Function to calculate total price from sessionStorage
            function calculateTotal() {
                let total = 0;
                const components = ['CPU', 'Mainboard', 'RAM', 'GPU', 'Storage', 'PSU', 'Case', 'Cooler'];
                components.forEach(component => {
                    const data = sessionStorage.getItem(`selected_${component}`);
                    if (data) {
                        try {
                            const selection = JSON.parse(data);
                            if (selection.price) {
                                total += parseFloat(selection.price);
                            }
                        } catch (e) {
                            console.error(`Error parsing sessionStorage for ${component}:`, e);
                        }
                    }
                });
                document.getElementById('totalPrice').textContent = total.toFixed(2);
            }
            
            // Hàm cập nhật trạng thái nút Select theo loại linh kiện
            function updateSelectButtonState(componentType, productName) {
                const iconMap = {
                    'CPU': 'fa-microchip',
                    'Mainboard': 'fa-server',
                    'RAM': 'fa-memory',
                    'GPU': 'fa-video',
                    'Storage': 'fa-hdd',
                    'PSU': 'fa-plug',
                    'Case': 'fa-desktop',
                    'Cooler': 'fa-fan'
                };
                const iconClass = iconMap[componentType];
                if (!iconClass) {
                    console.warn('updateSelectButtonState: Unknown componentType', componentType);
                    // Không thực hiện selector nếu iconClass undefined
                    return;
                }
                // Reset all buttons to default
                $('.btn-pcbuilder-white').each(function() {
                    $(this).css({'background': '', 'color': '', 'border': ''});
                });
                // Update the corresponding button (chỉ thực hiện nếu iconClass hợp lệ)
                try {
                    const $btn = $(`.btn-pcbuilder-white i.${iconClass}`).closest('.btn-pcbuilder-white');
                    if ($btn.length) {
                        $btn.css({
                            'background': '#28a745',
                            'color': '#fff',
                            'border': '2px solid #28a745'
                        });
                    } else {
                        console.warn('updateSelectButtonState: No button found for iconClass', iconClass);
                    }
                } catch (e) {
                    console.error('updateSelectButtonState selector error:', e);
                }
            }

            // Hàm xác nhận chọn linh kiện
            function selectComponent(componentType, productId, productName, price) {
                // Không cần kiểm tra đăng nhập lại, đã kiểm tra ở DOMContentLoaded
                // Update hidden form input
                const inputElement = document.getElementById(`input-${componentType.toLowerCase()}`);
                if (inputElement) {
                    inputElement.value = productId;
                }
                // Lưu vào sessionStorage
                const selection = {
                    productId: productId,
                    productName: productName,
                    price: price,
                    componentType: componentType
                };
                sessionStorage.setItem(`selected_${componentType}`, JSON.stringify(selection));
                // Cập nhật UI
                updateSelectButtonState(componentType, productName);
                const stepElement = document.getElementById(`step-${componentType.toLowerCase()}`);
                const selectedElement = document.getElementById(`selected-${componentType.toLowerCase()}`);
                if (stepElement && selectedElement) {
                    stepElement.classList.add('selected');
                    selectedElement.textContent = productName;
                    selectedElement.style.color = '#28a745';
                }
                updateProgressBar();
                calculateTotal();
                showNotification(`${componentType} đã được chọn: ${productName}`, 'success');
                updateSidebarSelectedLabels();
            }

            // Hàm cập nhật progress bar
            function updateProgressBar() {
                const steps = ['cpu', 'mainboard', 'ram', 'gpu', 'storage', 'psu', 'case', 'cooler'];
                let completedSteps = 0;
                
                steps.forEach(step => {
                    const data = sessionStorage.getItem(`selected_${step.charAt(0).toUpperCase() + step.slice(1)}`);
                    if (data) completedSteps++;
                });
                
                const progressPercentage = (completedSteps / steps.length) * 100;
                const progressBar = document.getElementById('build-progress-bar');
                if (progressBar) {
                    progressBar.style.width = progressPercentage + '%';
                    progressBar.setAttribute('aria-valuenow', progressPercentage);
                }
            }

            function getCategoryDisplayName(type) {
                switch(type) {
                    case 'CPU': return 'Bộ vi xử lý';
                    case 'Mainboard': return 'Bo mạch chủ';
                    case 'RAM': return 'Bộ nhớ';
                    case 'GPU': return 'Card đồ họa';
                    case 'Storage': return 'Ổ lưu trữ';
                    case 'PSU': return 'Nguồn';
                    case 'Case': return 'Vỏ máy';
                    case 'Cooler': return 'Tản nhiệt';
                    default: return type;
                }
            }

            // Load products for a component type
            window.loadProducts = function(type) {
                window.currentComponentType = type;
                $('#currentCategoryBarTitle').html(
                    '<div class="mb-3" style="font-size:1.2em;font-weight:600;color:#0052cc;">' +
                    '<i class="fas fa-layer-group me-2"></i>Category: <span>' + getCategoryDisplayName(type) + '</span></div>'
                );
                $('#productList').html('<div class="text-center py-5"><div class="spinner-border text-primary"></div><div>Đang tải sản phẩm...</div></div>');
                fetch('ProductApiServlet?componentType=' + encodeURIComponent(type))
                    .then(response => response.json())
                    .then(data => {
                        if (!Array.isArray(data.products)) {
                            $('#productList').html('<div class="alert alert-danger">No products found.</div>');
                            return;
                        }
                        let tableHtml = '<table class="table table-bordered table-hover"><thead><tr>' +
                            '<th>ID</th>' +
                            '<th>Image</th>' +
                            '<th>Name</th>' +
                            '<th>Price</th>' +
                            '<th>Status</th>' +
                            '<th></th></tr></thead><tbody>';
                        data.products.forEach(product => {
                            tableHtml += '<tr>' +
                                '<td>' + (product.productId !== undefined ? product.productId : '') + '</td>' +
                                '<td>' + (product.imageUrl ? '<img src="' + product.imageUrl + '" class="product-image" alt="Product" />' : '<div class="product-image bg-light d-flex align-items-center justify-content-center"><i class="fas fa-image text-muted"></i></div>') + '</td>' +
                                '<td>' + (product.name || '') + '</td>' +
                                '<td>' + (product.price !== undefined ? ('$' + product.price) : '') + '</td>' +
                                '<td>' + (product.status ? ('<span class="status-badge ' + (product.status === 'Active' ? 'status-active' : 'status-inactive') + '">' + product.status + '</span>') : '<span class="status-badge status-active">Active</span>') + '</td>' +
                                '<td><button type="button" class="btn btn-primary btn-add-cart" ' +
                                    'data-product-id="' + (product.productId !== undefined ? product.productId : '') + '" ' +
                                    'data-product-name="' + (product.name || '') + '" ' +
                                    'data-product-price="' + (product.price !== undefined ? product.price : '') + '" ' +
                                    'data-component-type="' + (type || '') + '" ' +
                                    'title="Thêm vào giỏ hàng">' +
                                    '<i class="fas fa-cart-plus me-2"></i>Add to Cart</button></td>' +
                                '</tr>';
                        });
                        tableHtml += '</tbody></table>';
                        $('#productList').html(tableHtml);
                        hookProductButtons();
                    })
                    .catch(() => {
                        $('#productList').html('<div class="alert alert-danger">Cannot load product list.</div>');
                    });
            };

            // Hàm xử lý nút Add to Cart
            function hookProductButtons() {
                // Luôn enable nút Add to Cart cho mọi user
                $('.btn-add-cart').prop('disabled', false).removeClass('disabled').attr('title', 'Thêm vào giỏ hàng');
                $('.btn-add-cart').off('click').on('click', function (e) {
                    if (!currentUserId || currentUserId === "") {
                        e.preventDefault();
                        Swal.fire({
                            icon: 'warning',
                            title: 'Yêu cầu đăng nhập',
                            text: 'Vui lòng đăng nhập để thêm vào giỏ hàng!',
                            confirmButtonText: 'Đăng nhập',
                            showCancelButton: true,
                            cancelButtonText: 'Để sau'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location.href = 'login.jsp';
                            }
                        });
                        return;
                    }
                    e.preventDefault();
                    const $btn = $(this);
                    const productId = $btn.data('product-id');
                    const productName = $btn.data('product-name');
                    const productPrice = $btn.data('product-price');
                    const componentType = $btn.data('component-type');
                    // Validate inputs
                    if (!productId || !productName || !productPrice || !componentType) {
                        showNotification('Error: Missing product information.', 'danger');
                        return;
                    }
                    selectComponent(componentType, productId, productName, productPrice);
                    // Lấy quantity từ input nếu có, mặc định là 1
                    let quantity = 1;
                    const quantityInput = document.getElementById('quantity_' + productId);
                    if (quantityInput) {
                        const val = parseInt(quantityInput.value);
                        if (!isNaN(val) && val > 0) quantity = val;
                    }
                    // Gửi dữ liệu giống homepage
                    fetch('CartApiServlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            customerId: currentUserId,
                            productId: productId,
                            quantity: quantity
                        })
                    })
                    .then(response => response.json())
                    .then(result => {
                        if (result.success) {
                            showNotification(`Đã thêm: ${productName} - $${productPrice}`, 'success');
                            updateCartCount();
                        } else {
                            showNotification('Không thể thêm vào giỏ hàng: ' + (result.message || 'Unknown error'), 'danger');
                        }
                    })
                    .catch(error => {
                        console.error('Error adding to cart:', error);
                        showNotification('Lỗi khi thêm vào giỏ hàng: ' + error.message, 'danger');
                    });
                });
                // Enable select component buttons cho mọi user
                $('.btn-pcbuilder-white').prop('disabled', false).removeClass('disabled').attr('title', 'Chọn linh kiện');
                $('.btn-pcbuilder-white').off('click').on('click', function () {
                    // Gọi hàm loadProducts tương ứng
                    const type = $(this).text().replace('Select ', '').trim();
                    loadProducts(type);
                });
            }

            // Hàm cập nhật số lượng sản phẩm trong cart
            function updateCartCount() {
                if (!currentUserId) {
                    // Optionally update UI to show 0 items or hide cart count
                    const cartCountElement = document.getElementById('cartCount');
                    if (cartCountElement) {
                        cartCountElement.textContent = '0';
                    }
                    return;
                }
                fetch('CartApiServlet?customerId=' + encodeURIComponent(currentUserId), {
                    method: 'GET'
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! Status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(result => {
                    if (result.success && result.data) {
                        const totalItems = result.data.reduce((sum, item) => sum + item.quantity, 0);
                        const cartCountElement = document.getElementById('cartCount');
                        if (cartCountElement) {
                            cartCountElement.textContent = totalItems;
                        }
                    }
                })
                .catch(error => {
                    console.error('Error fetching cart count:', error);
                });
            }

            // Hàm cập nhật trạng thái sidebar
            function updateSidebarSelectedLabels() {
                const components = ['CPU', 'Mainboard', 'RAM', 'GPU', 'Storage', 'PSU', 'Case', 'Cooler'];
                components.forEach(component => {
                    const data = sessionStorage.getItem(`selected_${component}`);
                    if (data) {
                        try {
                            const selection = JSON.parse(data);
                            const sidebarLabel = document.getElementById(`sidebar-selected-${component}`);
                            const stepElement = document.getElementById(`step-${component.toLowerCase()}`);
                            const selectedElement = document.getElementById(`selected-${component.toLowerCase()}`);
                            if (sidebarLabel) {
                                sidebarLabel.textContent = selection.productName;
                            }
                            if (stepElement && selectedElement) {
                                stepElement.classList.add('selected');
                                selectedElement.textContent = selection.productName;
                                selectedElement.style.color = '#28a745';
                            }
                            updateSelectButtonState(component, selection.productName);
                        } catch (e) {
                            console.error(`Error parsing sessionStorage for ${component}:`, e);
                            sessionStorage.removeItem(`selected_${component}`); // Clear invalid data
                        }
                    }
                });
                calculateTotal(); // Update total price after loading selections
            }

            // Load saved selections and update cart count on page load
            document.addEventListener('DOMContentLoaded', function () {
                // Kiểm tra đăng nhập 1 lần khi load trang, chỉ cảnh báo nếu chưa login
                console.log('currentUserId in DOMContentLoaded:', currentUserId);
                if (!currentUserId || currentUserId === "") {
                    showNotification('Vui lòng đăng nhập để sử dụng chức năng PC Builder.', 'warning');
                } else {
                    // Nếu vừa login lại và có pending add to cart thì thực hiện luôn, sau đó cho add to cart bình thường
                    try {
                        const pendingStr = sessionStorage.getItem('pendingAddToCart');
                        if (pendingStr) {
                            let pending = null;
                            try {
                                pending = JSON.parse(pendingStr);
                            } catch (err) {
                                console.error('Lỗi JSON.parse pendingAddToCart:', err);
                                sessionStorage.removeItem('pendingAddToCart');
                            }
                            if (pending && pending.productId && pending.productName && pending.productPrice && pending.componentType) {
                                selectComponent(pending.componentType, pending.productId, pending.productName, pending.productPrice);
                                // Gửi đúng format CartApiServlet (không gửi productName, price)
                                fetch('CartApiServlet', {
                                    method: 'POST',
                                    headers: {
                                        'Content-Type': 'application/json'
                                    },
                                    body: JSON.stringify({
                                        customerId: currentUserId,
                                        productId: pending.productId,
                                        quantity: 1
                                    })
                                })
                                .then(response => response.json())
                                .then(result => {
                                    if (result.success) {
                                        showNotification(`Đã thêm: ${pending.productName} - $${pending.productPrice}`, 'success');
                                        updateCartCount();
                                    } else {
                                        showNotification('Không thể thêm vào giỏ hàng: ' + (result.message || 'Unknown error'), 'danger');
                                    }
                                })
                                .catch(error => {
                                    console.error('Error adding to cart:', error);
                                    showNotification('Lỗi khi thêm vào giỏ hàng: ' + error.message, 'danger');
                                });
                                sessionStorage.removeItem('pendingAddToCart');
                            }
                        }
                    } catch (e) { console.error(e); }
                }
                updateSidebarSelectedLabels();
                updateProgressBar();
                updateCartCount();
            });
        </script>
    </body>
</html>