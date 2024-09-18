<%@ page import="org.isaagents.stato.STATOResult" %>
<%@ page import="java.util.List" %>
<%@ page import="org.isaagents.stato.STATOQueryDemo" %>
<%@ page import="java.io.File" %>

<%@include file="header.jsp" %>

<%
    int j = (new Integer(request.getParameter("j"))).intValue();
    String queryString = queryInfo.getQueryString(j);

    STATOQueryDemo statoQueryDemo = (STATOQueryDemo) context.getAttribute("statoQueryDemo");

    if (statoQueryDemo==null){
        String jspPath = session.getServletContext().getRealPath("/");
        String statoFilePath = jspPath+ "stato.owl";
        File statoFile = new File(statoFilePath);
        statoQueryDemo = new STATOQueryDemo(statoFile);
        context.setAttribute("statoQueryDemo", statoQueryDemo);
    }


    List<STATOResult> resultList = statoQueryDemo.getPrecomputedResults(queryInfo,j);
    if (resultList ==null)
        resultList = statoQueryDemo.runDLQuery(queryInfo,j);
    int k = 0;

%>


    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
        <h4 class="modal-title" id="myModalLabel"><%=queryString%></h4>
    </div>
    <div class="modal-body">
        <h3 style="color:orange">STATO results</h3>


<%


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


<h5 align="center"><i class="icon-info-sign"></i> STATO returned <%=resultList.size()%> results.</h5>
<h5 align="center"><i class = "icon-question-sign icon-lead"></i> How STATO query answering works?</h5>
<h6 align="center">These results are obtained by posing this expression to the <a class="result" href="bioportal.bioontology.org/ontologies/STATO">STATistics Ontology (STATO)</a>:</h6>
<h5 align="center"><span class="highlight"><%=queryInfo.getQuery(j)%></span></h5>



</div>
<div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
</div>
