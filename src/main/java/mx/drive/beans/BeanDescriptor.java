/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.drive.beans;

import java.io.InputStream;

/**
 *
 * @author miguel
 */
public class BeanDescriptor {

    int id;
    int fk_usuario;
    String mime;
    String extension;
    String nombre;
    String tamano;
    InputStream file;

    public BeanDescriptor(){
        mime=extension=nombre=tamano="";
    }
    public BeanDescriptor(int id, int fk_usuario, String mime, String extension, String nombre, String tamano) {
        this.id = id;
        this.fk_usuario = fk_usuario;
        this.mime = mime;
        this.extension = extension;
        this.nombre = nombre;
        this.tamano = tamano;
    }

    public void insertField(String inputname, String value)
    {
        if(inputname.equals("nombre"))nombre=value;
        if(inputname.equals("tamano"))tamano=value;
        if(inputname.equals("extension"))extension=value;
        if(inputname.equals("mime"))mime=value;
    }
    
    
    public InputStream getFile() {
        return file;
    }

    public void setFile(InputStream file) {
        this.file = file;
    }

    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(int fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public String getMime() {
        return mime;
    }

    public void setMime(String mime) {
        this.mime = mime;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTamano() {
        return tamano;
    }

    public void setTamano(String tamano) {
        this.tamano = tamano;
    }

}
