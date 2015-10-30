/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.drive.dao;

import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.logging.Level;
import mx.drive.beans.BeanDescriptor;
import mx.drive.beans.BeanUsuario;
import mx.drive.util.Conexion;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 *
 * @author miguel
 */
public class DriveModel {

    private Logger logger = LogManager.getLogger(DriveModel.class.getName());

    public ArrayList<BeanDescriptor> getListofFilesAdmin() throws SQLException {
        ArrayList<BeanDescriptor> files = new ArrayList<>();
        String query = "Select * from Descriptor";
        Connection con = Conexion.getConexion();
        PreparedStatement pstm = con.prepareStatement(query);
        ResultSet res = pstm.executeQuery();
        while (res.next()) {
            int id = res.getInt("id");
            int fk_usuario = res.getInt("fk_usuario");
            String mime = res.getString("mime");
            String extension = res.getString("extension");
            String nombre = res.getString("nombre");
            String tamano = res.getString("tamano");
            BeanDescriptor bdr = new BeanDescriptor(id, fk_usuario, mime, extension, nombre, tamano);
            files.add(bdr);
        }
        return files;
    }

    public ArrayList<BeanDescriptor> getListofFiles(int usuario) throws SQLException {
        ArrayList<BeanDescriptor> files = new ArrayList<>();
        String query = "Select * from Descriptor where Descriptor.fk_usuario=?  ";
        Connection con = Conexion.getConexion();
        PreparedStatement pstm = con.prepareStatement(query);
        pstm.setInt(1, usuario);
        ResultSet res = pstm.executeQuery();
        while (res.next()) {
            int id = res.getInt("id");
            int fk_usuario = res.getInt("fk_usuario");
            String mime = res.getString("mime");
            String extension = res.getString("extension");
            String nombre = res.getString("nombre");
            String tamano = res.getString("tamano");
            BeanDescriptor bdr = new BeanDescriptor(id, fk_usuario, mime, extension, nombre, tamano);
            files.add(bdr);
        }
        return files;
    }

    public ArrayList<BeanDescriptor> sharedWithMe(int usuario) throws SQLException {
        ArrayList<BeanDescriptor> files = new ArrayList<>();
        String query = "Select id,nombre,mime,extension,tamano,Descriptor.fk_usuario from Descriptor,Puedever where Puedever.fk_usuario=? and Puedever.fk_archivo = Descriptor.id    ";
        Connection con = Conexion.getConexion();
        PreparedStatement pstm = con.prepareStatement(query);
        pstm.setInt(1, usuario);
        ResultSet res = pstm.executeQuery();
        while (res.next()) {
            int id = res.getInt("id");
            int fk_usuario = res.getInt("fk_usuario");
            String mime = res.getString("mime");
            String extension = res.getString("extension");
            String nombre = res.getString("nombre");
            String tamano = res.getString("tamano");
            BeanDescriptor bdr = new BeanDescriptor(id, fk_usuario, mime, extension, nombre, tamano);
            files.add(bdr);
        }
        return files;
    }

    public boolean isValidUser(String correo) throws SQLException {
        String query = "Select COUNT (correo) from Usuario where correo = ?";
        Connection con = Conexion.getConexion();
        PreparedStatement pstm = con.prepareStatement(query);
        ResultSet res = pstm.executeQuery();
        int cantidad = 0;
        if (res.next()) {
            cantidad++;
        }
        return cantidad == 1;
    }
    
    public boolean NewUser(String correo, String password) throws SQLException {
        String query = "insert into Usuario values(?,?,?)";
        Connection con = Conexion.getConexion();
        try {
            PreparedStatement pstm = con.prepareStatement(query);
            pstm.setNull(1,Types.INTEGER);
            pstm.setString(2, correo);
            pstm.setString(3, password);
            pstm.execute();
            return true;
        } catch (Exception e) {
            logger.info(e.toString());
            return false;
        }
    }

    public boolean insertFile(BeanDescriptor bdr) {
        String query = "Insert INTO Descriptor VALUES (?,?,?,?,?,?);";
        Connection con = Conexion.getConexion();
        PreparedStatement pstm = null;
        try {
            pstm = con.prepareStatement(query);
            pstm.setNull(1, Types.INTEGER);
            pstm.setString(2, bdr.getNombre());
            pstm.setString(3, bdr.getMime());
            pstm.setString(4, bdr.getExtension());
            pstm.setString(5, bdr.getTamano());
            pstm.setInt(6, bdr.getFk_usuario());

            int row = pstm.executeUpdate();

            logger.info("Guardado correctamente");
        } catch (SQLException ex) {
            logger.error(ex.toString());
        }

        int lastrow = 0;
        ResultSet rs = null;
        try {
            rs = pstm.getGeneratedKeys();
        } catch (SQLException ex) {
            logger.error(ex.toString());
        }

        try {
            if (rs.next()) {
                lastrow = rs.getInt(1);
                logger.info("Se creo el archivo " + lastrow);
            }
        } catch (SQLException ex1) {
            logger.error(ex1.toString());
        }

        String query2 = "Insert INTO Archivo VALUES (?,?)";
        try {
            pstm = con.prepareStatement(query2);
            pstm.setBlob(1, bdr.getFile());
            pstm.setInt(2, lastrow);

        } catch (SQLException ex) {
            logger.error(ex.toString());
        }

        boolean resultado = false;

        try {
            resultado = pstm.execute();
            logger.info("Se ha guardado el archivo correctamente");
        } catch (SQLException ex) {
            logger.info("Error al guardar archivo " + ex.toString());
            java.util.logging.Logger.getLogger(DriveModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return true;
    }

    public boolean createUser(BeanUsuario bu) throws SQLException {
        String correo = bu.getCorreo();
        String password = bu.getPassword();
        String query = "INSERT INTO Usuario VALUES (?,?,?);";

        if (isValidUser(correo)) {

            Connection con = Conexion.getConexion();
            PreparedStatement pstm = con.prepareStatement(query);
            pstm.setNull(1, Types.INTEGER);
            pstm.setString(2, correo);
            pstm.setString(3, password);
            return true;

        } else {
            return false;
        }
    }

    public BeanDescriptor getFileDesc(int file_id) throws SQLException {
        String query = "Select * from Archivo, Descriptor where fk_descriptor=? and id=fk_descriptor";
        Connection con = Conexion.getConexion();
        PreparedStatement pstm = con.prepareStatement(query);
        pstm.setInt(1, file_id);
        ResultSet res = pstm.executeQuery();

        if (res.next());

        Blob thefile = res.getBlob("file");
        BeanDescriptor bdr = new BeanDescriptor();
        String mime = res.getString("mime");
        String extension = res.getString("extension");
        String nombre = res.getString("nombre");
        String tamano = res.getString("tamano");

        bdr.setExtension(extension);
        bdr.setFile(thefile.getBinaryStream());
        bdr.setMime(mime);
        bdr.setNombre(nombre);
        bdr.setTamano(tamano);

        return bdr;

    }

}
