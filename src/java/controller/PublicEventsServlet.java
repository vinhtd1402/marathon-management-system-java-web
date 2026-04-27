package controller;

import dal.EventTypeDAO;
import dal.MarathonEventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import models.MarathonEvent;
import models.MarathonType;

public class PublicEventsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String q = trimOrNull(request.getParameter("q"));
        String location = trimOrNull(request.getParameter("location"));
        Integer typeId = parseIntOrNull(request.getParameter("typeId"));

        Date fromDate = parseDateOrNull(request.getParameter("fromDate"));
        Date toDate   = parseDateOrNull(request.getParameter("toDate"));

        Double minFee = parseDoubleOrNull(request.getParameter("minFee"));
        Double maxFee = parseDoubleOrNull(request.getParameter("maxFee"));

        Double minDist = parseDoubleOrNull(request.getParameter("minDist"));
        Double maxDist = parseDoubleOrNull(request.getParameter("maxDist"));

        // gọi DAO
        MarathonEventDAO eventDAO = new MarathonEventDAO();
        List<MarathonEvent> events = eventDAO.searchEventsAdvanced(
                q, typeId, location, fromDate, toDate, minFee, maxFee, minDist, maxDist);

        // lấy loại giải cho dropdown
        EventTypeDAO typeDAO = new EventTypeDAO();
        List<MarathonType> types = typeDAO.getAllType();

        request.setAttribute("events", events);
        request.setAttribute("types", types);
        request.getRequestDispatcher("views/Events.jsp").forward(request, response);
    }

    private static String trimOrNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }
    private static Integer parseIntOrNull(String v) {
        try { return (v==null||v.isBlank())?null:Integer.parseInt(v); } catch (Exception e){ return null; }
        }
    private static Double parseDoubleOrNull(String v) {
        try { return (v==null||v.isBlank())?null:Double.parseDouble(v); } catch (Exception e){ return null; }
    }
    private static Date parseDateOrNull(String v) {
        try { return (v==null||v.isBlank())?null:Date.valueOf(LocalDate.parse(v)); } catch (Exception e){ return null; }
    }
}
