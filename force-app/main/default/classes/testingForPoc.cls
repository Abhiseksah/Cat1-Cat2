public class testingForPoc {
    public static void test(){
        Id quoteId ;
List<SBQQ__Quote__c> qList = [
        SELECT id, Name
        FROM SBQQ__Quote__c
        
        LIMIT 1
      ];
    system.debug(qlist[0]);
        system.debug(qlist[0].id);
       quoteId = qlist[0].id;
        
}
}