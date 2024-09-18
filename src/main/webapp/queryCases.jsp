<%@ page import="java.util.List" %>
<%@include file="header.jsp"%>


<div class="container">

    <div class="navbar-wrapper">
        <div class="container">

            <div class="navbar navbar-inverse navbar-static-top" role="navigation">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="index.jsp">STATO</a>
                    </div>
                    <div class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li class="active" class="dropdown">
                                <a href="queryCases.jsp" class="dropdown-toggle" data-toggle="dropdown">Query cases <b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="queryCases.jsp">Query cases by type</a></li>
                                    <li class="divider"></li>
                                    <li class="dropdown-header">Grid View</li>
                                    <%
                                        List<String> queryTypeList = queryInfo.getQueryTypes();
                                        List<String> queryTypeStringList = queryInfo.getQueryStringTypes();

                                        for(int i=0; i < queryTypeList.size(); i++){
                                    %>
                                    <li><a href="gridQueryForm.jsp?queryType=<%=queryTypeList.get(i)%>"><%=queryTypeStringList.get(i)%> query cases</a></li>
                                    <%
                                        }
                                    %>
                                    <li class="divider"></li>
                                    <li class="dropdown-header">Carousel View</li>
                                    <%

                                        for(int i=0; i < queryTypeList.size(); i++){
                                    %>
                                    <li><a href="carouselQueryForm.jsp?queryType=<%=queryTypeList.get(i)%>"><%=queryTypeStringList.get(i)%> query cases</a></li>
                                    <%
                                        }
                                    %>
                                </ul>
                            </li>
                            <li><a href="useCases.jsp">Users and Use Cases</a></li>
                            <li><a href="contact.jsp">Contact and Support</a></li>
                            <li><a href="about.jsp">Acknowledgements</a></li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>


    <form method=post name="selectQueryViewForm">

    <div class="jumbotron">
        <h2 align="center">Query Cases</h2>

        <p class="lead">STATO is a representation of the statistical domain. We present multiple questions on that domain and demonstrate how the ontology answers them. The query answering process relies on description logics expressions.</p>

        <p>Please, select below 'carousel' or 'grid' view as well as a specific type of query (or all of them) by pressing the 'Ask STATO' buttons.</p>
    </div>

    <hr>

    <div class="container marketing">

        <div class="btn-group-wrap">
            <div class="btn-group" data-toggle="buttons" data-toggle-default-class="btn-default">
                <label class="btn btn-xs btn-default" data-toggle-class="btn-primary">
                    <input type="radio" name="view" value="carousel" id="carousel-view" />
                    Carousel View
                </label>
                <label class="btn btn-xs btn-primary active" data-toggle-class="btn-primary">
                    <input type="radio" name="view" value="grid" id="grid-view" checked />
                    Grid View
                </label>
            </div>
        </div>

        <!-- Three columns of text below the carousel -->
        <div class="row">

            <div class="col-lg-4">
                <h2 class="highlight">All query cases</h2>
                <p>STATO helps answer queries about statistical tests, plots, measures and designs.</p>
                <button class="btn btn-large btn-warning" onclick="selectQueryView('all')">Ask STATO</button>
            </div>
            <!-- /.col-lg-4 -->

            <!-- /.col-lg-4 -->
            <div class="col-lg-4">
                <!--<img class="img-circle" data-src="holder.js/140x140" alt="Generic placeholder image">-->
                <h2 class="highlight"><%=queryInfo.getQueryTypeString(0)%></h2>
                <p><%=queryInfo.getQueryTypeDescription(0)%></p>
                <button class="btn btn-large btn-warning" onclick="selectQueryView('<%=queryInfo.getQueryType(0)%>')">Ask STATO about <%=queryInfo.getQueryType(0)%></button>
            </div>
            <!-- /.col-lg-4 -->

            <div class="col-lg-4">
                <h2 class="highlight"><%=queryInfo.getQueryTypeString(1)%></h2>
                <p><%=queryInfo.getQueryTypeDescription(1)%></p>
                <button class="btn btn-large btn-warning" onclick="selectQueryView('<%=queryInfo.getQueryType(1)%>')">Ask STATO about <%=queryInfo.getQueryType(1)%></button>
            </div>

    </div>

        <div class="row">

            <div class="col-lg-4">

            </div>

            <div class="col-lg-4">
                <h2 class="highlight"><%=queryInfo.getQueryTypeString(2)%></h2>
                <p><%=queryInfo.getQueryTypeDescription(2)%></p>
                <button class="btn btn-large btn-warning" onclick="selectQueryView('<%=queryInfo.getQueryType(2)%>')">Ask STATO about <%=queryInfo.getQueryType(2)%></button>
            </div>
            <!-- /.col-lg-4 -->

            <div class="col-lg-4">
                <h2 class="highlight"><%=queryInfo.getQueryTypeString(3)%></h2>
                <p><%=queryInfo.getQueryTypeDescription(3)%></p>
                <button class="btn btn-large btn-warning" onclick="selectQueryView('<%=queryInfo.getQueryType(3)%>')">Ask STATO about <%=queryInfo.getQueryType(3)%></button>
            </div>

            </div>

        </div>
        <!-- /.row -->


</form>

<%@include file="footer.jsp" %>