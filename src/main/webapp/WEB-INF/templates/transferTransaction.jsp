<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<head>
    <link rel="stylesheet" href="/static/css/transferTransaction.css">
    <link rel="stylesheet" href="/static/css/dataTables.css">
    <script src="/static/js/dataTables.js"></script>
</head>

<div class="buttonHolder">
    <button class="btn btn-large btn-primary" id="btnNewTransfer">New Transfer Transaction</button>
</div>
<br/>
<br/>
<br/>
<table ID="tblTransferTransactions">
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
    <td><fmt:formatDate value="${transferTransaction.date}" pattern="MM-dd-yyyy" /></td>
    <td>${transferTransaction.getDescription()}</td>
    <td>${transferTransaction.debitUser.getFullName()}</td>
    <td>${transferTransaction.creditUser.getFullName()}</td>
    <td><fmt:formatNumber value="${transferTransaction.amount}" type="currency" /></td>
    <td>${transferTransaction.operatorUser.getFullName()}</td>
    <td>${transferTransaction.fundType.description}</td>
    </tr>
    </c:forEach>
</table>

<!---------------------------------------- add transfer transaction ------------------------------------------->

<form id="formAddTransferTransaction" name="addTransferTransaction" action="/Transaction/NewTransferTransaction" method="post">
    <h2 id="formHeader">Add Transfer Transaction</h2>
    <table id="tblAddTransferTransaction" class="table">

        <tr>
            <td>Date:</td>
            <td colspan="2">
                <input type="text" class="input-block-level" id="date" name="date"/>
            </td>
        </tr>

        <tr>
            <td>Description:</td>
            <td colspan="2">
                <textarea rows="5" class="input-block-level" id="description" name="description"></textarea>
            </td>
        </tr>

        <tr>
            <td>Debit Officer:</td>
            <td>
                <select id="debitOfficer" name="debitOfficer">
                    <c:forEach var="user" items="${allEnabledUsers}" >
                    <option value="${user.id}">${user.getFullName()}</option>
                    </c:forEach>
                </select>
            </td>
            <td>
                <input type="password" class="input-block-level" id="debitPassword" name="debitPassword"/>
            </td>
        </tr>

        <tr>
            <td>Credit Officer:</td>
            <td>
                <select id="creditOfficer" name="creditOfficer">
                    <c:forEach var="user" items="${allEnabledUsers}" >
                        <option value="${user.id}">${user.getFullName()}</option>
                    </c:forEach>
                </select>
            </td>
            <td>
                <input type="password" class="input-block-level" id="creditPassword" name="creditPassword"/>
            </td>
        </tr>

        <tr>
            <td>Fund Amount & Type:</td>
            <td>
                <input type="number" class="input-block-level" id="amount" name="amount"/>
            </td>
            <td>
                <select id="fundType" name="fundType">
                    <c:forEach var="fundType" items="${allActiveFundTypes}" >
                        <option value="${fundType.id}">${fundType.description}</option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr>
            <td>
                <input id="submit" type="submit" value="submit">
            </td>
        </tr>
    </table>
</form>

<script>
    $(document).ready(function () {
        $('#tblTransferTransactions').DataTable();
        $("#creditOfficer").val('${allEnabledUsers.get(1).id}');
        $('#btnNewTransfer').click(function () {
            transferModal.dialog("open");
        });
    });

    $(function() {
        $( "#date" ).datepicker();
    });

    transferModal = $("#formAddTransferTransaction").dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        width: 'auto',
        buttons: {
            "Submit": addTransfer,
            Cancel: cancel
        }
    });

    function addTransfer() {
        document.getElementById("submit").click();
    }

    function cancel() {
        $("#date").val("");
        $("#description").val("");
        $("#debitOfficer").val('${allEnabledUsers.get(0).id}');
        $("#debitPassword").val("");
        $("#creditOfficer").val('${allEnabledUsers.get(1).id}');
        $("#creditPassword").val("");
        $("#amount").val("");
        $("#fundType").val('${allActiveFundTypes.get(0).id}');
        transferModal.dialog("close");
    }
</script>
