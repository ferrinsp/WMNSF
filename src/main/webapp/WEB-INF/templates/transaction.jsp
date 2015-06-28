<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<tags:template pageTitle="Transfer">
    <jsp:attribute name="head">
        <link rel="stylesheet" href="/static/css/nav-tabs.css">
    </jsp:attribute>
    <jsp:body>
        <body>

        <div role="tabpanel" class="formTabPane">
            <div class="tabs">
                <ul role="tablist" class="nav nav-tabs formSelect">
                    <li role="presentation" id="transferTab" class="active">
                        <a href="#transferPage" aria-controls="transferPage" role="tab" data-toggle="tab">Transfer</a>
                    </li>
                    <li role="presentation" id="expendTab">
                        <a href="#expendPage" aria-controls="expendPage" role="tab" data-toggle="tab">Expenditure</a>
                    </li>
                </ul>
            </div>
            <div class="formHolder tab-content">
                <div role="tabpanel" class="formContent tab-pane fade in active" id="transferPage">
                    <!-- beginning of include -->
                    <jsp:include page="transferTransaction.jsp" />
                    <!-- end of include -->
                </div>
                <div role="tabpanel" class="formContent tab-pane fade in" id="expendPage">
                    <h1>Test tab2</h1>
                </div>
            </div>
        </div>

        </body>
    </jsp:body>
</tags:template>