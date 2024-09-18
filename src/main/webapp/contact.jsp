<%@include file="header.jsp"%>
<%@ page import="java.util.List" %>


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
                        <li class="dropdown">
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
                        <li class="active"><a href="contact.jsp">Contact and Support</a></li>
                        <li><a href="about.jsp">Acknowledgements</a></li>
                    </ul>
                </div>
            </div>
        </div>

    </div>
</div>


    <div class="container marketing">

    <h3>Meet the STATO team</h3>

        <div class="team-container" align="center">
            <div class="container">
                <div class="row clearfix">

                    <div class="team-user team-image-box col-xs-6 col-sm-6 col-md-4 col-lg-4">
                        <div class="text-center square"><img class="image-circle" src="assets/img/alejandra.jpg" alt="Alejandra Gonzalez-Beltran"></div>
                        <h5 class="team-title">Alejandra Gonzalez-Beltran</h5>
                        <h5 class="team-subtitle">Senior Software Engineer, Oxford e-Research Centre, University of Oxford</h5>
                        <a href="http://www.oerc.ox.ac.uk/people/alejandra" target="_blank" class="result">More info</a>
                    </div>


                    <div class="team-user team-image-box col-xs-6 col-sm-6 col-md-4 col-lg-4">
                        <div class="text-center square"><img class="image-circle" src="assets/img/philippe.jpg" alt="Philippe Rocca-Serra"></div>
                        <h5 class="team-title">Philippe Rocca-Serra</h5>
                        <h5 class="team-subtitle">Technical Project Leader, Oxford e-Research Centre, University of Oxford</h5>
                        <a href="http://www.oerc.ox.ac.uk/people/philippe-rocca-serra" target="_blank" class="result">More info</a>
                    </div>

                </div>

                <div class="row clearfix">
                    <div class="team-user team-image-box col-xs-6 col-sm-6 col-md-4 col-lg-4">
                        <div class="text-center square"><img class="image-circle" src="assets/img/orlaith.jpg" alt="Orlaith Burke"></div>
                        <h5 class="team-title">Orlaith Burke</h5>
                        <h5 class="team-subtitle">Senior Statistician, Nuffield Department of Population Health, University of Oxford</h5>
                        <a href="http://www.linkedin.com/pub/orlaith-burke/51/516/6b7" target="_blank" class="result">More info</a>
                    </div>
                    <div class="team-user team-image-box col-xs-6 col-sm-6 col-md-4 col-lg-4">
                        <div class="text-center square"><img class="image-circle" src="assets/img/susanna.jpg" alt="Susanna-Assunta Sansone"></div>
                        <h5 class="team-title">Susanna-Assunta Sansone</h5>
                        <h5 class="team-subtitle">Associate Director, Oxford e-Research Centre, University of Oxford</h5>
                        <a href="http://www.oerc.ox.ac.uk/people/susanna-assunta-sansone" target="_blank" class="result">More info</a>
                    </div>
                </div>
            </div>
        </div>
   </div>


<hr>

<div class="container marketing">

    <h3>Support</h3>

    <p class="lead">For discussions about the STAtistics Ontology (STATO), please contact Alejandra and Philippe. </p>
    <p class="lead">The mailing list for STATO is the: <a href="mailto:stat-ontology@googlegroups.com">STAT-Ontology Google Group</a>.</p>
    <p class="lead">If you have term requests, plese use the issue tracker is available at: <a href="https://github.com/ISA-agents/stato/issues">STATO Github site</a>.</p>
</div>



<%@include file="footer.jsp"%>