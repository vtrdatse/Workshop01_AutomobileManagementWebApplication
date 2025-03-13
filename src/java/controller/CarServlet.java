/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.CarDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.Year;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Car;

/**
 *
 * @author datvt
 */
public class CarServlet extends HttpServlet {

    private CarDAO carDAO;

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int carId = Integer.parseInt(req.getParameter("carId"));
        if (carDAO.delete(carId)) {
            resp.sendRedirect("CarServlet");
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String carId = req.getParameter("carId").trim();
        String id = req.getParameter("id").trim();
        String name = req.getParameter("name").trim();
        String manufacturer = req.getParameter("manufacturer").trim();
        String price = req.getParameter("price").trim();
        String releasedYear = req.getParameter("releasedYear").trim();

        Car car = validateForm(req, resp, carId, id, name, manufacturer, price, releasedYear, "update");

        if (carDAO.update(Integer.parseInt(carId), car)) {
            resp.sendRedirect("CarServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            String id = req.getParameter("id").trim();
            String name = req.getParameter("name").trim();
            String manufacturer = req.getParameter("manufacturer").trim();
            String price = req.getParameter("price").trim();
            String releasedYear = req.getParameter("releasedYear").trim();

            Car car = validateForm(req, resp, null, id, name, manufacturer, price, releasedYear, "create");

            if (carDAO.create(car)) {
                resp.sendRedirect("CarServlet");
            }
        } else {
            switch (action) {
                case "update":
                    doPut(req, resp);
                    break;
                case "delete":
                    doDelete(req, resp);
                    break;
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            req.setAttribute("cars", carDAO.getList());
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        } else {
            switch (action) {
                case "details":
                    int carId = Integer.parseInt(req.getParameter("carId"));
                    req.setAttribute("car", carDAO.getById(carId));
                    req.getRequestDispatcher("details.jsp").forward(req, resp);
                    break;
                case "delete":
                    carId = Integer.parseInt(req.getParameter("carId"));
                    req.setAttribute("car", carDAO.getById(carId));
                    req.getRequestDispatcher("details.jsp").forward(req, resp);
                    break;
                case "update":
                    carId = Integer.parseInt(req.getParameter("carId"));
                    req.setAttribute("car", carDAO.getById(carId));
                    req.getRequestDispatcher("form.jsp").forward(req, resp);
            }
        }
    }

    private Integer validateId(HttpServletRequest req, String carId, String id, String action) {
        Integer parsedId;

        try {
            parsedId = Integer.parseInt(id);
            switch (action) {
                case "create":
                    if (carDAO.checkExistedId(parsedId)) {
                        req.setAttribute("idExisted", id);
                        parsedId = null;
                    }
                    break;
                case "update":
                    int parsedCarId = Integer.parseInt(carId);
                    if (parsedCarId != parsedId) {
                        if (carDAO.checkExistedId(parsedId)) {
                            req.setAttribute("idExisted", id);
                            parsedId = null;
                        }
                    }
                    break;
            }
        } catch (NumberFormatException numberFormatException) {
            req.setAttribute("idInvalid", id);
            parsedId = null;
        }

        return parsedId;
    }

    private String validateName(HttpServletRequest req, String name) {
        if (name.equals("")) {
            req.setAttribute("nameRequired", name);
            name = null;
        }
        return name;
    }

    private String validateManufacturer(HttpServletRequest req, String manufacturer) {
        if (manufacturer.equals("")) {
            req.setAttribute("manufacturerRequired", manufacturer);
            manufacturer = null;
        }
        return manufacturer;
    }

    private BigDecimal validatePrice(HttpServletRequest req, String price) {
        BigDecimal parsedPrice;

        try {
            parsedPrice = BigDecimal.valueOf(Double.parseDouble(price));
            int compareResult = parsedPrice.compareTo(BigDecimal.ZERO);
            switch (compareResult) {
                case -1:
                case 0:
                    req.setAttribute("priceLessThan", price);
                    parsedPrice = null;
                    break;
            }
        } catch (NumberFormatException numberFormatException) {
            req.setAttribute("priceInvalid", price);
            parsedPrice = null;
        }

        return parsedPrice;
    }

    private Integer validateReleasedYear(HttpServletRequest req, String releasedYear) {
        Integer parsedReleasedYear;

        try {
            parsedReleasedYear = Integer.parseInt(releasedYear);
            if (parsedReleasedYear <= 1886) {
                req.setAttribute("releasedYearLessThan", releasedYear);
                parsedReleasedYear = null;
            }
            if (parsedReleasedYear > Year.now().getValue()) {
                req.setAttribute("releasedYearGreaterThan", Integer.toString(Year.now().getValue()));
                parsedReleasedYear = null;
            }
        } catch (NumberFormatException numberFormatException) {
            req.setAttribute("releasedYearInvalid", releasedYear);
            parsedReleasedYear = null;
        }

        return parsedReleasedYear;
    }

    private Car validateForm(HttpServletRequest req, HttpServletResponse resp, String carId, String id, String name, String manufacturer, String price, String releasedYear, String action) throws ServletException, IOException {
        Car car = null;

        Integer newCarId = validateId(req, carId, id, action);
        String newName = validateName(req, name);
        String newManufacturer = validateManufacturer(req, manufacturer);
        BigDecimal newPrice = validatePrice(req, price);
        Integer newReleasedYear = validateReleasedYear(req, releasedYear);

        car = new Car(newCarId, name, manufacturer, newPrice, newReleasedYear);
        if (newCarId == null || newName == null || newManufacturer == null || newPrice == null || newReleasedYear == null) {
            switch (action) {
                case "update":
                    req.setAttribute("carId", carId);
                    break;
            }

            req.setAttribute("car", car);
            req.setAttribute("isValidated", true);
            req.getRequestDispatcher("form.jsp").forward(req, resp);
        }

        return car;
    }

    @Override
    public void init() throws ServletException {
        super.init(); //To change body of generated methods, choose Tools | Templates.
        this.carDAO = new CarDAO();
    }

}
