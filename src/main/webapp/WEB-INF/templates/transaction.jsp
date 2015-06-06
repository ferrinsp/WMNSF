<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<tags:template pageTitle="Transactions">
    <jsp:attribute name="head">
        <link rel="stylesheet" href="/static/css/transactionStyleSheet.css">
    </jsp:attribute>
    <jsp:body>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Date</th>
                    <th>Description</th>
                    <th>Debit Officer</th>
                    <th>Credit Officer</th>
                    <th>Amount</th>
                    <th>Operator</th>
                    <th>Fund Type</th>
                </tr>
            </thead>
            <c:forEach var="transferTransaction" items="${transferTransactions}" >
                <tr>
                    <td>${transferTransaction.getId()}</td>
                    <td>${transferTransaction.getDate()}</td>
                    <td>${transferTransaction.getDescription()}</td>
                    <td>${transferTransaction.getDebitUser().getFirstName()}</td>
                    <td>${transferTransaction.getCreditUser().getLastName()}</td>
                    <td>${transferTransaction.getAmount()}</td>
                    <td>${transferTransaction.getOperatorUser().getFullName()}</td>
                    <td>${transferTransaction.getFundType().getDescription()}</td>
                </tr>
            </c:forEach>
        </table>
    </jsp:body>
</tags:template>