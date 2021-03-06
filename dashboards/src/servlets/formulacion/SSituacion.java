package servlets.formulacion;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Map;
import java.util.zip.GZIPOutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import dao.formulacion.CSituacionFinancieraDAO;
import pojo.formulacion.CSituacionFinanciera;
import utilities.Utils;

/**
 * Servlet implementation class SSituacion
 */
@WebServlet("/SSituacion")
public class SSituacion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SSituacion() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		Type type = new TypeToken<Map<String, String>>(){}.getType();
		StringBuilder sb = new StringBuilder();
	    BufferedReader br = request.getReader();
	    String str;
	    while( (str = br.readLine()) != null ){
	        sb.append(str);
	    };
		Map<String, String> map = gson.fromJson(sb.toString(), type);
		String action = map.get("action");
		String response_text="";
		int ejercicio = Utils.String2Int(map.get("ejercicio"), 0);
		response.setHeader("Content-Encoding", "gzip");
		response.setCharacterEncoding("UTF-8");
		if(action.equals("getReporte")) {
			if(ejercicio>0) {
				ArrayList<CSituacionFinanciera> lineas = CSituacionFinancieraDAO.getReporte(ejercicio);
				response_text=new GsonBuilder().serializeNulls().create().toJson(lineas);
	            response_text = String.join("", "\"lineas\":",response_text);
	            response_text = String.join("", "{\"success\":true,", response_text,"}");
			}
			else {
				response_text = String.join("", "{\"success\":false }");
			}
		}
		OutputStream output = response.getOutputStream();
		GZIPOutputStream gz = new GZIPOutputStream(output);
	    gz.write(response_text.getBytes("UTF-8"));
	    gz.close();
	    output.close();
	}

}
