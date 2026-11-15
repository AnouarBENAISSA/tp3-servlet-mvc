<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>
            <c:choose>
                <c:when test="${empty produit.id}">Nouveau produit</c:when>
                <c:otherwise>Modifier le produit</c:otherwise>
            </c:choose>
        </title>
        <style>
            .error { color: red; font-size: 0.85em; margin-top: 2px; }
            .field-group { margin-bottom: 15px; }
        </style>
    </head>
    <body>
        <h1>
            <c:choose>
                <c:when test="${empty produit.id}">Nouveau produit</c:when>
                <c:otherwise>Modifier le produit</c:otherwise>
            </c:choose>
        </h1>

        <form action="${ctx}/produits" method="post">
            <c:if test="${not empty produit.id}">
                <input type="hidden" name="id" value="${produit.id}">
            </c:if>

            <div class="field-group">
                <label for="nom">Nom :</label><br>
                <input type="text" id="nom" name="nom" value="<c:out value="${produit.nom}"/>">
                <c:if test="${not empty erreurs.nom}">
                    <div class="error"><c:out value="${erreurs.nom}"/></div>
                </c:if>
            </div>

            <div class="field-group">
                <label for="description">Description :</label><br>
                <textarea id="description" name="description" rows="4" cols="30"><c:out value="${produit.description}"/></textarea>
                <c:if test="${not empty erreurs.description}">
                    <div class="error"><c:out value="${erreurs.description}"/></div>
                </c:if>
            </div>

            <div class="field-group">
                <label for="prix">Prix (DH) :</label><br>
                <input type="text" id="prix" name="prix" value="<c:out value="${produit.prix}"/>">
                <c:if test="${not empty erreurs.prix}">
                    <div class="error"><c:out value="${erreurs.prix}"/></div>
                </c:if>
            </div>

            <div class="field-group">
                <label for="stock">Stock :</label><br>
                <input type="text" id="stock" name="stock" value="<c:out value="${produit.stock}"/>">
                <c:if test="${not empty erreurs.stock}">
                    <div class="error"><c:out value="${erreurs.stock}"/></div>
                </c:if>
            </div>

            <div>
                <button type="submit">Enregistrer</button>
                <a href="${ctx}/produits">Annuler</a>
            </div>
        </form>
    </body>
</html>