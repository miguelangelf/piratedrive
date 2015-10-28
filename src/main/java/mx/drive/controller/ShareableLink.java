/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.drive.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.json.Json;
import javax.json.JsonObject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mx.drive.dao.HashGen;

/**
 *
 * @author miguel
 */
@WebServlet(name = "ShareableLink", urlPatterns = {"/ShareableLink"})
public class ShareableLink extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        /* TODO output your page here. You may use following sample code. */
        String share = request.getParameter("share");
        HttpSession session = request.getSession(true);
        String fileid = request.getParameter("fileid");
        HashGen hs = new HashGen();

        if (share.equals("check")) {
            boolean resp = hs.checkifshareable(Integer.parseInt(fileid));
            JsonObject jo = Json.createObjectBuilder()
                    .add("result", resp)
                    .build();

            PrintWriter out = response.getWriter();
            out.print(jo.toString());
            out.flush();
            return;
        }

        if (share.equals("true")) {
            boolean isshared = hs.checkifshareable(Integer.parseInt(fileid));
            if (!isshared) {
                boolean resp = hs.makeitshareable((int) session.getAttribute("userid"), Integer.parseInt(fileid));
                JsonObject jo = Json.createObjectBuilder()
                        .add("result", "se compartio")
                        .build();

                PrintWriter out = response.getWriter();
                out.print(jo.toString());
                out.flush();
                return;
            } else {

                boolean resp = hs.makeitprivate(Integer.parseInt(fileid));
                JsonObject jo = Json.createObjectBuilder()
                        .add("result", "se borro")
                        .build();

                PrintWriter out = response.getWriter();
                out.print(jo.toString());
                out.flush();
                return;

            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
