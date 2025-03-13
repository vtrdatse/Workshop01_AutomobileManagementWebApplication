<%-- 
    Document   : index
    Created on : Feb 21, 2025, 2:22:50 PM
    Author     : datvt
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.Car"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Car List</title>
    </head>
    <body>
        <div class="shadow pt-4 pb-3 px-5 mb-4 d-flex flex-row align-items-center">
            <h3 class="m-0 me-2">Automobile Web Application</h3>
            <a href="CarServlet" class="btn fs-4">Home</a>
        </div>
        <div class="container">
            <h1>Car List</h1>
            <a href="form.jsp" class="btn text-primary px-0 mb-3">Create new</a>
            <table class="container">
                <thead>
                    <tr class="border-bottom">
                        <th class="py-2">CarId</th>
                        <th>CarName</th>
                        <th>Manufacturer</th>
                        <th>Price</th>
                        <th>ReleasedYear</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Car> cars = (ArrayList<Car>) request.getAttribute("cars");
                        for (Car car : cars) {
                    %>
                    <tr class="border-bottom">
                        <td><%=car.getId()%></td>
                        <td><%=car.getName()%></td>
                        <td><%=car.getManufacturer()%></td>
                        <td><%=car.getPrice()%></td>
                        <td><%=car.getReleasedYear()%></td>
                        <td class="d-flex flex-row align-items-center">
                            <form action="CarServlet" method="GET">
                                <input type="hidden" value="update" name="action"/>
                                <input type="hidden" value="<%=car.getId()%>" name="carId"/>
                                <button type="submit" class="btn text-primary">Edit</button>
                            </form>
                            <span>|</span>
                            <form action="CarServlet" method="GET">
                                <input type="hidden" value="details" name="action"/>
                                <input type="hidden" value="<%=car.getId()%>" name="carId"/>
                                <button type="submit" class="btn text-primary">Details</button>
                            </form>
                            <span>|</span>
                            <form action="CarServlet" method="GET">
                                <input type="hidden" value="delete" name="action"/>
                                <input type="hidden" value="<%=car.getId()%>" name="carId"/>
                                <button type="submit" class="btn text-primary">Delete</button>
                            </form> 
                        </td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
