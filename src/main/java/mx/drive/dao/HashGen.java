/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.drive.dao;

import com.google.common.base.Charsets;
import com.google.common.hash.Hashing;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import mx.drive.controller.ShareWith;
import mx.drive.util.Conexion;
import org.apache.logging.log4j.LogManager;

/**
 *
 * @author miguel
 */
public class HashGen {

    private org.apache.logging.log4j.Logger logger = LogManager.getLogger(HashGen.class.getName());

    public boolean validateOwner(int userid, int fileid) throws SQLException {
        String query = "Select nombre from Descriptor where fk_usuario=? AND id=?";
        Connection con = Conexion.getConexion();
        PreparedStatement pstm = con.prepareStatement(query);
        pstm.setInt(1, userid);
        pstm.setInt(2, fileid);

        ResultSet res = pstm.executeQuery();
        int cantidad = 0;
        if (res.next()) {
            cantidad++;
        }
        return cantidad == 1;

    }

    public String genhash(int userid, int fileid) {
        String hash = Hashing.sha1().hashString(String.valueOf(userid) + String.valueOf(fileid), Charsets.UTF_8).toString();
        return hash;
    }

    public String getFriends(int fileid) {
        String query = "Select distinct correo from Usuario,Descriptor,Puedever where Usuario.id=Puedever.fk_usuario AND fk_archivo=?";
        Connection con = Conexion.getConexion();
        String friends = "";
        PreparedStatement pstm = null;
        try {
            pstm = con.prepareStatement(query);

            pstm.setInt(1, fileid);
            ResultSet res = pstm.executeQuery();
            int userid = -1;
            while (res.next()) {
                friends+=res.getString("correo")+"&&";
            }
            return friends;
        } catch (SQLException ex) {
            logger.info(ex.toString());
        }
        return null;

    }

    public boolean sharewith(String correo, int fileid) {
        String query = "Select id from Usuario where correo=?";
        Connection con = Conexion.getConexion();
        PreparedStatement pstm = null;
        try {
            pstm = con.prepareStatement(query);

            pstm.setString(1, correo);
            ResultSet res = pstm.executeQuery();
            int userid = -1;
            if (res.next()) {
                userid = res.getInt("id");
            }
            String query2 = "Insert INTO Puedever VALUES (?,?)";
            pstm = con.prepareStatement(query2);
            pstm.setInt(1, fileid);
            pstm.setInt(2, userid);
            int row = pstm.executeUpdate();
        } catch (SQLException ex) {
            logger.info(ex.toString());
        }

        return true;

    }

}
