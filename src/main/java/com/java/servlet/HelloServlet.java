package com.java.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HelloServlet
 */
public class HelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HelloServlet() {
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
		String jdbcUrl = request.getParameter("url");
		Connection con = getCon(jdbcUrl);
		String message = con == null ? "No connection" : con.toString();
		response.getWriter().append("Served at: ").append(request.getContextPath() + " and " + message);
	}

	public static Connection getCon(String jdbcUrl) {
		
		String url = null;
		url = jdbcUrl;
		if (jdbcUrl == null || jdbcUrl.isEmpty()) {
			url = "jdbc:mysql://misql:3306/mydb";
		}
		
		String userName = "root";
		String password = "password1";

		Connection con = null;

		try {
			con = DriverManager.getConnection(url, userName, password);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return con;
	}

}
