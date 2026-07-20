<%-- 
    Document   : new
    Created on : 2026年6月12日, 07:50:12
    Author     : daiwei
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="bean.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link type="text/css" rel="stylesheet" href="style.css">
    </head>
    <body>
        <h1>Hello World!</h1>
        <div id="left">
            <% Collection<Category> categories = (Collection<Category>) request.getAttribute("categories");
                Iterator<Category> it = categories.iterator();
                while (it.hasNext()) {
                    Category category = it.next();
            %>
            <a href="View?category=<%=category.getId()%>"><%=category.getName()%></a>
            <%
                }
            %>
        </div>
        <div id="right">
            <%
                int category = 1;
                if (request.getParameter("category") != null) {
                    category = Integer.parseInt(request.getParameter("category"));
                } else {
                    category = Integer.parseInt(request.getAttribute("category").toString());
                }
            %>
            <form action="DoCreate?category=<%=category%>" method="post" enctype="multipart/form-data">
                商品名：<input type="text" name="name"><br>
                价格：<input type="text" name="price"><br>
                库存：<input type="text" name="store"><br>
                已卖出：<input type="text" name="sell"><br>
                商品图片：<input type="file" name="image"><br>
                <input type="submit">
                <input type="reset">
            </form>
        </div>
    </body>
</html>
