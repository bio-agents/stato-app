package org.isaagents.stato;

/**
 * Created by agbeltran on 22/05/2014.
 */
public class STATOResult {

    private String iri = null;
    private String label = null;
    private String definition = null;

    public STATOResult(String iri, String label, String definition){
        this.iri = iri;
        this.label = label;
        this.definition = definition;
    }

    public String getIRI(){
        return iri;
    }

    public String getLabel(){
        return label;
    }

    public String getDefinition(){
        return definition;
    }

}
