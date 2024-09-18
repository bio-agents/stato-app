package org.isaagents.ontoapp;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;


/**
 * Created by agbeltran on 06/06/2014.
 */
public class QueryFileReader {

    //strings related to the input file format
    private static String QUERY_TYPE_SEPARATOR = "===";
    private static String COMMENT = "#";

    /**
     *
     */
    public QueryFileReader(){

    }

    public QueryInfo readFile(String file) {
        System.out.println("In QueryFileReader.readFile("+file+")");

        QueryInfo queryInfo = new QueryInfo();

        BufferedReader br = null;

        String queryType = null, queryTypeString = null, queryTypeDescription=null;
        boolean firstString = true;

        try {
            br = new BufferedReader(new FileReader(file));

            String line = br.readLine();
            int count = 0;


            while (line != null) {

                if (line.startsWith(COMMENT) || line.equals("")){

                    line = br.readLine();
                    continue;

                } else if (line.startsWith(QUERY_TYPE_SEPARATOR)){

                    if (queryType!=null)
                        queryInfo.addEnd(count - 1);

                    queryType = line.substring(QUERY_TYPE_SEPARATOR.length(),line.indexOf(','));
                    int firstCommaIndex = line.indexOf(',');
                    int secondCommaIndex = line.indexOf(',',firstCommaIndex+1);
                    queryTypeString = line.substring(firstCommaIndex+1,secondCommaIndex);
                    if (secondCommaIndex!=-1) {
                        queryTypeDescription = line.substring(secondCommaIndex + 1);
                        queryInfo.addQueryTypeDescription(queryTypeDescription);
                    }
                    queryInfo.addQueryType(queryType);
                    queryInfo.addQueryTypeString(queryTypeString);
                    queryInfo.addStart(count);

                } else {

                    if (queryType!=null) {

                        if (firstString) {
                            queryInfo.addQueryString(line);
                            firstString = false;
                        } else {
                            queryInfo.addQuery(line);
                            firstString = true;
                            count++;
                        }

                    }
                }

                line = br.readLine();
            }

            queryInfo.addEnd(count-1);

            if (queryType!=null)
               queryInfo.addQueryTypeAll(count - 1);

            return queryInfo;

        }catch(IOException ioexception){

            ioexception.printStackTrace();

        }  finally {
            try {

                if (br!=null)
                    br.close();


            }catch(IOException ioexception){
                ioexception.printStackTrace();
            }
        }
        return null;

    }

    public static void main(String[] args) {
        String fileName = "/Users/agbeltran/workspace/stato-app/src/main/resources/queries/queries.txt";
        QueryFileReader reader = new QueryFileReader();
        QueryInfo queryInfo = reader.readFile(fileName);
        System.out.println("The end...");
    }

}
