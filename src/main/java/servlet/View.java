/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import bean.Category;
import bean.Goods;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

/**
 *
 * @author daiwei
 */
public class View extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            /*out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet View</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet View at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");*/
            // JDBC 驱动名及数据库 URL
            Connection conn = null;
            Statement stmt = null;
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 打开一个连接
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8", "root", "@Passw0rd");

            // 执行 SQL 查询
            stmt = conn.createStatement();
            String sql;
            sql = "SELECT id, name FROM category";
            Collection<Category> categories = new ArrayList<>();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                // 通过字段检索
                int id = rs.getInt("id");
                String name = rs.getString("name");
                Category category = new Category();
                category.setId(id);
                category.setName(name);
                categories.add(category);

            }
            
            String start = "0";
            if (request.getParameter("current") != null) {
                start = Integer.toString((Integer.parseInt(request.getParameter("current")) - 1) * 10);
            }
            request.setAttribute("categories", categories);
            sql = "SELECT * FROM goods WHERE category=" + request.getParameter("category") + " LIMIT " + start + ", 10";
            Collection<Goods> goodsc = new ArrayList<>();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                // 通过字段检索
                int id = rs.getInt("id");
                int category = rs.getInt("category");
                String name = rs.getString("name");
                float price = rs.getFloat("price");
                int store = rs.getInt("store");
                int sell = rs.getInt("sell");
                String image = rs.getString("image");
                String date = rs.getString("date");
                Goods goods = new Goods();
                goods.setId(id);
                goods.setCategory(category);
                goods.setName(name);
                goods.setPrice(price);
                goods.setStore(store);
                goods.setSell(sell);
                goods.setImage(image);
                goods.setDate(date);
                goodsc.add(goods);
            }
            request.setAttribute("goodsc", goodsc);

            sql = "SELECT count(*) FROM goods WHERE category=" + request.getParameter("category");
            rs = stmt.executeQuery(sql);
            int number = 0;
            if (rs.next()) {
                number = rs.getInt(1);
            }
            request.setAttribute("number", number);

            String category = null;
            if (request.getParameter("category") != null) {
                category = request.getParameter("category");
                request.setAttribute("category", category);
            } else {
                sql = "SELECT * FROM category LIMIT 1;";
                rs = stmt.executeQuery(sql);
                if (rs.next()) {
                    category = Integer.toString(rs.getInt("id"));
                }
                request.setAttribute("category", category);
            }
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("view.jsp");
            //response.sendRedirect("result.jsp");
            dispatcher.forward(request, response);

            // 完成后关闭
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException se) {
            // 处理 JDBC 错误
            se.printStackTrace();
        } catch (Exception e) {
            // 处理 Class.forName 错误
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
