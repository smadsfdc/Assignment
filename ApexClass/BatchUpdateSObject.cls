/**
Author : Sandeep Maddina

Version : Date       Change
          5/20/2020  Initial Version
          
**/

global class BatchUpdateSObject implements Database.Batchable<SObject>{

    public string sObj;
    public string filterCriteria;
    public string fieldToUpdate;
    public string fieldValueToUpdate;
    public string query;
    
    /**
    Method Parameters:    
    sObjct         : Valid sOject name
    filCrit        : To pass the filter criteria in the SOQL query
    filToUpdate    : API value of Field Name to update
    filValToUpdate : Field Value to update with
    **/
    public batchUpdateSObject(String sObjct, String filCrit, string filToUpdate, string filValToUpdate){
        sObj = sObjct;
        filterCriteria = filCrit;
        fieldToUpdate = filToUpdate;
        fieldValueToUpdate = filValToUpdate;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        if(sObj != null && sObj != ''){
            query = 'SELECT ID FROM ' + sObj ;
            if(filterCriteria != null && filterCriteria != '') query = query + ' WHERE ' + filterCriteria;
            return Database.getQueryLocator(query);
        }
        else 
            return Database.getQueryLocator([SELECT Id FROM Account LIMIT 0]);
    }
    
    global void execute (Database.BatchableContext bc, List <SObject> scope){
        List <SObject> lstSObj = new List <SObject> ();
        if(fieldToUpdate != null && fieldToUpdate != ''){
            for(SObject so: scope){
                so.put(fieldToUpdate, fieldValueToUpdate);
                lstSObj.add(so);
            }
        }
        if(!lstSObj.isEmpty() && lstSObj.size() > 0) update lstSObj;
    }
    
    global void finish(Database.BatchableContext bc){
    }
    
}