package servlets.transparencia;

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

import dao.transparencia.CCurDAO;
import pojo.transparencia.CCur;

/**
 * Servlet implementation class STransparenciaCompras
 */
@WebServlet("/STransparenciaCurs")
public class STransparenciaCurs extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public STransparenciaCurs() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response,)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setHeader("Content-Encoding", "gzip");
		response.setCharacterEncoding("UTF-8");

		OutputStream output = response.getOutputStream();
		GZIPOutputStream gz = new GZIPOutputStream(output);
		String response_text = "";

		Gson gson = new Gson();
		Type type = new TypeToken<Map<String, String>>() {
		}.getType();
		StringBuilder sb = new StringBuilder();
		BufferedReader br = request.getReader();
		String str;
		while ((str = br.readLine()) != null) {
			sb.append(str);
		}
		;
		Map<String, String> map = gson.fromJson(sb.toString(), type);
		String action = map.get("action");
		int subprograma = map.get("subprograma")!=null ? Integer.parseInt(map.get("subprograma")) : 0;
		int id_cur = map.get("idCur")!=null ? Integer.parseInt(map.get("idCur")) : 0;
		int ejercicio = map.get("ejercicio")!=null && map.get("ejercicio").length()>0 ? Integer.parseInt(map.get("ejercicio")) : 0;
		int entidad = map.get("entidad")!=null && map.get("entidad").length()>0 ? Integer.parseInt(map.get("entidad")) : 0;
		int unidad_ejecutora = map.get("undidad_ejecutora")!=null && map.get("undidad_ejecutora").length()>0 ? Integer.parseInt(map.get("undidad_ejecutora")) : 0;
		if (action.compareTo("getlist") == 0) {
			ArrayList<CCur> curs = CCurDAO.getCurs(subprograma);
			response_text = new GsonBuilder().serializeNulls().create().toJson(curs);		
			response_text = String.join("", "\"curs\":", response_text);
			response_text = String.join("", "{\"success\":true,", response_text, "}");
		}else if (action.compareTo("add") == 0) {
			
				CCur cur = new CCur(94,7,ejercicio,entidad,unidad_ejecutora,id_cur);
				if (CCurDAO.crearCur(cur))
					response_text = String.join("", "{\"success\":true, \"result\":\"creado\"}");
				else
					response_text = String.join("", "{\"success\":false, \"result\":\"no creado\"}");
			
		}else if (action.compareTo("delete") == 0) {
			if (CCurDAO.deleteCur(94,subprograma, ejercicio,entidad, unidad_ejecutora, id_cur))
				response_text = String.join("", "{\"success\":true, \"result\":\"borrado\"}");
			else
				response_text = String.join("", "{\"success\":false, \"result\":\"no borrado\"}");
		}			
		gz.write(response_text.getBytes("UTF-8"));
		gz.close();
		output.close();
	}

}
