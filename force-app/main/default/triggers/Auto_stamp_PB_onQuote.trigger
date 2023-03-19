trigger Auto_stamp_PB_onQuote on SBQQ__Quote__c (before insert) {
list<Pricebook2> info2 = new list<Pricebook2>();
        for(SBQQ__Quote__c q :trigger.new){

    //Inserting the PB to quote on the basis of record type and currency----------------------------------------------------
        if(q.Quote_for__c!=Null && q.CurrencyIsoCode!=Null){ 
        String x=q.Quote_for__c;
        String y=q.CurrencyIsoCode; 
        //String searchString2 = '%' + y + '%';
        //String searchString1 = x+'%';

         info2=[select id,Name from Pricebook2 WHERE Type__c LIKE : x AND Currency__c LIKE: y];
    
               q.SBQQ__PriceBook__c =info2[0].id; 
            //system.debug(x);
                       // system.debug(y);
                        //system.debug(info2);


}
        }
            }