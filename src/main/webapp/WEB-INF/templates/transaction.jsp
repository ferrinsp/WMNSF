<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<tags:template pageTitle="Transactions">
    <jsp:attribute name="head">
        <link rel="stylesheet" href="/static/css/transactionStyleSheet.css">
        <link rel="stylesheet" href="/static/css/dataTables.css">
        <script src="/static/js/dataTables.js"></script>
    </jsp:attribute>
    <jsp:body>
        <table ID="tblTransferTransactions" >
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
                    <td><fmt:formatDate value="${transferTransaction.date.time}" pattern="MM-dd-yyyy" /></td>
                    <td>${transferTransaction.getDescription()}</td>
                    <td>${transferTransaction.debitUser.getFullName()}</td>
                    <td>${transferTransaction.creditUser.getFullName()}</td>
                    <td><fmt:formatNumber value="${transferTransaction.amount}" type="currency" /></td>
                    <td>${transferTransaction.operatorUser.getFullName()}</td>
                    <td>${transferTransaction.fundType.description}</td>
                </tr>
            </c:forEach>
        </table>

        <script>
            $(document).ready(function(){
                $('#tblTransferTransactions').DataTable();
            });
        </script>
    </jsp:body>
</tags:template>