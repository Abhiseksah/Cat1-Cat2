trigger Supporting_the_forsortingoption_trigger on Product2 (after update) {
    if(recursive_triggerHandler.flag ){
    list<SBQQ__ProductOption__c>  obj = new list<SBQQ__ProductOption__c>();
    for(Product2 p:trigger.new){
        for(Product2 p2 :trigger.old){
            id x =p.id;
system.debug(recursive_triggerHandler.flag);
            if (p.Description != p2.Description  ){
               // recursive_triggerHandler.flag=false;
                //system.debug(recursive_triggerHandler.flag);
                obj= [select SBQQ__OptionalSKU__c,for_update_the_option__c ,SBQQ__ConfiguredSKU__c
                              from SBQQ__ProductOption__c 
                              Where SBQQ__OptionalSKU__c =:x or SBQQ__ConfiguredSKU__c =:x
                     			];
                
                                    //system.debug(obj);

                for (SBQQ__ProductOption__c obj2 :obj){
                if (obj2.for_update_the_option__c==false){
                    obj2.for_update_the_option__c =true;
                   update obj;
                    //system.debug(obj);
                    //system.debug(obj2.for_update_the_option__c);
                }
                else{
                    obj2.for_update_the_option__c =false;
                    update obj;
                    //system.debug(obj2.for_update_the_option__c);

                }
                }
                    //system.debug(obj);
                                

                
            }
        }
    }
            
        }
recursive_triggerHandler.flag=false;
}