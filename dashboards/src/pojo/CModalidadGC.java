package pojo;

public class CModalidadGC {
	
	int id;
	String nombre;
	int total;
	
	
	public CModalidadGC(int id, String nombre, int total) {
		super();
		this.id = id;
		this.nombre = nombre;
		this.total = total;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
	
}
