/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.drive.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import mx.drive.beans.BeanDescriptor;
import mx.drive.dao.DriveModel;
import mx.drive.util.Conexion;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.logging.log4j.LogManager;

/**
 *
 * @author miguel
 */
@WebServlet(name = "SaveFileController", urlPatterns = {"/SaveFileController"})
@MultipartConfig(location = "/tmp", fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class SaveFileController extends HttpServlet {

    // private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    // private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    // private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB
    private static org.apache.logging.log4j.Logger logger = LogManager.getLogger(SaveFileController.class.getName());

    private static String getSubmittedFileName2(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1); // MSIE fix.
            }
        }
        return null;
    }

    private static void handlemultipart(HttpServletRequest request, BeanDescriptor bdr) throws FileUploadException {
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);

        if (isMultipart) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload sfu = new ServletFileUpload(factory);
            List<FileItem> items = sfu.parseRequest(request);
            Iterator<FileItem> iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = iter.next();
                if (item.isFormField()) {
                    //String name = item.getFieldName();
                    //String value = item.getString();
                    //bdr.insertField(name, value);
                } else {
                    String fieldName = item.getFieldName();

                    String nombre = item.getName();
                    //nombre=nombre.replace(" ", "")  ;
                    String mime = item.getContentType();
                    String extension = ".borrame";
                    String tamano = String.valueOf(item.getSize());
                    InputStream inputstream = null;
                    try {
                        inputstream = item.getInputStream();
                    } catch (IOException ex) {
                        Logger.getLogger(SaveFileController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    //boolean isInMemory = item.isInMemory();

                    bdr.setNombre(nombre);
                    bdr.setMime(mime);
                    bdr.setTamano(tamano);
                    bdr.setFile(inputstream);
                    bdr.setExtension(extension);
                }
            }

        }

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        BeanDescriptor bdr = new BeanDescriptor();
        try {
            handlemultipart(request, bdr);
            logger.info("Se ha realizado el request con exito");
        } catch (FileUploadException ex) {
            logger.error("Error al realizar el request: " + ex.toString());
        }
        HttpSession session = request.getSession(true);
        bdr.setFk_usuario((int) session.getAttribute("userid"));
        logger.info("Se guardo el archivo: " + bdr.getNombre());

        DriveModel dm = new DriveModel();
        dm.insertFile(bdr);

        request.getRequestDispatcher("listfiles.jsp").forward(request, response);
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
