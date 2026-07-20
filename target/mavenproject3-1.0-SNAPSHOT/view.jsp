<%-- 
    Document   : view
    Created on : 2026年6月9日, 17:54:58
    Author     : daiwei
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="bean.Category"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="bean.Goods"%>
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
            <%
                int category = 1;
                if (request.getParameter("category") != null) {
                    category = Integer.parseInt(request.getParameter("category"));
                } else {
                    category = Integer.parseInt(request.getAttribute("category").toString());
                }
                Collection<Goods> goodsc = (Collection<Goods>) request.getAttribute("goodsc");
                Iterator<Goods> itb = goodsc.iterator();
                while (itb.hasNext()) {
                    Goods goods = itb.next();
            %>
            <a href="Detail?category=<%=category%>&id=<%=goods.getId()%>" class="show"><img src="<%=goods.getImage()%>"><span class="goods">商品名：<%=goods.getName()%></span><span class="price">单价：￥<%=goods.getPrice()%></span><span class="store">库存：<%=goods.getStore()%></span></a>
            <%
                }
            %>
            <a class="link" href="Create?category=<%=category%>">new</a>
        </div>
        <div id="nav">                
            <% int number = Integer.parseInt(request.getAttribute("number").toString());
                int pages = 0, current = 1;
                if (number == 0) {
                    pages = 0;
                } else if (number % 10 == 0) {
                    pages = number / 10;
                } else {
                    pages = (int) (number / 10 + 1);
                }
                if (request.getParameter("current") != null) {
                    current = Integer.parseInt(request.getParameter("current"));
                } else {
                    current = 1;
                }
                if (current > 1) {
            %>
            <a href="View?category=<%=category%>&current=<%=current - 1%>">&lt;preview</a>
            <%
                }
                for (int i = 1; i <= pages; i++) {
                    if (i == current) {
            %>
            <a href="javascript:void(0);" style="color:gray;"><%=i%></a>
            <%
            } else {%>
            <a href="View?category=<%=category%>&current=<%=i%>"><%=i%></a>
            <%
                    }
                }
                if (current > 1) {
            %>
            <a href="View?category=<%=category%>&current=<%=current + 1%>">preview&gt;</a>
            <%
                }
            %>
        </div>
    </body>
</html>
