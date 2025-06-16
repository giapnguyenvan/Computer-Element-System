<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PC Build Confirmation</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        
        <div class="container mt-5">
            <h2 class="text-center mb-4">Your PC Build</h2>
            
            <div class="row">
                <div class="col-md-8 mx-auto">
                    <div class="card mb-4">
                        <div class="card-header">
                            <h4>Selected Components</h4>
                        </div>
                        <div class="card-body">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Component</th>
                                        <th>Name</th>
                                        <th>Price</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>CPU</td>
                                        <td>${cpu.name}</td>
                                        <td>$${cpu.price}</td>
                                    </tr>
                                    <tr>
                                        <td>Graphics Card</td>
                                        <td>${gpu.name}</td>
                                        <td>$${gpu.price}</td>
                                    </tr>
                                    <tr>
                                        <td>RAM</td>
                                        <td>${ram.name}</td>
                                        <td>$${ram.price}</td>
                                    </tr>
                                    <tr>
                                        <td>Motherboard</td>
                                        <td>${motherboard.name}</td>
                                        <td>$${motherboard.price}</td>
                                    </tr>
                                    <tr>
                                        <td>Storage</td>
                                        <td>${storage.name}</td>
                                        <td>$${storage.price}</td>
                                    </tr>
                                    <tr>
                                        <td>Power Supply</td>
                                        <td>${psu.name}</td>
                                        <td>$${psu.price}</td>
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="2" class="text-end"><strong>Total:</strong></td>
                                        <td><strong>$${totalPrice}</strong></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>

                    <div class="text-center">
                        <form action="AddToCartServlet" method="POST">
                            <input type="hidden" name="cpuId" value="${cpu.id}">
                            <input type="hidden" name="gpuId" value="${gpu.id}">
                            <input type="hidden" name="ramId" value="${ram.id}">
                            <input type="hidden" name="motherboardId" value="${motherboard.id}">
                            <input type="hidden" name="storageId" value="${storage.id}">
                            <input type="hidden" name="psuId" value="${psu.id}">
                            <button type="submit" class="btn btn-primary btn-lg">Add to Cart</button>
                            <a href="pcBuilder.jsp" class="btn btn-secondary btn-lg">Modify Build</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
        
        <script src="js/bootstrap.bundle.min.js"></script>
    </body>
</html> 