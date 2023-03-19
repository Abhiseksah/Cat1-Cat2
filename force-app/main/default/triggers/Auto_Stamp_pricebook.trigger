trigger Auto_Stamp_pricebook on SBQQ__Quote__c (before insert,before update) {
    
    list<SBQQ__QuoteLine__c> info3 = new list<SBQQ__QuoteLine__c>();
    list<SBQQ__Quote__c> info =new list<SBQQ__Quote__c>();
    list<Pricebook2> info2 = new list<Pricebook2>();

    for(SBQQ__Quote__c q :trigger.new){
         
        String x=q.Quote_for__c;
        String y=q.CurrencyIsoCode; 
        info2=[
                      select id,Name 
                      from Pricebook2 
                      WHERE Type__c = : x 
                      AND Currency__c =: y
              ];
        //system.debug(q.SBQQ__PriceBook__c);
        //system.debug(info2);
    
 //making the first Quote on oppo primary------------------------------------------------------------------------------------
            
            
            string idofOppo= q.SBQQ__Opportunity2__c;
            if(idofOppo!=Null){    //Null check for oppo Obj on Quote Obj
       // info = [select Name from SBQQ__Quote__c WHERE SBQQ__Opportunity2__c =: idofOppo];
      id pricebookOfQuote = q.SBQQ__PriceBook__c;
        List<Opportunity> oppo = [
                                    SELECT id, name,Pricebook2Id,SBQQ__PrimaryQuote__c 
                                    FROM Opportunity 
                                    WHERE id =:idofOppo
                                 ];
                
                    //System.debug(oppo[0].name);
                    //system.debug(q.SBQQ__PriceBook__c);
    
       if (oppo[0].SBQQ__PrimaryQuote__c==Null){            
            q.SBQQ__Primary__c =True;
                   // system.debug(info);
           
 //  inserting its pricebook to oppo-----------------------------------------------------------------------------------------
           for(Opportunity op: oppo){
                  op.Pricebook2Id = info2[0].id;
                }
                    //System.debug(pricebookOfQuote);
                    update oppo;
       }    
            }
  //validation alert----------------------------------------------------------------------------------
  
    /*    if(q.SBQQ__LineItemCount__c > 0){
                   system.debug('done');
                   q.validation_for_PB__c=true;
        }
      */  
     /*   q.validation_for_PB__c=false;
        
          for(SBQQ__Quote__c q2 :trigger.old){
        system.debug(q2.SBQQ__PriceBook__c);
        system.debug(q.SBQQ__PriceBook__c);
               if((q2.SBQQ__LineItemCount__c > 0) && (q2.SBQQ__PriceBook__c != q.SBQQ__PriceBook__c)){
                   system.debug('done');
                   q.validation_for_PB__c=true;
                   
              
               }
}


   */

            //system.debug(q.SBQQ__PriceBook__c);

            
        }  
    

    
    
    }