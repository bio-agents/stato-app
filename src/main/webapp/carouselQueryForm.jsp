<%@include file="header.jsp" %>

<%@page info="stato-app"%>

<%@ page import="java.io.File"%>
<%@ page import="java.util.List" %>
<%@ page import="org.isaagents.stato.STATOQueryDemo"%>
<%@ page import="org.isaagents.stato.STATOResult"%>


<%
    String queryType = request.getParameter("queryType");

    int start =0 , end=0;

    STATOQueryDemo statoQueryDemo = (STATOQueryDemo) context.getAttribute("statoQueryDemo");

    if (statoQueryDemo==null){
        String jspPath = session.getServletContext().getRealPath("/");
        String statoFilePath = jspPath+ "stato.owl";
        File statoFile = new File(statoFilePath);
        statoQueryDemo = new STATOQueryDemo(statoFile);
        context.setAttribute("statoQueryDemo", statoQueryDemo);
    }

    if (queryType==null){
        queryType = QueryInfo.QUERY_TYPE_ALL;
    }

    int index = queryInfo.getIndexForQueryType(queryType);
    start = queryInfo.getStart(index);
    end = queryInfo.getEnd(index);
    String queryTypeString = queryInfo.getQueryTypeString(index).toLowerCase();

    String queryNumberString = request.getParameter("hiddenButton");

    int queryNumber = start;

    if (queryNumberString!=null && !queryNumberString.equals("")){
        queryNumber = (new Integer(queryNumberString)).intValue();
    }

%>

<form method=post action="carouselQueryForm.jsp?queryType=<%=queryType%>" name=queryForm>

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

    <%


        if (queryTypeString.equals("all")) {
    %>
    <h2 align="center">All queries</h2>
    <%
    } else {
    %>
    <h2 align="center">Queries about <%=queryTypeString%></h2>

    <%
        }
    %>

    <div class="carousel slide carousel-fade" data-ride="carousel" id="myCarousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
        <%
            for(int j = start; j <= end; j++){
                String queryString= queryInfo.getQueryString(j);
        %>
        <li data-target="#myCarousel" data-slide-to="<%=j%>" <%= (j==queryNumber)? "class=\"active\"": "" %> ></li>
        <%
            }//for
        %>
    </ol>


    <!-- Wrapper for slides -->
    <div class="carousel-inner">

        <%

            for(int j = start; j <= end; j++){
                String queryString= queryInfo.getQueryString(j);
        %>
              <div class="item <%= (j==queryNumber)? "active": "" %> " id="<%=j%>">
                  <div class="carousel-caption">
                      <h2><%= queryString %></h2>

        <%

           //queryNumberString is null (it means that the 'Ask STATO' button was never pressed) or queryNumber is not the same as the current slide (j)
            if (queryNumberString==null || queryNumber!=j){
             %>
                      <p>
                          <!--<input type="hidden" id="hiddenButton_<%=j%>" name="hiddenButton"> -->
                          <input type="hidden" id="hiddenButton" name="hiddenButton">

                          <button id="askButton_<%=j%>" class="btn btn-warning has-spinner" style="width:150px" onclick="askSTATO('<%=j%>')">
                              Ask STATO
                              <span class="spinner"><i class="icon-spin icon-refresh"></i></span>
                          </button>

                      </p>
            <%

            //get the results - a query was selected or there are previous results
            } else {

                %>
                      <div class="container">
                          <div class="row">

                              <div class="col-md-6">


                <%

                List<STATOResult> resultList = statoQueryDemo.getPrecomputedResults(queryInfo,queryNumber);
                if (queryNumber == j || resultList != null) {
                   if (resultList ==null)
                       resultList = statoQueryDemo.runDLQuery(queryInfo,queryNumber);
                       int k = 0;

                    for(STATOResult statoResult: resultList){
                %>

                          <div class = "well well-sm" align="center">
                                  <a id="pop_<%=j%>_<%=k%>" class="result popper-upper btn"
                                     onmouseover="showPopup('#pop_<%=j%>_<%=k%>')"
                                     onmouseout="hidePopup('#pop_<%=j%>_<%=k%>')"
                                     href="http://bioportal.bioontology.org/ontologies/STATO/?p=classes&conceptid=<%=statoResult.getIRI()%>" target="_blank"
                                     rel="popover" data-original-title="<%=statoResult.getLabel()%>" data-content="<%=statoResult.getDefinition()%>">
                                     <%=statoResult.getLabel()%>
                                  </a>
                          </div>
                <%
                    k++;
                    } //for

                    %>

                 </div> <!--col-md-6 -->

                      <div class="col-md-4">

                      <h5 align="center"><i class="icon-info-sign"></i> STATO returned <%=resultList.size()%> results.</h5>
                      <h5 align="center"><i class = "icon-question-sign icon-lead"></i> How STATO query answering works?</h5>
                      <h6 align="center">These results are obtained by posing this expression to the <a class="result" href="bioportal.bioontology.org/ontologies/STATO">STATistics Ontology (STATO)</a>:</h6>
                      <h5 align="center"><span class="highlight"><%=queryInfo.getQuery(queryNumber)%></span></h5>

                       </div>
                      </div> <!--row-->
                          </div> <!--container-->
                      <%


                        }

                    } //else queryNumberString!=null

             %>
                </div> <!--carousel-caption -->
            </div> <!--item-->

        <%
            } //for each of the slides
        %>

    </div> <!--carousel-inner-->

    <!-- Controls -->
    <a class="carousel-control left" href="#myCarousel" data-slide="prev">
        <span class="icon-prev"></span>
    </a>
    <a class="carousel-control right" href="#myCarousel" data-slide="next">
        <span class="icon-next"></span>
    </a>

    <div id="carouselButtons">
        <button id="playButton" type="button" class="btn btn-default btn-xs">
            <span class="glyphicon glyphicon-play"></span>
        </button>
        <button id="pauseButton" type="button" class="btn btn-default btn-xs">
            <span class="glyphicon glyphicon-pause"></span>
        </button>
    </div>


</div>

<p align="center">

<i class="icon-flag icon-light"></i>
 Use the arrows or play/pause buttons to see all the queries. Press the button 'Ask STATO' to compute the results over the ontology.</p>

</form>
<!-- /.carousel -->

<%@include file="footer.jsp" %>
