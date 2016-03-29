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
        
        <link rel="stylesheet" type="text/css" href="/static/css/dataTables.tableTools.min.css">
        <script src="/static/js/dataTables.tableTools.min.js"></script>
    </jsp:attribute>
    <jsp:body>
        <div class="formBar">
            <form action="/Reports/Search" name="filter" method="post" id="reportFilter">
				<label style="color: white">Filter Based On Fund Type:</label>
        		<select id="fundType" name="fundType">
		        	<option id="" value="">All</option>
		            <c:forEach var="fundType" items="${fundTypes}" >
		            	<option id="${fundType.id}" value="${fundType.description}">${fundType.description}</option>
		        	</c:forEach>
        		</select>

                <label style="padding: 5px; color: white;">From:</label>
                <input class="input-block-level" id="dateFrom" name="startDate" style="vertical-align: middle; height: 20px;">
                <label style="padding: 5px; color: white;">To:</label>
                <input class="input-block-level" id="dateTo" name="endDate" style="vertical-align: middle; height: 20px;">
                <div class="btn btn-large btn-primary" onClick="reset()"><span>Reset</span></div>
            </form>
        </div>
		
		
        <div class="table-responsive" style="padding:15px">
	        <table class="table table-striped" id="tblTransferTransactions">
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
	                <th>Check Number</th>
        			<th>Case Number</th>
        			<th>Ci Number</th>
	            </tr>
	            </thead>
	            <tbody>
	            <c:forEach var="transaction" items="${transactions}" >
	                <tr>
	                    <td>${transaction.getId()}</td>
	                    <td><fmt:formatDate value="${transaction.date}" pattern="MM/dd/yyyy" /></td>
	                    <td>${transaction.getDescription()}</td>
	                    <td>${transaction.debitUser.getFullName()}</td>
	                    <td>${transaction.creditUser.getFullName()}</td>
	                    <td><fmt:formatNumber value="${transaction.amount}" type="currency" /></td>
	                    <td>${transaction.operatorUser.getFullName()}</td>
	                    <td>${transaction.fundType.description}</td>
	                    <td>${transaction.getCheckNumber()}</td>
    					<td>${transaction.getCaseNumber()}</td>
    					<td>${transaction.getCiNumber()}</td>	                    
	                </tr>
	            </c:forEach>
	            </tbody>
			<tfoot>
				<tr>
					<th></th>
	                <th></th>
	                <th></th>
	                <th>Debit Officer</th>
	                <th>Credit Officer</th>
	                <th></th>
	                <th>Operator</th>
	                <th></th>
	                <th></th>
        			<th></th>
        			<th></th>
				</tr>
			</tfoot>	            
	        </table>
        </div>        
        <script>
        
        	$.fn.dataTable.ext.search.push(
    			function( settings, data, dataIndex ) {
 					
			        var min = new Date($('#dateFrom').val());
			        var max = new Date($('#dateTo').val());
			        var age = Date.parse(data[1])  || 1;
			        
			        if ( ( isNaN( min ) && isNaN( max ) ) ||
			             ( isNaN( min ) && age <= max ) ||
			             ( min <= age   && isNaN( max ) ) ||
			             ( min <= age   && age <= max ) )
			        {
			            return true;
			        }
			        return false;
    			}
			);			

            $(document).ready(function () {
            	
                // Event listener to the two range filtering inputs to redraw on input
                $('#dateFrom, #dateTo').on('change', function() {
                    table.draw();
                } );
            	
            	$('#tblTransferTransactions').DataTable( {
                    initComplete: function () {
                        this.api().columns([3,4,6]).every( function () {
                            var column = this;
                            var select = $('<select><option value="">Filter by:</option></select>')
                                .appendTo( $(column.footer()).empty() )
                                .on( 'change', function () {
                                    var val = $.fn.dataTable.util.escapeRegex(
                                        $(this).val()
                                    );
                                    column
                                        .search( val ? '^'+val+'$' : '', true, false )
                                        .draw();
                                } );
             
                            column.data().unique().sort().each( function ( d, j ) {
                                select.append( '<option value="'+d+'">'+d+'</option>' )
                            } );
                        } );
                    }
                } );
            	
            	var table = $('#tblTransferTransactions').DataTable();
                var buttons = new $.fn.dataTable.TableTools(table, {
                	'sSwfPath':'/static/swf/copy_csv_xls_pdf.swf',
                	'aButtons':[{'sExtends':'copy', 'sButtonText':'Copy', "bFooter": false, "oSelectorOpts": {page: 'current'}}, 
                	            {'sExtends':'pdf', 'sButtonText':'Export to PDF', "sPdfOrientation": "landscape", "bFooter": false, "oSelectorOpts": {page: 'current'}},
                	            {'sExtends':'xls', 'sButtonText':'Save to Excel', 'sFileName':'*.xls', "bFooter": false, "oSelectorOpts": {page: 'current'}}, 
                	            'print']
                });
                $(buttons.fnContainer()).insertBefore('#tblTransferTransactions_wrapper');
                
            	var table = $('#tblTransferTransactions').DataTable();
            	$('#fundType').on('change', function () {
            	    table
            	        .columns(7)
            	        .search(this.value)
            	        .draw();
            	} );
            	
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
                </c:if>
            });
            
            function reset() {
            	
            	$('input').val('');
            	
            	var len = document.getElementsByTagName("select").length;
            	for (var i=0; i < len; i++) { 
            		document.getElementsByTagName("select")[i].selectedIndex = 0; 
            	}
            	
            	var table = $('#tblTransferTransactions').DataTable();
            	table.search('');
            	
            	table.columns([3,4,6,7]).search('');
            	table.draw();
            }
        </script>
    </jsp:body>
</tags:template>