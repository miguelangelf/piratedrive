/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.drive.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import mx.drive.util.Conexion;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 *
 * @author miguel
 */
public class Login {

    private Logger logger = LogManager.getLogger(DriveModel.class.getName());
    public int userid;

    public boolean makeLogin(String correo, String password) {
        String query = "Select id from Usuario where correo=? AND password = ?";
        Connection con = Conexion.getConexion();
        int counter=0;
        try {
            PreparedStatement pstm = con.prepareStatement(query);
            pstm.setString(1, correo);
            pstm.setString(2, password);
            ResultSet res = pstm.executeQuery();
            if (res.next()) {
                counter++;
                userid=res.getInt("id");
            }

        } catch (Exception e) {
            logger.info(e.toString());
        }
        return counter==1;

    }

    public void signin() {

    }
}
