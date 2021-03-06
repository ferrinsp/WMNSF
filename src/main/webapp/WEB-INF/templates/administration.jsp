<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<tags:template pageTitle="Administration">
    <jsp:attribute name="head">
        <link rel="stylesheet" href="/static/css/administration.css">
        <link rel="stylesheet" href="/static/css/nav-tabs.css">
        <link rel="stylesheet" href="/static/css/dataTables.css">
        <script src="/static/js/dataTables.js"></script>
        <link rel="stylesheet" href="/static/multi-select/css/multi-select.css">
        <script src="/static/multi-select/js/jquery.multi-select.js"></script>
    </jsp:attribute>
    <jsp:body>

        <body>

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
                        <a href="#fundTypesForm" aria-controls="fundTypesForm" role="tab" data-toggle="tab">Manage Fund Types</a>
                    </li>
                </ul>
            </div>
            <!---------------------------------- Add/Edit User Tab -------------------------------------->
            <div class="formHolder tab-content">
                <div role="tabpanel" class="formContent tab-pane fade in active" id="usersForm">
                    <div class="buttonHolder">
                        <button class="btn btn-large btn-primary" id="btnNewUser" onclick="newUser()" >New User</button>
                    </div>

                    <!---------------------------------- Add/Edit User Form -------------------------------------->
                    <form id="formAddEditUser" name="formAddEdit" action="/Administration/NewUser" method="post">
                        <h2 id="formHeader">New/Edit User Form</h2>
                        <table id="addEditUser" class="table">

                            <tr>
                                <td>First Name</td>
                                <td><input type="text" class="input-block-level" id="firstName" name="firstName">
                                    <input type="hidden" id="id" name="id">
                                </td>
                            </tr>

                            <tr>
                                <td>Last Name</td>
                                <td><input type="text" class="input-block-level" id="lastName" name="lastName"></td>
                            </tr>

                            <tr>
                                <td colspan="2">
                                    <select id="permission" name="permission" multiple="multiple">
                                        <c:forEach var="permission" items="${permissions}">
                                            <option value="${permission.getId()}">${permission.getDescription().trim()}</option>
                                        </c:forEach>
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
                        </table>
                    </form>
                    <!---------------------------------- User Information Table -------------------------------------->
                    <div class="table-responsive">
                        <table class="table table-striped" id="usersTable">
                            <!-- Table Header Section -->
                            <thead>
                            <tr>
                                <th></th>
                                <th></th>
                                <th>ID</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Permission</th>
                                <th>E-Mail</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="user" items="${users}">
                                <!-- Assign ids to the rows. "row" + id. (row1, row2, ...) -->
                                <tr id="row${user.getId()}">
                                    <!--  Edit Button: each edit button has a unique id: userId's value -->
                                    <td>
                                        <button class="editButton" id="edit${user.getId()}" onclick="editUser(${user.getId()})">Edit</button>
                                    </td>
                                    <td>
                                        <button class="statusButton" id="status${user.getId()}" onclick="statusUser(${user.getId()})">${user.isEnabled() ? "Disable" : "Enable"}</button>
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
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!---------------------------------- Add/Edit Funds Tab --------------------------------------><!---------------------------------- Needs Work -------------------------------------->
                <div role="tabpanel" class="formContent tab-pane fade in" id="fundTypesForm">
                    <div class="buttonHolder">
                        <button class="btn btn-large btn-primary" id="btnNewFundType" onclick="newFundType()">New Fund Type</button>
                    </div>

					<!-------------------------------Add/Edit Funds Form ----------------------------------------->
                    <form id="formAddEditFundType" name="formAddEditFund" action="/Administration/NewFundType" method="post">
                        <h2 id="formHeader2">New/Edit Fund Type</h2>
                        <table id="addEditFundType" class="table">

                            <tr>
                            	<td>Description:</td>
            					<td colspan="2">
                					<input type="text" class="input-block-level" id="description" name="description"></input>
                					<input type="hidden" id="fundId" name="id">
            					</td>
            				</tr>
            				<tr>
            					<td>Effective Start Date</td>
            					<td colspan="2">
                					<input type="text" class="input-block-level" id="effectiveStart" name="effectiveStart"/>
            					</td>
            				</tr>
            				<tr>
            					<td>Effective End Date</td>
            					<td colspan="2">
                					<input type="text" class="input-block-level" id="effectiveEnd" name="effectiveEnd"/>
            					</td>
            				</tr>
                        </table>
                    </form>
                    
                    <!---------------------------------------------- Fund Type Table ------------------------------------------------------------>
                    <div class="table-responsive">
                        <table class="table table-striped" id="fundTypesTable">
                            <!-- Table Header Section -->
                            <thead>
                            <tr>
                                <th>Actions</th>
                               <!--   <th>ID</th> -->
                                <th>Description</th>
                                <th>Effective Date</th>
                                <th>End Date</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- Insert jsp function for building table -->
                            <c:forEach var="fundType" items="${fundTypes}">
	                            <tr id="row${fundType.getId()}">
	                            	    <td>
	                                        <button class="editButton" id="edit${fundType.getId()}" onclick="editFundType(${fundType.getId()})">Edit</button>
	                                    </td>
	                                  <!--   <td>${fundType.getId()}</td>--> 
	                                    <td>${fundType.getDescription()}</td>
	                                    <td><fmt:formatDate value="${fundType.getEffectiveStart()}" pattern="MM-dd-yyyy"/></td>
	                                    <td><fmt:formatDate value="${fundType.getEffectiveEnd()}" pattern="MM-dd-yyyy"/></td>
	                             </tr>
                            </c:forEach>
                            </tbody>

                        </table>
                    </div>
                </div>

            </div>


        </div>

        <script type="text/javascript">
            //jQuery

            function statusUser(id){
                $.ajax({
                    type: "POST",
                    url: "/Administration/StatusUser",
                    data: ({
                        id: id
                    }),
                    success: function (user) {
                        var buttonString = "Enable";
                        var notification = "Disabled";

                        if(user.enabled){
                            notification = "Enabled";
                            buttonString = "Disable";
                        }

                        $("#status"+id.toString()).text(buttonString);
                        toastr["success"](user.firstName + " " + user.lastName + " successfully " + notification);
                    }
                });
            }

            function editUser(id){
                $.ajax({
                    type: "POST",
                    url: "/Administration/GetUser",
                    data: ({
                        id: id
                    }),
                    success: function (user) {
                        $("#id").val(user.id);
                        $("#firstName").val(user.firstName);
                        $("#lastName").val(user.lastName);
                        $.each( user.permissions, function(index, permission) {
                            $("#permission").multiSelect('select', permission.id.toString());
                        });
                        $("#email").val(user.email);
                        $("#password").val("");
                        $("#email").attr("readonly", "true");
                        $("#formAddEditUser").attr("action", "/Administration/EditUser");
                        userModal.dialog("open");
                    }
                });
            }

            function editFundType(id){
                $.ajax({
                    type: "POST",
                    url: "/Administration/GetFundType",
                    data: ({
                        id: id
                    }),
                    success: function (fundType) {
                        $("#fundId").val(fundType.id);
                        $("#description").val(fundType.description);
                        $("#effectiveStart").val("");
                        $("#effectiveEnd").val("");
                        $("#formAddEditFundType").attr("action", "/Administration/EditFundType");
                       	fundModal.dialog("open");
                    }
                });
            }

            $('#permission').multiSelect({
                selectableHeader: "<div class='custom-header'>Available</div>",
                selectionHeader: "<div class='custom-header'>Selected Permissions</div>"
            });

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

            fundModal = $("#formAddEditFundType").dialog({
                autoOpen: false,
                modal: true,
                resizable: false,
                width: 'auto',
                buttons: {
                    "Submit": addEditFundType,
                    Cancel: cancelFund
                }
            });

            function addEditUser() {
                $("#formAddEditUser").submit();
            }

            function addEditFundType() {
                $("#formAddEditFundType").submit();
            }

            function cancel() {
                $("#id").val("");
                $("#firstName").val("");
                $("#lastName").val("");
                $('#permission').multiSelect('deselect_all');
                $("#email").val("");
                $("#password").val("");
                userModal.dialog("close");
            }

            function cancelFund() {
                $("#id").val("");
                $("description").val("");
                $("effectiveStart").val("");
                $("effectiveEnd").val("");
                fundModal.dialog("close");
            }
            

            function newUser(){
                $("#formHeader").text("New User");
                $("#formAddEditUser").attr("action", "/Administration/NewUser");
                $("#email").removeAttr("readonly");
                //$("#permission").val('2');
                userModal.dialog("open");
            }

            function newFundType(){
				$("#formHeader2").text("New Fund Type");
				$("#formAddEditFundType").attr("action", "/Administration/NewFundType");
				fundModal.dialog("open");
                }

            $(function() {
                $( "#effectiveStart" ).datepicker();
            });

            $(function() {
                $( "#effectiveEnd" ).datepicker();
            });

            
            $(document).ready(function () {
                $('#usersTable').DataTable();
                $('#fundTypesTable').DataTable();

                <c:if test="${failedUser != null}">
                $("#firstName").val("${failedUser.firstName}");
                $("#lastName").val("${failedUser.lastName}");
                $('#permission').multiSelect('deselect_all');
                $("#email").val("${failedUser.email}");
                $("#transactionType").val("${search.getTransactionType().toString()}");

                $("#formHeader").text("New User");
                $("#formAddEditUser").attr("action", "/Administration/NewUser");
                
                <c:if test="${failedUser.getId() != null}">
                $("#email").removeAttr("readonly");
                $('#id').val("${failedUser.id}");
                $("#formHeader").text("Edit User");
                $("#formAddEditUser").attr("action", "/Administration/EditUser");
                </c:if>

                $("#password").val("");
                userModal.dialog("open");
                </c:if>
            });
        </script>
        </body>
    </jsp:body>
</tags:template>