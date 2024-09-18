package org.isaagents.stato;

import org.isaagents.ontoapp.QueryInfo;
import org.isaagents.owl.DLQueryEngine;
import org.isaagents.owl.DLQueryParser;
import org.isaagents.owl.OWLClassifier;
import org.semanticweb.HermiT.Reasoner;
import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.*;
import org.semanticweb.owlapi.reasoner.OWLReasoner;
import org.semanticweb.owlapi.util.AnnotationValueShortFormProvider;
import org.semanticweb.owlapi.util.ShortFormProvider;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.*;
import java.util.logging.Logger;

/**
 * Created by the ISATeam.
 * User: agbeltran
 * Date: 04/03/2014
 * Time: 15:41
 *
 * @author <a href="mailto:alejandra.gonzalez.beltran@gmail.com">Alejandra Gonzalez-Beltran</a>
 */
public class STATOQueryDemo{

    private OWLClassifier classifier = null;
    private OWLOntologyManager manager = null;
    private OWLDataFactory dataFactory = null;
    private OWLOntology stato = null;

    private DLQueryParser dlQueryParser = null;
    private DLQueryEngine dlQueryEngine = null;

    private final static Logger logger = Logger.getLogger(STATOQueryDemo.class.getName());

    //a map with the DLquery string
    private Map<String, List<STATOResult>> resultMap;

    public STATOQueryDemo(File statoFile) {
        System.out.println("STATOQueryDemo constructor "+statoFile);
        resultMap = new HashMap<String, List<STATOResult>>();
        try {
            manager = OWLManager.createOWLOntologyManager();
            stato = loadLocalOntology(statoFile);
            dataFactory = manager.getOWLDataFactory();

            List<OWLAnnotationProperty> annotationProperties = new ArrayList();

            Map<OWLAnnotationProperty, List<String>> langMap = new HashMap<OWLAnnotationProperty, List<String>>();

            Map<IRI, List<String>> annotMap = new HashMap<IRI, List<String>>();
            List<String> langList = new ArrayList();

            String en = Locale.ENGLISH.getLanguage();
            langList.add(en);
            annotMap.put(dataFactory.getRDFSLabel().getIRI(), langList);

            for (IRI iri : annotMap.keySet()){
                OWLAnnotationProperty p  = manager.getOWLDataFactory().getOWLAnnotationProperty(iri);
                annotationProperties.add(p);
                langMap.put(p, annotMap.get(iri));
            }

            ShortFormProvider shortFormProvider = new AnnotationValueShortFormProvider(
                    annotationProperties,
                    //langMap,
                    Collections.<OWLAnnotationProperty, List<String>> emptyMap(),
                    manager);

            dlQueryEngine = new DLQueryEngine(createReasoner(stato), shortFormProvider);

        } catch (IOException e) {
            e.printStackTrace();
        } catch (OWLOntologyCreationException e) {
            e.printStackTrace();
        }
    }


    /**
     * Relying on Hermit reasoner
     *
     * @param rootOntology
     * @return
     */
    private OWLReasoner createReasoner(final OWLOntology rootOntology) {
        System.out.println("Creating reasoner...");
        OWLReasoner reasoner = new Reasoner.ReasonerFactory().createReasoner(rootOntology);
        System.out.println("After creating reasoner...");
        return reasoner;
    }
      
    private OWLOntology loadLocalOntology(File file)
            throws IOException, OWLOntologyCreationException {
        System.out.println("In loadLocalOntology... file="+file);
        System.out.println("calling manager.loadOntologyFromOntologyDocument("+file+")");
        System.out.println("absolute path ="+ file.getAbsolutePath());
        System.out.println("file length ="+ file.length());

        return manager.loadOntologyFromOntologyDocument(file);
    }

    public List<STATOResult> runDLQuery(QueryInfo queryInfo, int queryNumber){
        logger.info("Running query number "+ queryNumber);
        return runDLQuery(queryInfo.getQuery(queryNumber));
    }


    private List<STATOResult> runDLQuery(String dlQueryString){
        List<STATOResult> resultString = resultMap.get(dlQueryString);

        if (resultString!=null)
            return resultString;

        Set<OWLClass> set = dlQueryEngine.getSubClasses(dlQueryString, false);
        resultString = processResults(set);

        resultMap.put(dlQueryString, resultString);

        return resultString;
    }

    public List<STATOResult> processResults(Set<OWLClass> set){

        List<STATOResult> list = new ArrayList<STATOResult>();

        STATOResult result = null;
        String iri = null, label = null, definition = null;
        String owlNothingIRI = dataFactory.getOWLNothing().getIRI().toString();
        for(OWLClass cls: set){

            iri = cls.getIRI().toString();

            if (iri.equals(owlNothingIRI))
                continue;

            // Get the annotations on the class that use the label property (rdfs:label)
            for (OWLAnnotation annotation : cls.getAnnotations(stato, dataFactory.getRDFSLabel())) {
                if (annotation.getValue() instanceof OWLLiteral) {
                    OWLLiteral val = (OWLLiteral) annotation.getValue();
                    //Get your String here
                    label = val.getLiteral();
                }
            }
            for (OWLAnnotation annotation : cls.getAnnotations(stato, dataFactory.getOWLAnnotationProperty(IRI.create("http://purl.obolibrary.org/obo/IAO_0000115")))) {
                if (annotation.getValue() instanceof OWLLiteral) {
                    OWLLiteral val = (OWLLiteral) annotation.getValue();
                    //Get your String here
                    definition = val.getLiteral();
                }
            }
            result = new STATOResult(iri, label, definition);
            list.add(result);
        }
        return list;
    }


    public List<STATOResult> getPrecomputedResults(QueryInfo queryInfo, int queryNumber){
        logger.info("Getting precomputed results for queryNumber="+queryNumber);
        return getPrecomputedResults(queryInfo.getQuery(queryNumber));
    }

    private List<STATOResult> getPrecomputedResults(String dlQueryString){
        if (resultMap!=null)
            return resultMap.get(dlQueryString);
        return null;
    }


    public void runQueries(QueryInfo queryInfo){
        for(String dlQuery: queryInfo.getQueries()){
            List<STATOResult> resultList = runDLQuery(dlQuery);
            for(STATOResult result: resultList){
                System.out.println("label =" + result.getLabel());
                System.out.println("IRI =" + result.getIRI());
            }
        }
    }

    public static void main(String[] args) throws Exception {

        URL url = STATOQueryDemo.class.getClass().getResource("/stato/releases/1.1/stato.owl");
        System.out.println("url = "+url);
        String path =  url.getPath();
        File statoFile = new File(path);
        STATOQueryDemo statoQueryDemo = new STATOQueryDemo(statoFile);
        List<STATOResult> resultList = statoQueryDemo.runDLQuery("'statistical hypothesis test' and achieves_planned_objective some 'association testing objective'");
        for(STATOResult result: resultList){
            System.out.println("label =" + result.getLabel());
            System.out.println("IRI =" + result.getIRI());
        }
    }

}
