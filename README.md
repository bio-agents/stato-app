# Web Application for the STATO ontology #

This is the source code for the web application demonstrating the STATO ontology. It includes details about the ontology, its purpose, use cases and development team, as well as a set of queries that demonstrate the content of the ontology.

The live version of this website is available at: http://stato-ontology.org/

Version 1.0: [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1169894.svg)](https://doi.org/10.5281/zenodo.1169894) 



### Implementation details ###

This STATO-app was developed to demonstrate the capabilities of the STATO ontology.

* Java Server Pages (JSP) to create dynamically generated pages
* Java classes that deal with classifying the STATO ontology and running description logic queries over it.

### Setup ###

The STATO-app is a Maven project.

You can compile the project with 

```mvn compile```

To produce the war file:

```mvn war:war```

Then, you can deploy the war file into a web application container such as Tomcat.

### Contribution guidelines ###

If you are interested in contributing to the STATO-app, you can:
* contact [me](https://github.com/agbeltran)
* report bugs or feature requests in the issue tracker
* send a pull request
 

### License ###

https://github.com/agbeltran/stato-app/blob/master/LICENSE.md

