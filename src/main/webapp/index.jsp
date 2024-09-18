<%@include file="header.jsp"%>
<%@page import="java.util.List" %>

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
                                <li><a href="contact.jsp">Contact and Support</a></li>
                                <li><a href="about.jsp">Acknowledgements</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>
        </div>


    <!-- Jumbotron -->
    <div class="jumbotron">

        <p align="center"><a href="http://isa-agents.github.io/stato/"> <img src="https://raw.github.com/ISA-agents/stato/dev/images/stato-logo-1.png" alt="STATO Logo" height="200" width="400"/></a></p>

        <p></p>

        <p class="lead" align="center">STATO is a <strong>general-purpose STATistics Ontology</strong>. </p>
        <p class="lead" align="center">Its aim is to provide coverage for processes such as <strong>statistical tests</strong>, their <strong>conditions of application</strong>, </p>
        <p class="lead" align="center">and information needed or resulting from statistical methods, such as <strong>probability distributions</strong>, <strong>variables</strong>, <strong>spread and variation metrics</strong>.</p>
        <p class="lead" align="center">STATO also covers aspects of <strong>experimental design</strong> and description of <strong>plots and graphical representations</strong></p>
        <p class="lead" align="center">commonly used to provide visual cues of data distribution or layout and to assist review of the results.</p>

        <p align="center"><a class="btn btn-large btn-warning" href="queryCases.jsp">View the STATO query cases</a></p>
<!--
        <p class="lead" align="center"><strong>STATO</strong> is a <strong>general-purpose STATistics Ontology</strong> that aims to provide coverage for processes such as statistical tests, </p>
        <p class="lead" align="center">their conditions of applications, and information needed or resulting from statistical methods,</p>
        <p class="lead" align="center">such as probability distributions, variable, spread and variation metrics. </p>
        <p class="lead" align="center"><strong>STATO</strong> also covers aspects of experimental design and description of plots and graphical representations</p>
        <p class="lead" align="center">commonly used to provide visual cues of data distribution or layout and to assist review of the results.</p>

        <p class="lead" align="center">For more information about STATO, please visit the <a href="http://isa-agents.github.io/stato/">STATO website</a>.</p>

        <p class="lead" align="center">This web application is a <strong>demonstration on some of the STATO elements</strong>, shown by running queries over the ontology. </p>
        <p class="lead" align="center">We show natural language queries and their counterparts written in description logics, relying on <a href="http://www.w3.org/TR/owl2-manchester-syntax/">Manchester OWL syntax</a>.</p>
        -->
    </div>


<div class="container">
    <!-- Example row of columns -->
    <div class="row">
        <div class="col-md-4">
            <h2>Background</h2>
            <p>Read more about why STATO was developed and the community behind the ontology. </p>
            <p><a class="btn btn-primary" href="#background" role="button">View background &raquo;</a></p>
        </div>
        <div class="col-md-4">
            <h2>Content</h2>
            <p>Find out about what the elements represented in the STATO ontology and links to its content.</p>
            <p><a class="btn btn-primary" href="#content" role="button">View content &raquo;</a></p>
        </div>
        <div class="col-md-4">
            <h2>Objectives</h2>
            <p>Learn about the main objectives set out for the development of the STATO ontology. </p>
            <p><a class="btn btn-primary" href="#objectives" role="button">View objectives &raquo;</a></p>
        </div>
    </div>

<hr>

    <div class="jumbotron">

        <a id="background"></a>
        <h2>Background</h2>

        <p class="lead">The STATO project started in early 2012, as part of the requirement of the <strong>community-driven <a href="http://isacommons.org">ISA Commons</a></strong> to represent the results of data analysis.</p>
        <p class="lead">STATO is a standalone project since Nov 2012. STATO is driven and funded by several ISA-based projects and their user community, but also by collaborations with <strong>data publication platforms</strong>.</p>
        <p class="lead">STATO is applicable to, but not limited, the broad life, natural and biomedical science domain with <strong>documented applications</strong> for factorial design, association studies, differential expression, hit selection and meta-analysis.</p>
        <p class="lead">STATO has been developed to interoperate with other <a href="http://www.obofoundry.org/">OBO Foundry</a> ontologies, hence relies on the Basics Formal Ontology (<a href="https://code.google.com/p/bfo/">BFO</a>) as a top level ontology and uses the Ontology for Biomedical Investigations (<a href="http://obi-ontology.org/page/Main_Page">OBI</a>) as mid-level ontology.</p>
        <p class="lead">The ontology is made available under <a href="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution License</a>.</p>

        </div>


<hr>


    <div class="container marketing">
        <a id="content"></a>
        <h2>Content</h2>

        <p class="lead">STATO provides <strong>textual definitions</strong> for all terms, as well as <strong>formal definitions</strong> for most of the terms allowing automatic classification, for example, categorising the statistical methods depending on the nature of the variables used as input, the conditions and their domain of application.</p>

        <p class="lead">STATO also benefits from: <p>

        <ol>
            <li class="lead"><strong>extensive documentation</strong> with the provision of textual and formal definitions; </li>
            <li class="lead">associated <strong>R code snippets</strong> via a dedicated 'R-command' annotation, to facilate a 'learn and apply' approach in the popular R environment;</li>
            <li class="lead"><strong>query examples</strong> documentation, highlighting how the ontology can be harnessed for reviewers/tutors/student alike.</li>
        </ol>


        <p class="lead">STATO is developed using the Web Ontology Language (OWL). The latest release can be browsed through <a href="http://bioportal.bioontology.org/">BioPortal</a>. The development version and previous releases can be found in the <a href="https://github.com/">GitHub</a>.</p>

        <div class="row">
            <div class="inner">

                <div class="col-md-4" >
                    <a class="github_banner" href="https://github.com/ISA-agents/stato" target="_blank">View STATO on GitHub</a>
                </div>

                <div class="col-md-4">
                    <a class="banner" href="http://bioportal.bioontology.org/ontologies/STATO">View STATO on BioPortal</a>
                </div>
            </div>

        </div>

    </div>


<hr>

    <div class="jumbotron">
        <a id="objectives"></a>
    <h2>Objectives</h2>

<p class="lead">STATO development is informed by use cases, some of which we referred to in the Background section. For more information about users and use cases, see <a href="useCases.jsp">the specific page</a>. STATO is set to provide:</p>

<ol>

    <li class="lead">a resource to help in the communication and reporting of scientific
        results for biologists, scientists using statistical methods. STATO can
        also currently support Publishers and Journal reviewers by helping
        reporting guideline compliance and standardizing annotation of result
        tables</li>

    <li class="lead">a set of core classes for annotating statistical methods used in life, natural and biomedical sciences investigations, but also metrics and estimates generated by those methods and link to the hypothesis being evaluated to allow better representation and data review.</li>

    <li class="lead">formal definitions of most common univariate statistical tests to provide a didactic framework for students and reviewers</li>

    <li class="lead">a formal way of navigating the conditions of application of classic statistical tests and distinguishing them</li>

    <li class="lead">a semantic framework to support the creation of standardized analysis reports to help with review of results</li>

    <li class="lead">a specialized vocabulary enabling text mining of statistical analyses.</li>

</ol>
</div>



<%@include file="footer.jsp"%>

