<%-- 
    Document   : details
    Created on : Feb 23, 2025, 3:08:33 PM
    Author     : datvt
--%>

<%@page import="model.Car"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Details Car</title>
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
                switch (action) {
                    case "details":
            %>
            <h1 class="border-bottom pb-3">Car Details</h1>
            <%
                    break;
                case "delete":
            %>
            <h1>Delete</h1>
            <h3 class="border-bottom pb-3">Are you sure you want to delete this?</h3>
            <%
                        break;
                }
            %>
            <table>
                <tbody>
                    <tr>
                        <th>CarId</th>
                        <td class="ps-5"><%=car.getId()%></td>
                    </tr>
                    <tr>
                        <th>CarName</th>
                        <td class="ps-5"><%=car.getName()%></td>
                    </tr>
                    <tr>
                        <th>Manufacturer</th>
                        <td class="ps-5"><%=car.getManufacturer()%></td>
                    </tr>
                    <tr>
                        <th>Price</th>
                        <td class="ps-5"><%=car.getPrice()%></td>
                    </tr>
                    <tr>
                        <th>ReleasedYear</th>
                        <td class="ps-5"><%=car.getReleasedYear()%></td>
                    </tr>
                </tbody>
            </table>
            <div class="d-flex flex-row align-items-center mt-4">
                <%
                    switch (action) {
                        case "details":
                %>
                <form action="CarServlet" method="GET">
                    <input type="hidden" value="update" name="action"/>
                    <input type="hidden" value="<%=car.getId()%>" name="carId"/>
                    <button type="submit" class="btn text-primary px-0">Edit</button>
                </form>
                <%
                        break;
                    case "delete":
                %>
                <form action="CarServlet" method="POST">
                    <input type="hidden" value="delete" name="action"/>
                    <input type="hidden" value="<%=car.getId()%>" name="carId"/>
                    <button type="submit" class="btn btn-danger me-1">Delete</button>
                </form>
                <%
                            break;
                    }
                %>
                <span class="mx-1">|</span>
                <a href="CarServlet" class="btn text-primary px-0">Back to List</a>
            </div>
        </div>


        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
