package utilities;

import java.io.InputStream;
import java.util.Properties;

public class CProperties {
	private static Properties properties;
	private static String memsql_host="";
	private static String memsql_host_intra="";
	private static Integer memsql_port=null;
	private static String memsql_user="";
	private static String memsql_password="";
	private static String memsql_schema=null;
	private static String memsql_schema_des=null;
	private static String memsql_schema_estados_excepcion;
	
	private static String oracle_host="";
	private static Integer oracle_port=null;
	private static String oracle_user="";
	private static String oracle_password="";
	private static String oracle_schema=null;
	
	private static String oracle_sicoinp_host="";
	private static Integer oracle_sicoinp_port=null;
	private static String oracle_sicoinp_user="";
	private static String oracle_sicoinp_password="";
	
	static{
		InputStream input;
		properties = new Properties();
		input = CProperties.class.getClassLoader().getResourceAsStream("config.properties");
		try{
			properties.load(input);
			memsql_host = properties.getProperty("memsql_host");
			memsql_host_intra = properties.getProperty("memsql_host_intra");
			memsql_port = properties.getProperty("memsql_port") != null ? 
					Integer.parseInt(properties.getProperty("memsql_port")) : null;
			memsql_schema = properties.getProperty("memsql_schema");
			memsql_schema_des = properties.getProperty("memsql_schemades");
			memsql_schema_estados_excepcion = properties.getProperty("memsql_schema_estados_excepcion");
			memsql_user = properties.getProperty("memsql_user");
			memsql_password = properties.getProperty("memsql_password");
			
			oracle_host = properties.getProperty("oracle_host");
			oracle_port = properties.getProperty("oracle_port") != null ? 
					Integer.parseInt(properties.getProperty("oracle_port")) : null;
			oracle_schema = properties.getProperty("oracle_schema");
			oracle_user = properties.getProperty("oracle_user");
			oracle_password = properties.getProperty("oracle_password");
			
			oracle_sicoinp_host = properties.getProperty("oracle_sicoinp_host");
			oracle_sicoinp_port = properties.getProperty("oracle_sicoinp_port") != null ? 
					Integer.parseInt(properties.getProperty("oracle_sicoinp_port")) : null;
			oracle_sicoinp_user = properties.getProperty("oracle_sicoinp_user");
			oracle_sicoinp_password = properties.getProperty("oracle_sicoinp_password");
			
			
		}
		catch(Throwable e){
			CLogger.write("1", CProperties.class, e);
		}
		finally{
			
		}
	}

	public static String getOracle_host() {
		return oracle_host;
	}

	public static void setOracle_host(String oracle_host) {
		CProperties.oracle_host = oracle_host;
	}

	public static Integer getOracle_port() {
		return oracle_port;
	}

	public static void setOracle_port(Integer oracle_port) {
		CProperties.oracle_port = oracle_port;
	}

	public static String getOracle_user() {
		return oracle_user;
	}

	public static void setOracle_user(String oracle_user) {
		CProperties.oracle_user = oracle_user;
	}

	public static String getOracle_password() {
		return oracle_password;
	}

	public static void setOracle_password(String oracle_password) {
		CProperties.oracle_password = oracle_password;
	}

	public static String getOracle_schema() {
		return oracle_schema;
	}

	public static void setOracle_schema(String oracle_schema) {
		CProperties.oracle_schema = oracle_schema;
	}

	public static Properties getProperties() {
		return properties;
	}

	public static void setProperties(Properties properties) {
		CProperties.properties = properties;
	}

	public static String getmemsql_host() {
		return memsql_host;
	}

	public static void setmemsql_host(String memsql_host) {
		CProperties.memsql_host = memsql_host;
	}
	
	public static String getmemsql_host_intra() {
		return memsql_host_intra;
	}

	public static void setmemsql_host_intra(String memsql_host_intra) {
		CProperties.memsql_host_intra = memsql_host_intra;
	}

	public static Integer getmemsql_port() {
		return memsql_port;
	}

	public static void setmemsql_port(Integer memsql_port) {
		CProperties.memsql_port = memsql_port;
	}

	public static String getmemsql_user() {
		return memsql_user;
	}

	public static void setmemsql_user(String memsql_user) {
		CProperties.memsql_user = memsql_user;
	}

	public static String getmemsql_password() {
		return memsql_password;
	}

	public static void setmemsql_password(String memsql_password) {
		CProperties.memsql_password = memsql_password;
	}

	public static String getmemsql_schema(){
		return memsql_schema;
	}
	
	public void setmemsql_schema(String memsql_schema){
		CProperties.memsql_schema = memsql_schema;
	}
	
	public static String getmemsql_schema_des(){
		return memsql_schema_des;
	}
	
	public void setmemsql_schema_des(String memsql_schema_des){
		CProperties.memsql_schema_des = memsql_schema_des;
	}
	
	public static String getmemsql_schema_estados_excepcion(){
		return memsql_schema_estados_excepcion;
	}
	
	public void setmemsql_schema_estados_excepcion(String memsql_schema_estados_excepcion){
		CProperties.memsql_schema_des = memsql_schema_estados_excepcion;
	}

	public static String getOracle_sicoinp_host() {
		return oracle_sicoinp_host;
	}

	public static void setOracle_sicoinp_host(String oracle_sicoinp_host) {
		CProperties.oracle_sicoinp_host = oracle_sicoinp_host;
	}

	public static Integer getOracle_sicoinp_port() {
		return oracle_sicoinp_port;
	}

	public static void setOracle_sicoinp_port(Integer oracle_sicoinp_port) {
		CProperties.oracle_sicoinp_port = oracle_sicoinp_port;
	}

	public static String getOracle_sicoinp_user() {
		return oracle_sicoinp_user;
	}

	public static void setOracle_sicoinp_user(String oracle_sicoinp_user) {
		CProperties.oracle_sicoinp_user = oracle_sicoinp_user;
	}

	public static String getOracle_sicoinp_password() {
		return oracle_sicoinp_password;
	}

	public static void setOracle_sicoinp_password(String oracle_sicoinp_password) {
		CProperties.oracle_sicoinp_password = oracle_sicoinp_password;
	}
}
