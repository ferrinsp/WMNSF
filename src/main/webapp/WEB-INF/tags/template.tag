<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html>

<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="head" required="false" fragment="true" %>
<%@ attribute name="footer" required="false" fragment="true" %>
<%@ attribute name="pageTitle" required="false" fragment="false" %>
<script src="/static/js/jquery.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/jqui/jquery-ui.min.js"></script>
<script src="/static/js/toastr.js" ></script>
<script>
    $(document).ready(function () {
        <c:if test="${successNotification != null}">
        toastr["success"]("${successNotification}");
        </c:if>
        <c:if test="${infoNotification != null}">
        toastr["info"]("${infoNotification}");
        </c:if>
        <c:if test="${warningNotification != null}">
        toastr["warning"]("${warningNotification}");
        </c:if>
        <c:if test="${errorNotification != null}">
        toastr["error"]("${errorNotification}");
        </c:if>
    });
</script>
<link rel="stylesheet" href="/static/jqui/jquery-ui.min.css">
<link rel="stylesheet" href="/static/jqui/jquery-ui.structure.min.css">
<link rel="stylesheet" href="/static/jqui/jquery-ui.theme.min.css">
<link rel="stylesheet" href="/static/css/styles.css">
<link rel="stylesheet" href="/static/css/bootstrap.min.css">
<link rel="stylesheet" href="/static/css/toastr.css">
<html lang="en">
<head>
    <title><c:if test="${not empty pageTitle}"><c:out value="${pageTitle}"/></c:if></title>
    <jsp:invoke fragment="head"/>
</head>
<%@ include file="/WEB-INF/templates/header.jsp" %>
<jsp:doBody/>
<jsp:invoke fragment="footer"/>
<%@ include file="/WEB-INF/templates/footer.jsp" %>
</body>
</html>