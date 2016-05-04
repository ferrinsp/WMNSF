<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% if (!request.isUserInRole("USER")) {%>
		<c:redirect url="/Reports"/>
<%}%>

<head>
    <link rel="stylesheet" href="/static/css/transferTransaction.css">
    <link rel="stylesheet" href="/static/css/dataTables.css">
    <script src="/static/js/dataTables.js"></script>
</head>

<div class="buttonHolder">
    <button style="background-color:darkblue;" class="btn btn-large btn-primary" id="btnNewTransfer">New Transfer</button>
    <button style="background-color:darkblue;" class="btn btn-large btn-primary" id="btnNewDeposit">New Deposit</button>
    <button style="background-color:darkblue;" class="btn btn-large btn-primary" id="btnNewExpenditure">New Expenditure</button>
</div>
<br/>

<table class="table table-striped" ID="tblTransferTransactions">
    <thead>
    <tr>
        <th>Date</th>
        <th>Type</th>
        <th>Amount</th>
        <th>Description</th>
        <th>Funds From</th>
        <th>Funds To</th>
        <th>Fund Type</th>
        <th>Check Number</th>
        <th>Case Number</th>
        <th>Ci Number</th>
    </tr>
    </thead>

    <c:forEach var="transferTransaction" items="${transferTransactions}" >
	    <tr>
		    <td><fmt:formatDate value="${transferTransaction.date}" pattern="MM-dd-yyyy" /></td>
		    <td>${transferTransaction.getTransactionType()}</td>
		    <td><fmt:formatNumber value="${transferTransaction.amount}" type="currency" /></td>
		    <td>${transferTransaction.getDescription()}</td>
		    <td>${transferTransaction.debitUser.getFullName()}</td>
		    <td>${transferTransaction.creditUser.getFullName()}</td>
		    <td>${transferTransaction.fundType.description}</td>
		    <td>${transferTransaction.getCheckNumber()}</td>
		    <td>${transferTransaction.getCaseNumber()}</td>
		    <td>${transferTransaction.getCiNumber()}</td>
	    </tr>
    </c:forEach>
</table>

<!---------------------------------------- add transfer transaction ------------------------------------------->

<form id="formAddTransferTransaction" name="addTransferTransaction" action="/Transaction/NewTransferTransaction" method="post">
    <h2 id="formHeader">Add Transfer</h2>
    <table id="tblAddTransferTransaction" class="table">

        <tr>
            <td>Date:</td>
            <td colspan="2">
                <input type="text" class="input-block-level" id="date" name="date" placeholder="MM/DD/YYYY" required title="Transaction Date"/>
            </td>
        </tr>
        
        <tr>
            <td>Money from:</td>
            <td>
                <select id="moneyFrom" name="moneyFrom" autofocus>
                    <c:forEach var="user" items="${allEnabledUsers}" >
                    <option value="${user.id}">${user.getEmail()}</option>
                    </c:forEach>
                </select>
            </td>
            <td>
                <input type="password" class="input-block-level" id="debitPassword" name="debitPassword" placeholder="Password"/>
            </td>
        </tr>

        <tr>
            <td>Money To:</td>
            <td>
                <select id="moneyTo" name="moneyTo">
                    <c:forEach var="user" items="${allEnabledUsers}" >
                        <option value="${user.id}">${user.getEmail()}</option>
                    </c:forEach>
                </select>
            </td>
            <td>
                <input type="password" class="input-block-level" id="creditPassword" name="creditPassword" required placeholder="Password"/>
            </td>
        </tr>

        <tr>
            <td>Fund Amount & Type:</td>
            <td>
                <input type="number" class="input-block-level" id="amount" name="amount" required placeholder="Fund Amount"/>
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
    <h2 id="formHeader">Add Deposit</h2>
    <table id="tblAddDepositTransaction" class="table">

        <tr>
            <td>Date:</td>
            <td colspan="2">
                <input type="text" class="input-block-level" id="date1" name="date" required title="Transaction Date" placeholder="MM/DD/YYYY"/>
            </td>
        </tr>
        
        <tr>
            <td>Check Number:</td>
            <td colspan="2">
                <input type="number" class="input-block-level" id="checkNumber" name="checkNumber" autofocus required placeholder="Check Number"/>
            </td>
        </tr>
        
        <tr>
            <td>Case Number:</td>
            <td colspan="2">
                <input type="test" class="input-block-level" id="caseNumber" pattern="[0-9]{2}n-[0-9]{5}" name="caseNumber" required placeholder="Case Number"/>
            </td>
        </tr>
        
        <tr>
            <td>Money to:</td>
            <td>
                <select id="moneyTo" name="moneyTo">
                    <c:forEach var="user" items="${allEnabledUsers}" >
                        <option value="${user.id}">${user.getEmail()}</option>
                    </c:forEach>
                </select>
            </td>
            <td>
                <input type="password" class="input-block-level" id="creditPassword" required name="creditPassword" placeholder="Password"/>
            </td>
        </tr>

        <tr>
            <td>Fund Amount & Type:</td>
            <td>
                <input type="number" class="input-block-level" id="amount" required name="amount" placeholder="Fund Amount"/>
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

<!---------------------------------------- add expenditure transaction------------------------------------------->

