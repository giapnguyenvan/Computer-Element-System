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
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        
        <!-- Page Header -->
        <section class="page-header">
            <div class="container">
                <h2>Build Your Dream PC</h2>
                <p>Select your components and create the perfect PC for your needs</p>
            </div>
        </section>
        
        <div class="container">
            <form action="PCBuilderServlet" method="POST" class="pc-builder-form">
                <div class="row">
                    <!-- CPU Selection -->
                    <div class="col-md-6">
                        <div class="component-card">
                            <div class="component-header">
                                <i class="fas fa-microchip component-icon"></i>
                                <h5>CPU</h5>
                            </div>
                            <div class="component-body">
                                <select name="cpu" class="form-select" required>
                                    <option value="">Select CPU</option>
                                    <c:forEach items="${cpuList}" var="cpu">
                                        <option value="${cpu.id}">${cpu.name} - $${cpu.price}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- GPU Selection -->
                    <div class="col-md-6">
                        <div class="component-card">
                            <div class="component-header">
                                <i class="fas fa-tv component-icon"></i>
                                <h5>Graphics Card</h5>
                            </div>
                            <div class="component-body">
                                <select name="gpu" class="form-select" required>
                                    <option value="">Select GPU</option>
                                    <c:forEach items="${gpuList}" var="gpu">
                                        <option value="${gpu.id}">${gpu.name} - $${gpu.price}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- RAM Selection -->
                    <div class="col-md-6">
                        <div class="component-card">
                            <div class="component-header">
                                <i class="fas fa-memory component-icon"></i>
                                <h5>RAM</h5>
                            </div>
                            <div class="component-body">
                                <select name="ram" class="form-select" required>
                                    <option value="">Select RAM</option>
                                    <c:forEach items="${ramList}" var="ram">
                                        <option value="${ram.id}">${ram.name} - $${ram.price}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Motherboard Selection -->
                    <div class="col-md-6">
                        <div class="component-card">
                            <div class="component-header">
                                <i class="fas fa-server component-icon"></i>
                                <h5>Motherboard</h5>
                            </div>
                            <div class="component-body">
                                <select name="motherboard" class="form-select" required>
                                    <option value="">Select Motherboard</option>
                                    <c:forEach items="${motherboardList}" var="mb">
                                        <option value="${mb.id}">${mb.name} - $${mb.price}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Storage Selection -->
                    <div class="col-md-6">
                        <div class="component-card">
                            <div class="component-header">
                                <i class="fas fa-hdd component-icon"></i>
                                <h5>Storage</h5>
                            </div>
                            <div class="component-body">
                                <select name="storage" class="form-select" required>
                                    <option value="">Select Storage</option>
                                    <c:forEach items="${storageList}" var="storage">
                                        <option value="${storage.id}">${storage.name} - $${storage.price}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Power Supply Selection -->
                    <div class="col-md-6">
                        <div class="component-card">
                            <div class="component-header">
                                <i class="fas fa-plug component-icon"></i>
                                <h5>Power Supply</h5>
                            </div>
                            <div class="component-body">
                                <select name="psu" class="form-select" required>
                                    <option value="">Select Power Supply</option>
                                    <c:forEach items="${psuList}" var="psu">
                                        <option value="${psu.id}">${psu.name} - $${psu.price}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-build btn-lg">
                        <i class="fas fa-cogs me-2"></i>Build PC
                    </button>
                </div>
            </form>

            <!-- Total Price Display -->
            <div class="total-price text-center">
                <h4>Total Price: $<span id="totalPrice">0.00</span></h4>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
        </script>
    </body>
</html> 