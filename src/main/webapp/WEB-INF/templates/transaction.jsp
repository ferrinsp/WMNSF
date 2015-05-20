<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<%@page import="com.weber.strikeforce.TransactionServlet" %>
<%@page import="com.weber.strikeforce.DAO" %>
<%@page import="com.weber.strikeforce.User" %>

<jsp:useBean id="transaction" class="com.weber.strikeforce.TransferTransaction"/>
<jsp:setProperty property="*" name="transaction"/>

<html>
<head>

    <title>Transaction</title>
    <%@ include file="resources.jsp" %>
    <style type="text/css">
        .transactionDate {
            width: 175px;
            height: 30px;
        }

        .formTabPane {
            margin-left: auto;
            margin-right: auto;
            width: 500px;
            max-width: 90%;
            margin-bottom: 30px;
        }

        .formSelect {
            width: 100%;
        }

        .formHolder {
            width: 100%;
            padding-left: 10px;
            padding-right: 10px;
            border: 1px solid #ddd;
            margin-bottom: 10px;
            margin-top: -1px;
            padding-top: 15px;
        }

        .table {
            width: 100%;
            margin-top: 5px;
        }

        .table td {
            border: none !important;
        }

        .nav.formSelect > li > a:hover, .nav.formSelect > li > a:focus {
            background-color: lightgrey !important;
            color: white !important;
        }

        .nav.formSelect > li {
            text-align: center;
            width: 25%;
        }

        .submitHolder {
            width: 500px;
            max-width: 90%;
            margin-left: auto;
            margin-right: auto;
            text-align: center;
        }

        #submit {
            margin-left: auto;
            margin-right: auto;
            width: 140px;
            max-width: 90%;
            margin-bottom: 30px;
        }

        input, select, textarea {
            width: 100%;
            margin-right: 10px;
        }

        textarea {
            resize: none;
        }

        input[type=radio] {
            width: auto;
            margin-right: 20px;
        }

    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div role="tabpanel" class="formTabPane">
    <ul role="tablist" class="nav nav-tabs formSelect">
        <li role="presentation" id="expendTab" class="active"><a href="#expendForm" aria-controls="expendForm"
                                                                 role="tab" data-toggle="tab">Expenditure</a></li>
        <%
            String additionalTransactions = "";
            try {
                // Get the users table from the servlet (DAO.getAllUsers() call)
                User user = (User) request.getSession().getAttribute("user");
                if (user.getPermissionId() == 1) {
                    additionalTransactions = "<li role=\"presentation\" id=\"insertTab\"><a href=\"#insertForm\" aria-controls=\"insertForm\" role=\"tab\" data-toggle=\"tab\">Insert</a></li>" +
                            "<li role=\"presentation\" id=\"transferTab\"><a href=\"#transferForm\" aria-controls=\"transferForm\" role=\"tab\" data-toggle=\"tab\">Transfer</a></li>" +
                            "<li role=\"presentation\" id=\"endOfMonthTab\"><a href=\"#endOfMonthForm\" aria-controls=\"endOfMonthForm\" role=\"tab\" data-toggle=\"tab\">End Of Month</a></li>";
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        %>
        <%=additionalTransactions %>
    </ul>
    <div class="formHolder tab-content">
        <div role="tabpanel" class="formContent tab-pane fade in active" id="expendForm">
            <form method="post" name="expend" class="activeForm" id="expend" action="expend">
                <table class="table">
                    <tr>
                        <td>Date</td>
                        <td>
                            <input type="text" class="input-block-level"
                                   name="date" id="date" data-validation="date"
                                   data-validation-format="mm/dd/yyyy"
                                   data-validation-error-msg="Please enter a valid date. Format: dd/mm/yyyy">
                        </td>
                    </tr>
                    <tr>
                        <td>Description</td>
                        <td><textarea rows="4" class="input-block-level"
                                      name="description" id="description" data-validation="required"
                                      data-validation-error-msg="Description cannot be empty."></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>Type of Drug</td>
                        <td>
                            <input type="text" class="input-block-level" name="drugType" id="drugType">
                        </td>
                    </tr>
                    <tr>
                        <td>Quantity</td>
                        <td>
                            <input type="number" class="input-block-level" name="quantity" id="quantity"
                                   data-validation="number" data-validation-error-msg="Quantity must be a valid number."
                                   data-validation-optional="true">
                        </td>
                    </tr>
                    <tr>
                        <td>CI#</td>
                        <td>
                            <input type="text" class="input-block-level" name="CINum" id="CINum">
                        </td>
                    </tr>
                    <tr>
                        <td>Case #</td>
                        <td>
                            <input type="text" class="input-block-level" name="caseNum" id="caseNum">
                        </td>
                    </tr>
                    <tr>
                        <td>Purchase Type:</td>
                        <td>
                            <input type="radio" class="input-block-level" name="selectOne" id="selectOne" checked="true"
                                   value="P/S">P/S<br/>
                            <input type="radio" class="input-block-level" name="selectOne" id="selectOne" value="P/E">P/E<br/>
                            <input type="radio" class="input-block-level" name="selectOne" id="selectOne" value="P/I">P/I
                        </td>
                    </tr>

                    <tr>
                        <td>Amount</td>
                        <td><input type="number" step="0.01" class="input-block-level" id="amount"
                                   name="amount" data-validation="number"
                                   data-validation-allowing="float"
                                   data-validation-error-msg="Amount must be a valid positive number.">
                        </td>
                    </tr>
                    <tr>
                        <td>Signing Officer</td>
                        <td><select class="input-block-level" id="signingOfficer"
                                    name="signingOfficer">${ signature1 }</select></td>
                    </tr>

                    <tr>
                        <td>Signing Officer Password</td>
                        <td>
                            <input class="input-block-level" id="signingOfficerPassword" type="password"
                                   name="signingOfficerPassword" data-validation="required"
                                   data-validation-error-msg="Signing Officer Password cannot be empty">
                        </td>
                    </tr>

                </table>
            </form>
        </div>
        <div role="tabpanel" class="formContent tab-pane fade in" id="insertForm">
            <form method="post" name="insert" id="insert" action="insert">
                <table class="table">
                    <tr>
                        <td>Date</td>
                        <td>
                            <input type="text" class="input-block-level"
                                   name="date" id="date" data-validation="date"
                                   data-validation-format="mm/dd/yyyy"
                                   data-validation-error-msg="Please enter a valid date. Format: dd/mm/yyyy">
                        </td>
                    </tr>
                    <tr>
                        <td>Type</td>
                        <td><select class="input-block-level" id="type" name="type">${type}</select></td>
                    </tr>

                    <tr>
                        <td>Description</td>
                        <td><textarea rows="4" class="input-block-level"
                                      name="description" id="description" data-validation="required"
                                      data-validation-error-msg="Description cannot be empty."></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>Check Number</td>
                        <td>
                            <input class="input-block-level" id="checkNumber" name="checkNumber">
                        </td>
                    </tr>
                    <tr>
                        <td>Amount</td>
                        <td><input type="number" step="0.01" class="input-block-level" id="amount"
                                   name="amount" data-validation="number"
                                   data-validation-allowing="float"
                                   data-validation-error-msg="Amount must be a valid positive number.">
                        </td>
                    </tr>
                    <tr>
                        <td>Credit Officer</td>
                        <td>
                            <select class="input-block-level" id="signature1" name="signature1">
                                ${signature1}
                                <!-- attribute from servlet filled with users and their ids.-->
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" class="input-block-level"
                                   id="password1" name="password1" data-validation="required"
                                   data-validation-error-msg="Officer 1 password cannot be empty.">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div role="tabpanel" class="formContent tab-pane fade in" id="transferForm">
            <form method="post" name="transfer" id="transfer" action="transfer">
                <table class="table">
                    <tr>
                        <td>Date</td>
                        <td>
                            <input type="text" class="input-block-level"
                                   name="date" id="date" data-validation="date"
                                   data-validation-format="mm/dd/yyyy"
                                   data-validation-error-msg="Please enter a valid date. Format: dd/mm/yyyy">
                        </td>
                    </tr>
                    <tr>
                        <td>Description</td>
                        <td><textarea rows="4" class="input-block-level"
                                      name="description" id="description" data-validation="required"
                                      data-validation-error-msg="Description cannot be empty."></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>Type</td>
                        <td>
                            <select class="input-block-level" id="type" name="type">
                                ${type}
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Amount</td>
                        <td><input type="number" step="0.01" class="input-block-level" id="amount"
                                   name="amount" data-validation="number"
                                   data-validation-allowing="float"
                                   data-validation-error-msg="Amount must be a valid positive number.">
                        </td>
                    </tr>
                    <tr>
                        <td>Debit Officer</td>
                        <td>
                            <select class="input-block-level" id="signature1" name="signature1">
                                ${signature1}
                                <!-- attribute from servlet filled with users and their ids.-->
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" class="input-block-level"
                                   id="password1" name="password1" data-validation="required"
                                   data-validation-error-msg="Officer 1 password cannot be empty.">
                        </td>
                    </tr>
                    <tr>
                        <td>Credit Officer</td>
                        <td><select class="input-block-level" id="signature2" name="signature2">
                            ${signature2} <!-- attribute from servlet filled with users and their ids.-->
                        </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" class="input-block-level"
                                   id="password2" name="password2" data-validation="required"
                                   data-validation-error-msg="Officer 2 password cannot be empty.">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div role="tabpanel" class="formContent tab-pane fade in" id="endOfMonthForm">
            <form method="post" name="endOfMonth" id="endOfMonth" action="endOfMonth">
                <table class="table">
                    <tr>
                        <td>Date</td>
                        <td>
                            <input type="text" class="input-block-level"
                                   name="date" id="date" data-validation="date"
                                   data-validation-format="mm/dd/yyyy"
                                   data-validation-error-msg="Please enter a valid date. Format: dd/mm/yyyy">
                        </td>
                    </tr>
                    <tr>
                        <td>Description</td>
                        <td><textarea rows="4" class="input-block-level"
                                      name="description" id="description" data-validation="required"
                                      data-validation-error-msg="Description cannot be empty."></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>Type</td>
                        <td>
                            <select class="input-block-level" id="type" name="type">
                                ${type}
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Amount</td>
                        <td><input type="number" step="0.01" class="input-block-level" id="amount"
                                   name="amount" data-validation="number"
                                   data-validation-allowing="float"
                                   data-validation-error-msg="Amount must be a valid positive number.">
                        </td>
                    </tr>
                    <tr>
                        <td>Debit Officer</td>
                        <td>
                            <select class="input-block-level" id="signature1" name="signature1">
                                ${signature1}
                                <!-- attribute from servlet filled with users and their ids.-->
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" class="input-block-level"
                                   id="password1" name="password1" data-validation="required"
                                   data-validation-error-msg="Officer 1 password cannot be empty.">
                        </td>
                    </tr>
                    <tr>
                        <td>Credit Officer</td>
                        <td><select class="input-block-level" id="signature2" name="signature2">
                            ${signature2} <!-- attribute from servlet filled with users and their ids.-->
                        </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" class="input-block-level"
                                   id="password2" name="password2" data-validation="required"
                                   data-validation-error-msg="Officer 2 password cannot be empty.">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <div class="submitHolder">
        <button class="btn btn-primary" id="submit">Submit</button>
    </div>
</div>

<script src="js/form-validator/jquery.form-validator.min.js"></script>
<script>
    $(document).ready(function () {
        var myDate = new Date();
        $(".activeForm #date").val($.datepicker.formatDate('mm/dd/yy', myDate));
        $('.activeForm #date').datepicker();

        $("#expendTab").click(function () {
            $('form.activeForm').get(0).reset();
            $('.formContent > form').removeClass('activeForm');
            $('#expend').addClass('activeForm');
            var myDate = new Date();
            $(".activeForm #date").val($.datepicker.formatDate('mm/dd/yy', myDate));
            $('.activeForm #date').datepicker();
            $.validate({
                form: '.activeForm',
                validateOnBlur: false,
                errorMessagePosition: 'top',
                onSuccess: function () {
                    password2Error();
                    return false;
                }
            });
        });

        $("#insertTab").click(function () {
            $('form.activeForm').get(0).reset();
            $('.formContent > form').removeClass('activeForm');
            $('#insert').addClass('activeForm');
            var myDate = new Date();
            $(".activeForm #date").val($.datepicker.formatDate('mm/dd/yy', myDate));
            $('.activeForm #date').datepicker();
            $.validate({
                form: '.activeForm',
                validateOnBlur: false,
                errorMessagePosition: 'top',
                onSuccess: function () {
                    password2Error();
                    return false;
                }
            });
        });

        $("#transferTab").click(function () {
            $('form.activeForm').get(0).reset();
            $('.formContent > form').removeClass('activeForm');
            $('#transfer').addClass('activeForm');
            var myDate = new Date();
            $(".activeForm #date").val($.datepicker.formatDate('mm/dd/yy', myDate));
            $('.activeForm #date').datepicker();
            $.validate({
                form: '.activeForm',
                validateOnBlur: false,
                errorMessagePosition: 'top',
                onSuccess: function () {
                    password2Error();
                    return false;
                }
            });
        });

        $("#endOfMonthTab").click(function () {
            $('form.activeForm').get(0).reset();
            $('.formContent > form').removeClass('activeForm');
            $('#endOfMonth').addClass('activeForm');
            var myDate = new Date();
            $(".activeForm #date").val($.datepicker.formatDate('mm/dd/yy', myDate));
            $('.activeForm #date').datepicker();
            $.validate({
                form: '.activeForm',
                validateOnBlur: false,
                errorMessagePosition: 'top',
                onSuccess: function () {
                    password2Error();
                    return false;
                }
            });
        });

        $("#submit").on('click', function (event) {
            event.preventDefault();
            $('.activeForm').submit();
        });

    });

    $.validate({
        form: '.activeForm',
        validateOnBlur: false,
        errorMessagePosition: 'top',
        onSuccess: function () {

            return false;
        }
    });

    function checkPasswords() {

    }

    function submitTransaction() {
        $('form.activeForm').get(0).submit();

    }

    var errorPass1 = false;
    function password1Error() {
        var errorDiv = "<div id=\"formErrorDiv\" class=\"form-error alert alert-danger\">" +
                "<strong>Form submission failed!</strong>" +
                "<ul>" +
                "<li>Officer 1 password incorrect</li>" +
                "</ul>" +
                "</div>";
        $("#transaction").prepend(errorDiv);
        $("#password1").addClass("error");
        $("#password1").css("border-color", "red");
        errorPass1 = true;
    }

    function password2Error() {
        if (errorPass1 == true) {
            $('#formErrorDiv ul li:last-child').append("<li>Officer 2 password incorrect</li>");
            $("#password2").css("border-color", "red");
        }
        else {
            var errorDiv = "<div id=\"formErrorDiv\" class=\"form-error alert alert-danger\">" +
                    "<strong>Form submission failed!</strong>" +
                    "<ul>" +
                    "<li>Officer 2 password incorrect</li>" +
                    "</ul>" +
                    "</div>";
            $("#transaction").prepend(errorDiv);
            $("#password2").addClass("error");
            $("#password2").css("border-color", "red");
        }
    }
</script>
</body>
</html>