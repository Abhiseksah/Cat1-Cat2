public class CreateFactoryQuote {
    
     public Id current_id {get; set;}
    
    public SBQQ__Quote__c quote_id { get; set; }
 
   
    
     public CreateFactoryQuote(ApexPages.StandardController controller) {
    quote_id =  (SBQQ__Quote__c) controller.getRecord();
    current_id = quote_id.Id; 
         }
    
    //@AuraEnabled
    public PageReference newQuote(){
        //getting the fields of Quote obj
        DescribeSObjectResult describeResult = current_id.getSObjectType().getDescribe(); 
		list <string> fieldsnames = new list<string>(describeResult.fields.getMap().keySet());
  //getting all data of that quote 
        string c_id = String.valueOf(current_id);
        List<SBQQ__Quote__c> oldQuote = Database.query('SELECT ' + String.join(fieldsnames, ',') + ' FROM SBQQ__Quote__c WHERE id=:c_id LIMIT 1');
  
        if(oldQuote[0].SBQQ__Status__c != 'In Review' && oldQuote[0].SBQQ__Status__c != 'Draft'){ 
                 
        //cloning  the record of quote obj -------------------------------------------
         SBQQ__Quote__c NewQuote = oldQuote[0].clone(false,false,false,false);
        //Change in the record--------------------------------------/*
        
        NewQuote.RecordTypeId='0125e000000AjdlAAC';
        NewQuote.Quote_for__c='factory';
        NewQuote.SBQQ__PricebookId__c='01s5e00000DCaCyAAL';
        NewQuote.SBQQ__PriceBook__c='01s5e00000DCaCyAAL';
        NewQuote.SBQQ__Status__c = 'Draft';
        insert NewQuote;
        
        //-----------------------------------------------------------
        //Quote is cloned now its time for QuoteLine----------------------------
        //--------------------------------------------------------------
        //1-getting the all fields of QL. 2-getting all the data of particular Id of QL. 3-and cloning it(38-59)
       	list<SBQQ__Quote__c> QuoteLineId = new list<SBQQ__Quote__c>();
         QuoteLineId = [select Quote_for__c,(select id,Name from SBQQ__LineItems__r) from SBQQ__Quote__c where id=:c_id];
                              list<string> Allid = new list<string>();

        for(SBQQ__Quote__c a : QuoteLineId){
				for(	SBQQ__QuoteLine__c test : a.SBQQ__LineItems__r){
                   				 Allid.add(test.id);
								}  
					}
        id firstidofquoteline = Allid[0];
        DescribeSObjectResult describeResult2 = firstidofquoteline.getSObjectType().getDescribe(); 
		list <string> fieldsnamesOfQuoteline = new list<string>(describeResult2.fields.getMap().keySet());
        for(Integer i=0;i<oldQuote[0].SBQQ__LineItemCount__c;i++){
            string temp =Allid[i];
            List<SBQQ__QuoteLine__c> oldQuoteLine = Database.query('SELECT ' + String.join(fieldsnamesOfQuoteline, ',') + ' FROM SBQQ__QuoteLine__c WHERE id=:temp');
            SBQQ__QuoteLine__c NewQuoteline = oldQuoteLine[0].clone(false,false,false,false);
            NewQuoteline.SBQQ__Quote__c = newQuote.id;
			insert NewQuoteline;
            
        }
        //redirecting to new created Quote-------------------------------
        PageReference pageRef = new PageReference('/'+newQuote.id );
        pageRef.setRedirect(true);
       return pageRef;
        }
        else{
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error, 'Only approved quotes can be converted to Factory quote, currently its in ->'+oldQuote[0].SBQQ__Status__c);
        ApexPages.addMessage(msg);
            return Null;
        }
    
    }
}