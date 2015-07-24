<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<tags:template pageTitle="Reports">
    <jsp:attribute name="head">
        <style>
            .formBar {
                text-align: center;
                background-color: gray;
                height: 45px;
                padding-top: 5px;
            }

        </style>

        <link rel="stylesheet" href="/static/css/nav-tabs.css">
        <link rel="stylesheet" href="/static/css/dataTables.css">
        <script src="/static/js/dataTables.js"></script>
        <link rel="stylesheet" href="/static/multi-select/css/multi-select.css">
        <script src="/static/multi-select/js/jquery.multi-select.js"></script>
    </jsp:attribute>
    <jsp:body>
        <div class="formBar">
            <form action="/Reports/Search" name="filter" method="post" id="reportFilter">

                <label class="checkbox-inline" style="color:white"><input type="checkbox" id="cbCredit" value="credit">Credit</label>
                <input type="hidden" id="credit" name="cbCredit" value="false" />
                <label class="checkbox-inline" style="color:white"><input type="checkbox" id="cbDebit" value="debit">Debit</label>
                <input type="hidden" id="debit" name="cbDebit" value="false" />
                <label class="checkbox-inline" style="color:white"><input type="checkbox" id="cbOperator"  value="operator">Operator</label>
                <input type="hidden" id="operator" name="cbOperator" value="false" />

                <select id="users" name="users">
                    <c:forEach var="user" items="${users}" >
                        <option value="${user.getId()}">${user.getFullName()}</option>
                    </c:forEach>
                </select>

                <select id="transactionType" name="transactionType">
                    <c:forEach var="type" items="${transactionTypes}" >
                        <option value="${type.toString()}">${type.toString()}</option>
                    </c:forEach>
                </select>

                <label style="padding: 5px; color: white;">From:</label>

                <input class="input-block-level" id="dateFrom" name="startDate" style="vertical-align: middle; height: 20px;">

                <label style="padding: 5px; color: white;">To:</label>

                <input class="input-block-level" id="dateTo" name="endDate" style="vertical-align: middle; height: 20px;">

                <button class="btn btn-large btn-primary" type="button" name="action" value="submit" onclick="searchSubmit()">Search</button>

                <button class="btn btn-large btn-primary" type="button" name="action" value="export">Export</button>
            </form>
        </div>

        <br/>
        <br/>

        <table id="tblTransferTransactions">
            <thead>
            <tr>
                <th>ID</th>
                <th>Date</th>
                <th>Description</th>
                <th>Debit Officer</th>
                <th>Credit Officer</th>
                <th>Amount</th>
                <th>Fund Type</th>
                <th>Operator</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="transaction" items="${transactions}" >
                <tr>
                    <td>${transaction.getId()}</td>
                    <td><fmt:formatDate value="${transaction.date}" pattern="MM-dd-yyyy" /></td>
                    <td>${transaction.getDescription()}</td>
                    <td>${transaction.debitUser.getFullName()}</td>
                    <td>${transaction.creditUser.getFullName()}</td>
                    <td><fmt:formatNumber value="${transaction.amount}" type="currency" /></td>
                    <td>${transaction.fundType.description}</td>
                    <td>${transaction.operatorUser.getFullName()}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <script>
            function searchSubmit(){
                if($("#cbCredit").is(':checked'))
                    $("#credit").val("true");
                if($("#cbDebit").is(':checked'))
                    $("#debit").val("true");
                if($("#cbOperator").is(':checked'))
                    $("#operator").val("true");
                $("#reportFilter").submit();
            }

            $(document).ready(function () {
                $('#tblTransferTransactions').DataTable();

                var date = new Date();
                var firstDay = new Date(date.getFullYear(), date.getMonth() -1 , 1);
                var lastDay = new Date(date.getFullYear(), date.getMonth(), 0);

                $("#dateTo").val($.datepicker.formatDate('mm/dd/yy', lastDay));
                $("#dateFrom").val($.datepicker.formatDate('mm/dd/yy', firstDay));

                $("#dateFrom").datepicker({
                    maxDate: +0,
                    onClose: function (selectedDate) {
                        $("#dateTo").datepicker("option", "minDate", selectedDate);
                    }
                });

                $("#dateTo").datepicker({
                    maxDate: +0,
                    onClose: function (selectedDate) {
                        $("#dateFrom").datePicker("option", "maxDate", selectedDate);
                    }
                });

                <c:if test="${search != null}">
                $("#dateTo").val("<fmt:formatDate value="${search.endDate}" pattern="MM/dd/yyyy" />");
                $("#dateFrom").val("<fmt:formatDate value="${search.startDate}" pattern="MM/dd/yyyy" />");
                $("#users").val("${search.userId}");
                $("#transactionType").val("${search.getTransactionType().toString()}");
                <c:if test="${search.credit}">
                $('#cbCredit').prop('checked', true);
                </c:if>
                <c:if test="${search.debit}">
                $('#cbDebit').prop('checked', true);
                </c:if>
                <c:if test="${search.operator}">
                $('#cbOperator').prop('checked', true);
                </c:if>
                </c:if>

            });



        </script>
    </jsp:body>
</tags:template>