<%-- 
    Document   : detail
    Created on : 2026年6月10日, 18:19:43
    Author     : daiwei
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="bean.Goods"%>
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
            <c:forEach items="${categories}" var="category" varStatus="status">
                <a href="View?category=${category.id}">${category.name}</a>
            </c:forEach>
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
            <p>${goods.name}</p>
            <% Goods goods = (Goods) request.getAttribute("goods");
            %>

            <p><%=goods.getName()%></p>
            <img src="<%=goods.getImage()%>">
            <a href="Modify?id=<%=goods.getId()%>">modify</a><br>
            <a href="Delete?id=<%=goods.getId()%>">delete</a><br>
        </div>
        <div id="nav">
            <p><%=request.getAttribute("next")%></p>
            <%
                String category = (String) request.getAttribute("category");
                if (request.getAttribute("previous") != null) {
                    Goods previous = (Goods) request.getAttribute("previous");
            %>
            <a href="Detail?category=<%=category%>&id=<%=previous.getId()%>">&lt;previous</a>
            <%
                }
                if (request.getAttribute("next") != null) {
                    Goods next = (Goods) request.getAttribute("next");
            %>
            <a href="Detail?category=<%=category%>&id=<%=next.getId()%>">next&gt;</a>
            <%
                }
            %>
        </div>
    </body>
</html>
