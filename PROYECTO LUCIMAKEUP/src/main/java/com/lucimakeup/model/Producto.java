package com.lucimakeup.model;

/**
 * Clase que representa el modelo de datos para los productos de Lucimakeup Store.
 * Funciona como un objeto POJO (Plain Old Java Object) para el transporte de información.
 * 
 * @author Adriana Mora
 * @version 1.0
 */
public class Producto {
    private int idProducto;
    private String nombreProducto;
    private String descripcionProducto;
    private double precioProducto;
    private int stockProducto;
    private int categoriaIdCategoria;

    /**
     * Constructor vacio por defecto.
     */
    public Producto() {}

    /**
     * Constructor con parametros para inicializar un producto completo.
     */
    public Producto(int idProducto, String nombreProducto, String descripcionProducto, double precioProducto, int stockProducto, int categoriaIdCategoria) {
        this.idProducto = idProducto;
        this.nombreProducto = nombreProducto;
        this.descripcionProducto = descripcionProducto;
        this.precioProducto = precioProducto;
        this.stockProducto = stockProducto;
        this.categoriaIdCategoria = categoriaIdCategoria;
    }

    // Getters y Setters
    public int getIdProducto() { return idProducto; }
    public void setIdProducto(int idProducto) { this.idProducto = idProducto; }

    public String getNombreProducto() { return nombreProducto; }
    public void setNombreProducto(String nombreProducto) { this.nombreProducto = nombreProducto; }

    public String getDescripcionProducto() { return descripcionProducto; }
    public void setDescripcionProducto(String descripcionProducto) { this.descripcionProducto = descripcionProducto; }

    public double getPrecioProducto() { return precioProducto; }
    public void setPrecioProducto(double precioProducto) { this.precioProducto = precioProducto; }

    public int getStockProducto() { return stockProducto; }
    public void setStockProducto(int stockProducto) { this.stockProducto = stockProducto; }

    public int getCategoriaIdCategoria() { return categoriaIdCategoria; }
    public void setCategoriaIdCategoria(int categoriaIdCategoria) { this.categoriaIdCategoria = categoriaIdCategoria; }
}