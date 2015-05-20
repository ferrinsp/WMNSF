<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>

<html>
<head>
    <%@ include file="resources.jsp" %>
    <style>

        .table {
            width: 100%;
            margin: 0;
            margin-bottom: 30px;
        }

        #reportFilter {
            text-align: center;
            background-color: gray;
            height: 45px;
            padding-top: 5px;
        }

    </style>

    <title>Reports</title>
</head>
<body>
<%@ include file="header.jsp" %>


<form action="Reports" name="filter" method="post" id="reportFilter">
    <select id="username" name="username" style="vertical-align: middle;">${dropdown}</select>
    <label style="padding: 5px; color: white;">From:</label>
    <input value="${from}" class="input-block-level" id="dateFrom" name="from"
           style="vertical-align: middle; height: 20px;">
    <label style="padding: 5px; color: white;">To:</label>
    <input value="${to}" class="input-block-level" id="dateTo" name="to" style="vertical-align: middle; height: 20px;">
    <button class="btn btn-large btn-primary" type="submit" name="action" value="submit">Submit</button>
    <button class="btn btn-large btn-primary" type="submit" name="action" value="export">Export</button>
</form>
<table id="report" class="table table-striped">
    <thead>
    <tr>
        <th>ID</th>
        <th>Date</th>
        <th>Description</th>
        <th>Signing Officer 1</th>
        <th>Signing Officer 2</th>
        <th>Fund Type</th>
        <th>Amount</th>
    </tr>
    </thead>
    <tbody>
    <tr>${tran}</tr>
    </tbody>
</table>

<script>
    $(document).ready(function () {

        var myDate = new Date();
        var oneMonthBack = new Date();
        oneMonthBack.setMonth(oneMonthBack.getMonth() - 1);
        $("#dateTo").val($.datepicker.formatDate('mm/dd/yy', myDate));
        $("#dateFrom").val($.datepicker.formatDate('mm/dd/yy', oneMonthBack));

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
    });
</script>

</body>
</html>