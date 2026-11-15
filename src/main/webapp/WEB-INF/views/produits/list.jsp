<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Catalogue de produits</title>
    </head>
    <body>
        <h1>Catalogue de produits</h1>
        <c:if test="${not empty sessionScope.flash}">
            <div style="background-color: #d4edda; color: #155724; padding: 10px; margin-bottom: 15px; border: 1px solid #c3e6cb;">
                <c:out value="${sessionScope.flash}"/>
            </div>
            <c:remove var="flash" scope="session"/>
        </c:if>
        <p><a href="${ctx}/produits?action=new">Ajouter un produit</a></p>
        <c:if test="${empty produits}">
            <p>Aucun produit enregistré.</p>
        </c:if>
        <c:if test="${not empty produits}">
            <table border="1" cellpadding="8" cellspacing="0">
                <tr>
                    <th>Nom</th>
                    <th>Description</th>
                    <th>Prix</th>
                    <th>Stock</th>
                    <th>Actions</th>
                </tr>
                <c:forEach items="${produits}" var="p">
                    <tr>
                        <%-- Utilisation de <c:out> pour se prémunir des failles XSS[cite: 7] --%>
                        <td><c:out value="${p.nom}"/></td>
                        <td><c:out value="${p.description}"/></td>
                        <td>
                            <fmt:formatNumber value="${p.prix}" type="number" minFractionDigits="2" maxFractionDigits="2"/> DH
                        </td>
                        <td>
                            <span style="color: ${p.stock == 0 ? 'red' : 'inherit'};">
                                <c:out value="${p.stock}"/>
                            </span>
                        </td>
                        <td>
                            <a href="${ctx}/produits?action=edit&id=${p.id}">Éditer</a>
                            <form action="${ctx}/produits" method="post" style="display:inline;" onsubmit="return confirm('Confirmer la suppression de ce produit ?');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${p.id}">
                                <button type="submit" style="background:none; color:blue; border:none; padding:0; cursor:pointer; text-decoration:underline;">Supprimer</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
        <p style="margin-top: 20px;"><a href="${ctx}/dashboard">Retour au tableau de bord</a></p>
    </body>
</html>