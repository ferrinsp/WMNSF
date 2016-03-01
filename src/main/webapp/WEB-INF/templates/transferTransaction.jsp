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
    <button class="btn btn-large btn-primary" id="btnNewDeposit">New Deposit Transaction</button>
</div>
<br/>
<br/>
<br/>
<table ID="tblTransferTransactions">
    <thead>
    <tr>
        <th>ID</th>
        <th>Date</th>
        <th>Type</th>
        <th>Description</th>
        <th>Debit Officer</th>
        <th>Credit Officer</th>
        <th>Amount</th>
        <th>Operator</th>
        <th>Fund Type</th>
        <th>Check Number</th>
        <th>Case Number</th>
        <th>Ci Number</th>
    </tr>
    </thead>

    <c:forEach var="transferTransaction" items="${transferTransactions}" >
    <tr>
    <td>${transferTransaction.getId()}</td>
    <td><fmt:formatDate value="${transferTransaction.date}" pattern="MM-dd-yyyy" /></td>
    <td>${transferTransaction.getTransactionType()}</td>
    <td>${transferTransaction.getDescription()}</td>
    <td>${transferTransaction.debitUser.getFullName()}</td>
    <td>${transferTransaction.creditUser.getFullName()}</td>
    <td><fmt:formatNumber value="${transferTransaction.amount}" type="currency" /></td>
    <td>${transferTransaction.operatorUser.getFullName()}</td>
    <td>${transferTransaction.fundType.description}</td>
    <td>${transferTransaction.getCheckNumber()}</td>
    <td>${transferTransaction.getCaseNumber()}</td>
    <td>${transferTransaction.getCiNumber()}</td>
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
            <td>Check Number:</td>
            <td colspan="2">
                <input type="text" class="input-block-level" id="checkNumber" name="checkNumber"/>
            </td>
        </tr>
        
        <tr>
            <td>Case Number:</td>
            <td colspan="2">
                <input type="text" class="input-block-level" id="caseNumber" name="caseNumber"/>
            </td>
        </tr>
        
        <tr>
            <td>Ci Number:</td>
            <td colspan="2">
                <input type="text" class="input-block-level" id="ciNumber" name="ciNumber"/>
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
                <input type="number" step="0.01" class="input-block-level" id="amount" name="amount"/>
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
                <input id="transferSubmit" type="submit" value="submit" style="display:none;">
            </td>
        </tr>
		
    </table>
</form>

<!---------------------------------------- add deposit transaction ------------------------------------------->

<form id="formAddDepositTransaction" name="addDepositTransaction" action="/Transaction/NewDepositTransaction" method="post">
    <h2 id="formHeader">Add Deposit Transaction</h2>
    <table id="tblAddDepositTransaction" class="table">

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
            <td>Check Number:</td>
            <td colspan="2">
                <input type="text" class="input-block-level" id="checkNumber" name="checkNumber"/>
            </td>
        </tr>
        
        <tr>
            <td>Case Number:</td>
            <td colspan="2">
                <input type="text" class="input-block-level" id="caseNumber" name="caseNumber"/>
            </td>
        </tr>
        
        <tr>
            <td>Ci Number:</td>
            <td colspan="2">
                <input type="text" class="input-block-level" id="ciNumber" name="ciNumber"/>
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
                <input type="number" step="0.01" class="input-block-level" id="amount" name="amount"/>
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
                <input id="depositSubmit" type="submit" value="submit" style="display:none;">
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
        
        $('#btnNewDeposit').click(function () {
            depositModal.dialog("open");
        });

        <c:if test="${failedTransferTransaction != null}">
        $("#date").val("<fmt:formatDate value="${failedTransferTransaction.date}" pattern="MM/dd/yyyy" />");
        $("#description").val("${failedTransferTransaction.description}");
        $('#debitOfficer').val("${failedTransferTransaction.debitUser.id}");
        $("#creditOfficer").val("${failedTransferTransaction.creditUser.id}");
        $("#amount").val("${failedTransferTransaction.amount}");
        $("#fundType").val("${failedTransferTransaction.fundType.id}");
        $("#checkNumber").val("${failedTransferTransaction.checkNumber}");
        $("#caseNumber").val("${failedTransferTransaction.caseNumber}");
        $("#ciNumber").val("${failedTransferTransaction.ciNumber}");
        transferModal.dialog("open");
        </c:if>
        
        <c:if test="${failedDepositTransaction != null}">
        $("#date").val("<fmt:formatDate value="${failedDepositTransaction.date}" pattern="MM/dd/yyyy" />");
        $("#description").val("${failedDepositTransaction.description}");
        $("#creditOfficer").val("${failedDepositTransaction.creditUser.id}");
        $("#amount").val("${failedDepositTransaction.amount}");
        $("#fundType").val("${failedDepositTransaction.fundType.id}");
        $("#checkNumber").val("${failedDepositTransaction.checkNumber}");
        $("#caseNumber").val("${failedDepositTransaction.caseNumber}");
        $("#ciNumber").val("${failedDepositTransaction.ciNumber}");
        depositModal.dialog("open");
        </c:if>
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
    
    depositModal = $("#formAddDepositTransaction").dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        width: 'auto',
        buttons: {
            "Submit": addDeposit,
            Cancel: cancel
        }
    });

    function addTransfer() {
        document.getElementById("transferSubmit").click();
    }
    
    function addDeposit() {
        document.getElementById("depositSubmit").click();
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
        $("#checkNumber").val("");
        $("#caseNumber").val("");
        $("#ciNumber").val("");
        transferModal.dialog("close");
        depositModal.dialog("close");
    }
</script>
