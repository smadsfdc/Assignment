@isTest
public class TestBatchUpdateSObject {
    
    @testSetup
    static void setup(){
        
        List <Account> lstAccount = new List <Account> ();
        for(integer i= 0 ; i< 10; i++){
            Account ac = new Account(Name = 'Account'+i, Enterprise_Account_Status__c = '');
            lstAccount.add(ac);
        }
        insert lstAccount;
    }
    
    static testmethod void testScenario1() {  
        Test.startTest();
        BatchUpdateSObject myBatch = new BatchUpdateSObject('Account','Enterprise_Account_Status__c = null', 'Enterprise_Account_Status__c','Bronze');
        Id batchId = Database.executeBatch(myBatch);
        Test.stopTest();
        System.assertEquals(10, [select count() from Account where Enterprise_Account_Status__c = 'Bronze']);
    }
    
    static testmethod void testScenario2() {  
        Test.startTest();
        BatchUpdateSObject myBatch = new BatchUpdateSObject('','', '','');
        Id batchId = Database.executeBatch(myBatch);
        Test.stopTest();
    }
    
}