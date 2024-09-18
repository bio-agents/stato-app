package org.isaagents.ontoapp;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by agbeltran on 09/06/2014.
 */
public class QueryInfo {

    private ArrayList<String> queryStringList = new ArrayList<String>();
    private ArrayList<String> queryList = new ArrayList<String>();
    private ArrayList<String> queryTypeList = new ArrayList<String>();
    private ArrayList<String> queryTypeStringList = new ArrayList<String>();
    private ArrayList<String> queryTypeDescriptionList = new ArrayList<String>();
    private ArrayList<Integer> startList = new ArrayList<Integer>();
    private ArrayList<Integer> endList = new ArrayList<Integer>();

    //queryType for all the queries
    public static String QUERY_TYPE_ALL = "all";
    private static String QUERY_TYPE_STRING_ALL = "All";


    public QueryInfo(){

    }

    public void addQueryTypeAll(int total){
        queryTypeList.add(QUERY_TYPE_ALL);
        queryTypeStringList.add(QUERY_TYPE_STRING_ALL);
        startList.add(new Integer(0));
        endList.add(new Integer(total));

    }

    public void addEnd(int end){
        endList.add(new Integer(end));
    }

    public void addStart(int end){
        startList.add(new Integer(end));
    }

    public void addQueryType(String queryType){
        queryTypeList.add(queryType);
    }

    public void addQueryTypeString(String queryTypeString){
        queryTypeStringList.add(queryTypeString);
    }

    public void addQueryTypeDescription(String queryTypeDescription){
        queryTypeDescriptionList.add(queryTypeDescription);
    }

    public void addQueryString(String queryString){
        queryStringList.add(queryString);
    }

    public void addQuery(String query){
        queryList.add(query);
    }

    public List<String> getQueryTypes(){
        return queryTypeList;
    }

    public List<String> getQueryStringTypes(){
        return queryTypeStringList;
    }

    public int getStart(int index){
        return startList.get(index).intValue();
    }

    public int getEnd(int index){
       return endList.get(index).intValue();
    }

    public int getIndexForQueryType(String queryType){
        for(int i=0; i<queryTypeList.size(); i ++){
          if (queryTypeList.get(i).equals(queryType))
              return i;
        }
        return -1;
    }

    public String getQueryString(int index){
        return queryStringList.get(index);
    }

    public String getQuery(int index){
        return queryList.get(index);
    }

    public List<String> getQueries(){
        return queryList;
    }

    public String getQueryType(int index){
        return queryTypeList.get(index);
    }

    public String getQueryTypeString(int index){
        return queryTypeStringList.get(index);
    }

    public String getQueryTypeDescription(int index){
        return queryTypeDescriptionList.get(index);
    }

}