<form id="formAddExpenditure" name="addExpenditure" action="/Transaction/NewExpenditure" method="post">
    <h2 id="formHeader">Add Expenditure</h2>
    <table id="tblAddExpenditure" class="table">
        <tr>
            <td>Date:</td>
            <td colspan="2">
                <input type="text" class="input-block-level" id="date2" name="date" required title="Transaction Date" placeholder="MM/DD/YYYY"/>
            </td>
        </tr>

        <tr>
            <td>Description:</td>
            <td>
            	<select id="description" name="description" autofocus required placeholder="Payment for...">
					<option value="PI">PI-Payment for Information</option>
					<option value = "PE">PE-Payment for Evidence</option>
                </select>
            </td>
        </tr>
        
        <tr>
            <td>Case Number:</td>
            <td colspan="2">
                <input type="text" class="input-block-level" id="caseNumber" pattern="[0-9]{2}n-[0-9]{5}" name="caseNumber" required placeholder="Case Number"/>
            </td>
        </tr>
        
        <tr>
            <td>CI Number:</td>
            <td colspan="2">
                <input type="number" class="input-block-level" id="ciNumber" name="ciNumber" required placeholder="Ci Number"/>
            </td>
        </tr>

        <tr>
            <td>Money from:</td>
            <td>
                <select id="moneyFrom" name="moneyFrom">
                    <c:forEach var="user" items="${allEnabledUsers}" >
                        <option value="${user.id}">${user.getEmail()}</option>
                    </c:forEach>
                </select>
            </td>
            <td>
                <input type="password" class="input-block-level" id="debitPassword" name="debitPassword" required placeholder="Password"/>
            </td>
        </tr>

        <tr>
            <td>Fund Amount & Type:</td>
            <td>
                <input type="number" class="input-block-level" id="amount" name="amount" required placeholder="Fund Amount"/>
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
                <input id="expenditureSubmit" type="submit" value="submit" style="display:none;">
            </td>
        </tr>
    </table>
</form>

<script>
    $(document).ready(function () {
 
        $('#tblTransferTransactions').DataTable();
        
        $("#moneyTo").val('${allEnabledUsers.get(1).id}');
        
        $('#btnNewTransfer').click(function () {
            transferModal.dialog("open");
        });
        $('#btnNewDeposit').click(function () {
            depositModal.dialog("open");
        });
        $('#btnNewExpenditure').click(function () {
            expenditureModal.dialog("open");
        });

        <c:if test="${failedTransferTransaction != null}">
        $("#date1").val("<fmt:formatDate value="${failedTransferTransaction.date}" pattern="MM/dd/yyyy" />");
        $('#moneyFrom').val("${failedTransferTransaction.debitUser.id}");
        $("#moneyTo").val("${failedTransferTransaction.creditUser.id}");
        $("#amount").val("${failedTransferTransaction.amount}");
        $("#fundType").val("${failedTransferTransaction.fundType.id}");
        transferModal.dialog("open");
        </c:if>
        
        <c:if test="${failedDepositTransaction != null}">
        $("#date2").val("<fmt:formatDate value="${failedDepositTransaction.date}" pattern="MM/dd/yyyy" />");
        $("#moneyTo").val("${failedDepositTransaction.creditUser.id}");
        $("#amount").val("${failedDepositTransaction.amount}");
        $("#fundType").val("${failedDepositTransaction.fundType.id}");
        $("#checkNumber").val("${failedDepositTransaction.checkNumber}");
        $("#caseNumber").val("${failedDepositTransaction.caseNumber}");
        depositModal.dialog("open");
        </c:if>
        
        <c:if test="${failedExpediture != null}">
        $("#date").val("<fmt:formatDate value="${failedExpediture.date}" pattern="MM/dd/yyyy" />");
        $("#description").val("${failedExpediture.description}");
        $("#moneyTo").val("${failedExpediture.creditUser.id}");
        $("#amount").val("${failedExpediture.amount}");
        $("#fundType").val("${failedExpediture.fundType.id}");
        $("#checkNumber").val("${failedExpediture.checkNumber}");
        $("#caseNumber").val("${failedExpediture.caseNumber}");
        $("#ciNumber").val("${failedExpediture.ciNumber}");
        expenditureModal.dialog("open");
        </c:if>
    });

    (function() {
    	  $("#date").datepicker({ minDate: -60, maxDate: +0, dateFormat: "mm/dd/yy"
    	    }).datepicker("setDate", "0");
          
    	  $("#date1").datepicker({ minDate: -60, maxDate: +0, dateFormat: "mm/dd/yy"
    	    }).datepicker("setDate", "0");
          	
    	  $("#date2").datepicker({ minDate: -60, maxDate: +0, dateFormat: "mm/dd/yy"
    	    }).datepicker("setDate", "0");
    	    })();
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
  
    expenditureModal = $("#formAddExpenditure").dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        width: 'auto',
        buttons: {
            "Submit": addExpenditure,
            Cancel: cancel
        }
    });

    function addTransfer() {
        document.getElementById("transferSubmit").click();
    }
    
    function addDeposit() {
        document.getElementById("depositSubmit").click();
    }
    
    function addExpenditure() {
        document.getElementById("expenditureSubmit").click();
    }

    function cancel() {
        $("#description").val("");
        $("#moneyFrom").val('${allEnabledUsers.get(0).id}');
        $("#debitPassword").val("");
        $("#moneyTo").val('${allEnabledUsers.get(1).id}');
        $("#creditPassword").val("");
        $("#amount").val("");
        $("#fundType").val('${allActiveFundTypes.get(0).id}');
        $("#checkNumber").val("");
        $("#caseNumber").val("");
        $("#ciNumber").val("");
        transferModal.dialog("close");
        depositModal.dialog("close");
        expenditureModal.dialog("close");
    }
</script>
