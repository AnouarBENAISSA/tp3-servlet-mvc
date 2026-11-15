<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>Connexion</title>
    </head>
    <body>
        <h1>Connexion à l'application</h1>
        <c:if test="${not empty erreur}">
            <p style="color: red;"><c:out value="${erreur}"/></p>
        </c:if>
        <form action="${ctx}/login" method="post">
            <div>
                <label for="username">Nom d'utilisateur :</label>
                <input type="text" id="username" name="username" value="<c:out value="${username}"/>" required>
            </div>
            <div>
                <label for="password">Mot de passe :</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div>
                <button type="submit">Se connecter</button>
            </div>
        </form>
    </body>
</html>