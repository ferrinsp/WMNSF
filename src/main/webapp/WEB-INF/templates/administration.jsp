<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="com.ogdencity.wmnsfconfidentialfunds.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ogdencity.wmnsfconfidentialfunds.model.Permission" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<tags:template pageTitle="Administration">
    <jsp:attribute name="head">
        <link rel="stylesheet" href="/static/css/adminStyleSheet.css">
    </jsp:attribute>
    <jsp:body>

        <body>

        <div id="notificationDiv">
            <p id="notificationP"></p>
        </div>
        <div class="title">
            <h2>Welcome, Administrator</h2>
        </div>

        <div role="tabpanel" class="formTabPane">
            <div class="tabs">
                <ul role="tablist" class="nav nav-tabs formSelect">
                    <li role="presentation" id="usersTab" class="active">
                        <a href="#usersForm" aria-controls="usersForm" role="tab" data-toggle="tab">Manage Users</a>
                    </li>
                    <li role="presentation" id="fundTypesTab">
                        <a href="#fundTypesForm" aria-controls="fundTypesForm" role="tab" data-toggle="tab">Manage Fund
                            Types</a>
                    </li>
                </ul>
            </div>
            <!---------------------------------- Add/Edit User Tab -------------------------------------->
            <div class="formHolder tab-content">
                <div role="tabpanel" class="formContent tab-pane fade in active" id="usersForm">
                    <div class="buttonHolder">
                        <button class="btn btn-large btn-primary" id="btnNewUser">New User</button>
                    </div>

                    <!---------------------------------- Add/Edit User Form -------------------------------------->
                    <form id="formAddEditUser" name="formAddEdit" action="/Administration/NewUser" method="post">
                        <h2 id="formHeader">New/Edit User Form</h2>
                        <table id="addEditUser" class="table">

                            <tr>
                                <td>First Name</td>
                                <td><input type="text" class="input-block-level" id="firstName" name="firstName">
                                    <input type="hidden" id="id" name="id">
                                    <input type="hidden" id="action" name="action" value="newUser"/>
                                </td>
                            </tr>

                            <tr>
                                <td>Last Name</td>
                                <td><input type="text" class="input-block-level" id="lastName" name="lastName"></td>
                            </tr>

                            <tr>
                                <td>Permission Level</td>
                                <td>
                                    <select id="permission" name="permission">
                                        <option value="1">ADMIN</option>
                                        <option value="2">USER</option>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <td>E-Mail</td>
                                <td><input type="text" class="input-block-level" id="email"
                                           name="email" required></td>
                            </tr>

                            <tr>
                                <td>Password</td>
                                <td><input type="password" class="input-block-level"
                                           id="password" name="password"></td>
                            </tr>
                            <tr>
                                <td>
                                    <input id="submit" type="submit" value="submit">
                                </td>
                            </tr>
                        </table>
                    </form>
                    <!---------------------------------- User Information Table -------------------------------------->
                    <div class="table-responsive">
                        <table class="table table-striped" id="usersTable">
                            <!-- Table Header Section -->
                            <thead>
                            <tr>
                                <th></th>
                                <th>ID</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Permission</th>
                                <th>E-Mail</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="user" items="${users}">
                                <!-- Assign ids to the rows. "row" + id. (row1, row2, ...) -->
                                <tr id="row${user.getId()}">
                                    <!--  Edit Button: each edit button has a unique id: userId's value -->
                                    <td>
                                        <button class="editButton" id="${user.getId()}">Edit</button>
                                    </td>
                                    <td>${user.getId()}</td>
                                    <td>${user.getFirstName()}</td>
                                    <td>${user.getLastName()}</td>
                                    <td>
                                        <c:forEach var="permission" items="${user.getPermissions()}">
                                            ${permission.getDescription()},
                                        </c:forEach>
                                    </td>
                                    <td>${user.getEmail()}</td>
                                    <td>
                                        <button class="statusButton" id="${user.getEmail()}"
                                                name=${user.isEnabled() ? "disable" : "enable"}>${user.isEnabled() ? "Disable" : "Enable"}</button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!---------------------------------- Add/Edit Funds Tab -------------------------------------->
                <div role="tabpanel" class="formContent tab-pane fade in" id="fundTypesForm">
                    <div class="buttonHolder">
                        <button class="btn btn-large btn-primary" id="btnNewFundType">New Fund Type</button>
                    </div>


                    <form style="display:none;" id="formAddEditFundType" name="formAddEditFundType" action="Admin"
                          method="post">
                        <h2>New/Edit Fund Type Form</h2>
                        <table id="addEditFundType" class="table">

                            <!-- insert form here -->

                        </table>
                    </form>
                    <div class="table-responsive">
                        <table class="table table-striped" id="fundTypesTable">
                            <!-- Table Header Section -->
                            <thead>
                            <tr>
                                <th></th>
                                <th>ID</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Permission</th>
                                <th>E-Mail</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- Insert jsp function for building table -->
                            </tbody>

                        </table>
                    </div>
                </div>

            </div>


        </div>

        <script type="text/javascript">
            //jQuery

            window.onload = function () {
                var notification = '${notification}';
                if (notification) {
                    $("#notificationP").text(notification);
                    notificationModal.dialog("open");
                }
            }

            notificationModal = $("#notificationDiv").dialog({
                autoOpen: false,
                modal: true,
                resizable: false,
                buttons: {
                    "OK": closeNotification
                }
            });

            function closeNotification() {
                notificationModal.dialog("close");
            }

            userModal = $("#formAddEditUser").dialog({
                autoOpen: false,
                modal: true,
                resizable: false,
                width: 'auto',
                buttons: {
                    "Submit": addEditUser,
                    Cancel: cancel
                }
            });

            function addEditUser() {
                document.getElementById("submit").click();
            }

            function cancel() {
                $("#id").val("");
                $("#firstName").val("");
                $("#lastName").val("");
                $("#permission").val('2');
                $("#email").val("");
                $("#password").val("");
                userModal.dialog("close");
            }

            // ----------------------- Click Event handler for dynamically generated Edit buttons --------------------------------
            $(document).on('click', '.editButton', function (event) {
                var thisID = event.target.id; // get the id of the button, store in local var
                var rowID = 'row' + thisID; // string var holding the id (matches the id of each row in the table)

                // Populate fields with data pulled from the table itself - get the row(rowID), get the cell index, and get the contents.
                // Place contents in the relevant field on the form when the user clicks the Edit button
                $("#id").val(thisID); // hidden field on table
                $("#firstName").val(document.getElementById(rowID).cells[2].innerHTML);
                $("#lastName").val(document.getElementById(rowID).cells[3].innerHTML);
                var permissionText = document.getElementById(rowID).cells[4].innerHTML;
                var permissionValue = '2';
                if (permissionText == "Administrator") {
                    permissionValue = '1';
                }
                else {
                    permissionValue = '2';
                }
                $("#permission").val(permissionValue);
                $("#email").val(document.getElementById(rowID).cells[5].innerHTML);
                $("#email").attr("readonly", "true");
                $("#formHeader").text("Edit User");
                $("#formAddEditUser").attr("action", "/Administration/EditUser");
                $("#action").val("editUser");
                userModal.dialog("open");
            });

            // ----------------------- Click Event handler for dynamically generated Delete buttons --------------------------------
            $(document).on('click', '.statusButton', function (event) {
                var email = event.target.id; // get the id of the button, store in local var
                var status = event.target.name;

                var form = $('<form></form>');

                form.attr("method", "post");
                form.attr("action", "/Administration/StatusUpdate");


                var field = $('<input></input>');

                field.attr("type", "hidden");
                field.attr("name", "email");
                field.attr("value", email);

                form.append(field);

                var field2 = $('<input></input>');

                field2.attr("type", "hidden");
                field2.attr("name", "status");
                field2.attr("value", status);

                form.append(field2);

                var field3 = $('<input></input>');

                field3.attr("type", "hidden");
                field3.attr("name", "action");
                field3.attr("value", "statusChange");

                form.append(field3);

                // The form needs to be a part of the document in
                // order for us to be able to submit it.
                $(document.body).append(form);
                form.submit();
            });

            $(document).ready(function () {

                $('#btnNewUser').click(function () {
                    $("#formHeader").text("New User");
                    $("#formAddEditUser").attr("action", "/Administration/NewUser");
                    $("#action").val("newUser");
                    $("#email").removeAttr("readonly");
                    $("#permission").val('2');
                    userModal.dialog("open");
                });
            });
        </script>
        </body>
    </jsp:body>
</tags:template>