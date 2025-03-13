<%-- 
    Document   : form
    Created on : Feb 21, 2025, 3:34:39 PM
    Author     : datvt
--%>

<%@page import="model.Car"%>
<%@page import="dao.CarDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Car</title>
    </head>
    <body>
        <div class="shadow pt-4 pb-3 px-5 mb-4 d-flex flex-row align-items-center">
            <h3 class="m-0 me-2">Automobile Web Application</h3>
            <a href="CarServlet" class="btn fs-4">Home</a>
        </div>
        <div class="container">
            <%
                Car car = (Car) request.getAttribute("car");
                String action = request.getParameter("action");
                Boolean isValidated = (Boolean) request.getAttribute("isValidated");
                if (isValidated == null) {
                    isValidated = false;
                }
                if (action == null) {
            %>
            <h1 class="border-bottom pb-3">Add New Car</h1>
            <form action="CarServlet" method="POST">
                <%
                } else {
                %>
                <h1 class="border-bottom pb-3">Update Car</h1>
                <form action="CarServlet" method="POST">
                    <%}%>
                    <div class="mb-3">                
                        <label class="form-label" for="id">CarId</label>
                        <%
                            String idExisted = (String) request.getAttribute("idExisted");
                            String idInvalid = (String) request.getAttribute("idInvalid");
                            if (idExisted != null) {
                        %>
                        <input class="form-control is-invalid" name="id" type="number" value="<%=idExisted%>"/>
                        <div class="invalid-feedback">
                            This ID is existed!
                        </div>
                        <%
                            }
                            if (idInvalid != null) {
                        %>
                        <input class="form-control is-invalid" name="id" type="number" value="<%=idInvalid%>"/>
                        <div class="invalid-feedback">
                            ID must be an positive integer!
                        </div>
                        <%}
                            if (idExisted == null && idInvalid == null && isValidated == true) {%>
                        <input class="form-control is-valid" name="id" type="number" value="<%=car != null ? car.getId() : ""%>"/>
                        <%} else if (idExisted == null && idInvalid == null && isValidated == false) {%>
                        <input class="form-control" name="id" type="number" value="<%=car != null ? car.getId() : ""%>"/>
                        <%}%>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="name">CarName</label>
                        <%
                            String nameRequired = (String) request.getAttribute("nameRequired");
                            if (nameRequired != null && isValidated == true) {
                        %>
                        <input class="form-control is-invalid" name="name" type="text" value="<%=car != null ? car.getName() : ""%>"/>
                        <div class="invalid-feedback">
                            Name is required!
                        </div>
                        <%
                        } else if (nameRequired == null && isValidated == true) {
                        %>         
                        <input class="form-control is-valid" name="name" type="text" value="<%=car != null ? car.getName() : ""%>"/>
                        <%} else {%>
                        <input class="form-control" name="name" type="text" value="<%=car != null ? car.getName() : ""%>"/>
                        <%}%>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="manufacturer">Manufacturer</label>
                        <%
                            String manufacturerRequired = (String) request.getAttribute("manufacturerRequired");
                            if (manufacturerRequired != null && isValidated == true) {
                        %>
                        <input class="form-control is-invalid" name="manufacturer" type="text" value="<%=car != null ? car.getManufacturer() : ""%>"/>
                        <div class="invalid-feedback">
                            Manufacturer is required!
                        </div>
                        <%
                        } else if (manufacturerRequired == null && isValidated == true) {
                        %>
                        <input class="form-control is-valid" name="manufacturer" type="text" value="<%=car != null ? car.getManufacturer() : ""%>"/>
                        <%
                        } else {
                        %>
                        <input class="form-control" name="manufacturer" type="text" value="<%=car != null ? car.getManufacturer() : ""%>"/>
                        <%}%>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="price">Price</label>
                        <%
                            String priceLessThan = (String) request.getAttribute("priceLessThan");
                            String priceInvalid = (String) request.getAttribute("priceInvalid");
                            if (priceInvalid != null && isValidated == true) {
                        %>
                        <input class="form-control is-invalid" name="price" type="number" value="<%=car != null ? car.getPrice() : ""%>"/>
                        <div class="invalid-feedback">
                            Price must be a positive decimal!
                        </div>
                        <%
                            }
                            if (priceLessThan != null && isValidated == true) {
                        %>
                        <input class="form-control is-invalid" name="price" type="number" value="<%=car != null ? car.getPrice() : ""%>"/>
                        <div class="invalid-feedback">
                            Price must be larger than zero!
                        </div>
                        <%
                            }
                            if (priceLessThan == null && priceInvalid == null && isValidated == true) {
                        %>
                        <input class="form-control is-valid" name="price" type="number" value="<%=car != null ? car.getPrice() : ""%>"/>
                        <% } else if (priceLessThan == null && priceInvalid == null && isValidated == false) {%>
                        <input class="form-control" name="price" type="number" value="<%=car != null ? car.getPrice() : ""%>"/>
                        <%}%>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="releasedYear">ReleasedYear</label>
                        <%
                            String releasedYearLessThan = (String) request.getAttribute("releasedYearLessThan");
                            String releasedYearInvalid = (String) request.getAttribute("releasedYearInvalid");
                            String releasedYearGreaterThan = (String) request.getAttribute("releasedYearGreaterThan");
                            if (releasedYearInvalid != null && isValidated == true) {
                        %>
                        <input class="form-control is-invalid" name="releasedYear" type="number" value="<%=car != null ? car.getReleasedYear() : ""%>"/>
                        <div class="invalid-feedback">
                            ReleasedYear must be an integer!
                        </div>
                        <%
                            }
                            if (releasedYearLessThan != null && isValidated == true) {
                        %>
                        <input class="form-control is-invalid" name="releasedYear" type="number" value="<%=car != null ? car.getReleasedYear() : ""%>"/>
                        <div class="invalid-feedback">
                            ReleasedYear must be larger than 1886!
                        </div>
                        <%
                            }
                            if (releasedYearGreaterThan != null && isValidated == true) {
                        %>
                        <input class="form-control is-invalid" name="releasedYear" type="number" value="<%=car != null ? car.getReleasedYear() : ""%>"/>
                        <div class="invalid-feedback">
                            ReleasedYear must not be larger than <%=releasedYearGreaterThan%>!
                        </div>
                        <%
                            }
                            if (releasedYearInvalid == null && releasedYearLessThan == null && releasedYearGreaterThan == null && isValidated == true) {
                        %>
                        <input class="form-control is-valid" name="releasedYear" type="number" value="<%=car != null ? car.getReleasedYear() : ""%>"/>
                        <%
                        } else if (releasedYearInvalid == null && releasedYearLessThan == null && releasedYearGreaterThan == null && isValidated == false) {
                        %>
                        <input class="form-control" name="releasedYear" type="number" value="<%=car != null ? car.getReleasedYear() : ""%>"/>
                        <%}%>
                    </div>
                    <%
                        if (action == null) {
                    %>
                    <button type="submit" class="btn btn-primary mb-3">Create</button>
                    <%
                    } else {
                    %>
                    <input type="hidden" value="update" name="action"/>
                    <%
                        String carId = (String) request.getAttribute("carId");
                        if (isValidated) {
                    %>
                    <input type="hidden" value="<%=carId%>" name="carId"/>
                    <%
                    } else {
                    %>
                    <input type="hidden" value="<%=car != null ? car.getId() : ""%>" name="carId"/>
                    <%
                        }
                    %>
                    <button type="submit" class="btn btn-primary mb-3">Update</button>
                    <% }%>
                </form>
        </div>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
