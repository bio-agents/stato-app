package org.isaagents.owl;

import org.coode.owlapi.manchesterowlsyntax.ManchesterOWLSyntaxClassExpressionParser;
import org.coode.owlapi.manchesterowlsyntax.ManchesterOWLSyntaxEditorParser;
import org.semanticweb.owlapi.expression.OWLEntityChecker;
import org.semanticweb.owlapi.expression.ParserException;
import org.semanticweb.owlapi.expression.ShortFormEntityChecker;
import org.semanticweb.owlapi.model.*;
import org.semanticweb.owlapi.util.*;

import java.util.Set;

/**
 * Created by the ISATeam.
 * User: agbeltran
 * Date: 04/03/2014
 * Time: 13:55
 *
 * @author <a href="mailto:alejandra.gonzalez.beltran@gmail.com">Alejandra Gonzalez-Beltran</a>
 */
public class DLQueryParser {

    private final OWLOntology rootOntology;
    private final ShortFormProvider shortFormProvider;

    private BidirectionalShortFormProvider bidiShortFormProvider = null;
    private OWLOntologyManager manager = null;
    private OWLDataFactory dataFactory = null;
    private ManchesterOWLSyntaxClassExpressionParser parser = null;
    private OWLClassExpression description = null;


    /**
     * Constructs a DLQueryParser using the specified ontology and short form
     * provider to map entity IRIs to short names.
     *
     * @param rootOntology
     *        The root ontology. This essentially provides the domain vocabulary
     *        for the query.
     * @param shortFormProvider
     *        A short form provider to be used for mapping back and forth
     *        between entities and their short names (renderings).
     */
    public DLQueryParser(OWLOntology rootOntology, ShortFormProvider shortFormProvider){
        this.rootOntology = rootOntology;
        this.shortFormProvider = shortFormProvider;

        //debugging
//        System.out.println("Classes in signature");
//        Set<OWLClass> classes = rootOntology.getClassesInSignature();
//        for(OWLClass clazz : classes){
//            if (clazz.getIRI().equals(IRI.create("http://purl.obolibrary.org/obo/OBI_0000673"))){
//                System.out.println(clazz.getIRI());
//                System.out.println(clazz.getAnnotations(rootOntology));
//            }
//        }
        //debugging


        manager = rootOntology.getOWLOntologyManager();
        dataFactory = manager.getOWLDataFactory();

        Set<OWLOntology> importsClosure = rootOntology.getImportsClosure();

        //debugging
        System.out.println("imports closure");
        System.out.println(importsClosure);
        //end debugging

        System.out.println("ontologies");
        System.out.println(manager.getOntologies());

        // Create a bidirectional short form provider to do the actual mapping.
        // It will generate names using the input
        // short form provider.
        //bidiShortFormProvider = new BidirectionalShortFormProviderAdapter(
        //        manager, importsClosure, shortFormProvider);
        bidiShortFormProvider = new BidirectionalShortFormProviderAdapter(
                manager.getOntologies(), shortFormProvider);
    }


    /**
     * Parses a class expression string to obtain a class expression.
     *
     * @param classExpressionString
     *        The class expression string
     * @return The corresponding class expression if the class expression string
     *         is malformed or contains unknown entity names.
     */
    public OWLClassExpression parseClassExpression(String classExpressionString){

//        System.out.println("ontologies...");
//        System.out.println(manager.getOntologies());

        // Set up the real parser
        ManchesterOWLSyntaxEditorParser parser = new ManchesterOWLSyntaxEditorParser(dataFactory, classExpressionString);
        parser.setDefaultOntology(rootOntology);

        // Specify an entity checker that wil be used to check a class
        // expression contains the correct names.
        OWLEntityChecker entityChecker = new ShortFormEntityQuoteChecker(
                bidiShortFormProvider);
        parser.setOWLEntityChecker(entityChecker);

        // Do the actual parsing
        return parser.parseClassExpression();
    }


}
