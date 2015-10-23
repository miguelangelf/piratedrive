package mx.drive.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;
import java.util.logging.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class Conexion {

    private static Logger logger = LogManager.getLogger(Conexion.class.getName());
    private static String ipAddress;
    private static String dbName;
    private static String user;
    private static String password;
    private static String service;
    private static ResourceBundle dbProperties;

    public static Connection getConexion() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println(e.getMessage());
        }

        if (dbProperties == null) {
            dbProperties = ResourceBundle.getBundle("combodb");
            ipAddress = dbProperties.getString("ip_address");
            dbName = dbProperties.getString("db_name");
            user = dbProperties.getString("user");
            password = dbProperties.getString("password");
            service = dbProperties.getString("service");
        }
        Connection con = null;

        try {

            logger.info("Se ha realizado una conexion a la base de datos");
            con = DriverManager.getConnection("jdbc:mysql://" + ipAddress + ":" + service + "/" + dbName, user, password);
        } catch (SQLException ex) {

            logger.info("Error al conectar con la bd");
            java.util.logging.Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }

        return con;
    }
/*
    public static void main(String[] args) {

        Conexion con = new Conexion();
        con.getConexion();

    }
    */
}
