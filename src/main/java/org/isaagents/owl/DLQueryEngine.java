package org.isaagents.owl;

import org.semanticweb.HermiT.Reasoner;
import org.semanticweb.owlapi.model.*;
import org.semanticweb.owlapi.reasoner.InferenceType;
import org.semanticweb.owlapi.reasoner.Node;
import org.semanticweb.owlapi.reasoner.NodeSet;
import org.semanticweb.owlapi.reasoner.OWLReasoner;
import org.semanticweb.owlapi.util.*;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.logging.Logger;

public class DLQueryEngine {

    private final OWLReasoner reasoner;
    private DLQueryParser parser;
    private OWLOntologyManager manager;
    private OWLDataFactory factory;
    private OWLOntology rootOntology;

    private final static Logger logger = Logger.getLogger(DLQueryEngine.class.getName());

    /**
     * Constructs a DLQueryEngine. This will answer "DL queries" using the
     * specified reasoner. A short form provider specifies how entities are
     * rendered.
     *
     * @param reasoner
     *        The reasoner to be used for answering the queries.
     * @param shortFormProvider
     *        A short form provider.
     */
    public DLQueryEngine(OWLReasoner reasoner,
                         ShortFormProvider shortFormProvider) {
        this.reasoner = reasoner;
        rootOntology = reasoner.getRootOntology();


        manager = rootOntology.getOWLOntologyManager();
        factory = manager.getOWLDataFactory();

//        System.out.println("Checking consistency...");
//        if(!reasoner.isConsistent()) {
//            System.out.println("Ontology is not consistent!");
//            return;
//        }
//        System.out.println("End of checking consistency...");
//
//        reasoner.precomputeInferences(InferenceType.CLASS_HIERARCHY);
//
//        List<InferredAxiomGenerator<? extends OWLAxiom>> gens = new ArrayList<InferredAxiomGenerator<? extends OWLAxiom>>();
//        gens.add(new InferredSubClassAxiomGenerator());
//        gens.add(new InferredClassAssertionAxiomGenerator());
//
//        InferredOntologyGenerator iog = new InferredOntologyGenerator(reasoner, gens);
//
//        System.out.println("Using these axiom generators:");
//        for(InferredAxiomGenerator inf: iog.getAxiomGenerators()) {
//            System.out.println("    "+ inf);
//        }
//
//
//        iog.fillOntology(manager, rootOntology);
//
//        //change IRI
//        OWLOntologyURIChanger uriChanger = new OWLOntologyURIChanger(manager);
//        List<OWLOntologyChange> list = uriChanger.getChanges(rootOntology, IRI.create("http://purl.obolibrary.org/obo/stato.owl"));
//        manager.applyChanges(list);

        parser = new DLQueryParser(rootOntology, shortFormProvider);
    }

    /**
     * Gets the superclasses of a class expression parsed from a string.
     *
     * @param classExpressionString
     *        The string from which the class expression will be parsed.
     * @param direct
     *        Specifies whether direct superclasses should be returned or not.
     * @return The superclasses of the specified class expression If there was a
     *         problem parsing the class expression.
     */
    public Set<OWLClass> getSuperClasses(String classExpressionString,
                                         boolean direct) {
        if (classExpressionString.trim().length() == 0) {
            return Collections.emptySet();
        }
        OWLClassExpression classExpression = parser.parseClassExpression(classExpressionString);
        NodeSet<OWLClass> superClasses = reasoner.getSuperClasses(
                classExpression, direct);
        return superClasses.getFlattened();
    }

    /**
     * Gets the equivalent classes of a class expression parsed from a string.
     *
     * @param classExpressionString
     *        The string from which the class expression will be parsed.
     * @return The equivalent classes of the specified class expression If there
     *         was a problem parsing the class expression.
     */
    public Set<OWLClass> getEquivalentClasses(String classExpressionString) {
        if (classExpressionString.trim().length() == 0) {
            return Collections.emptySet();
        }
        OWLClassExpression classExpression = parser.parseClassExpression(classExpressionString);
        Node<OWLClass> equivalentClasses = reasoner
                .getEquivalentClasses(classExpression);
        Set<OWLClass> result;
        if (classExpression.isAnonymous()) {
            result = equivalentClasses.getEntities();
        } else {
            result = equivalentClasses.getEntitiesMinus(classExpression
                    .asOWLClass());
        }
        return result;
    }

    /**
     * Gets the subclasses of a class expression parsed from a string.
     *
     * @param classExpressionString
     *        The string from which the class expression will be parsed.
     * @param direct
     *        Specifies whether direct subclasses should be returned or not.
     * @return The subclasses of the specified class expression If there was a
     *         problem parsing the class expression.
     */
    public Set<OWLClass> getSubClasses(String classExpressionString,
                                       boolean direct) {
        if (classExpressionString.trim().length() == 0) {
            return Collections.emptySet();
        }
        OWLClassExpression classExpression = parser.parseClassExpression(classExpressionString);
        logger.info("DLQuery = "+classExpressionString);
        logger.info("ClassExpression =" + classExpression);
        logger.info("------- Asking reasoner for subclasses... ");
        NodeSet<OWLClass> subClasses = reasoner.getSubClasses(classExpression,
                direct);
        logger.info("------ end.");
        return subClasses.getFlattened();
    }

    /**
     * Gets the instances of a class expression parsed from a string.
     *
     * @param classExpressionString
     *        The string from which the class expression will be parsed.
     * @param direct
     *        Specifies whether direct instances should be returned or not.
     * @return The instances of the specified class expression If there was a
     *         problem parsing the class expression.
     */
    public Set<OWLNamedIndividual> getInstances(String classExpressionString,
                                                boolean direct) {
        if (classExpressionString.trim().length() == 0) {
            return Collections.emptySet();
        }
        OWLClassExpression classExpression = parser.parseClassExpression(classExpressionString);
        NodeSet<OWLNamedIndividual> individuals = reasoner.getInstances(
                classExpression, direct);
        return individuals.getFlattened();
    }
}