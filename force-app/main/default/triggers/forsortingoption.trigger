trigger forsortingoption on SBQQ__ProductOption__c (before insert,before update) {
   // SortingProductOption.program('01t5e000002f9c6AAA');
    
if(recursive_triggerHandler.optionFlag ){
    
     list<SBQQ__ProductOption__c> allOptions = new list<SBQQ__ProductOption__c>();
       // ID x='01t5e000002f9c6AAA' ;    <----EXample
       list<string>  allOptionalSKU = new list<string>();
       list<Product2>  allOptionNames = new list<Product2>();
           list<Product2>  only_forBundleprod_desc = new list<Product2>();

               list<string>  finalnames = new list<string>();
    for (SBQQ__ProductOption__c obj : trigger.new){
        string x =obj.SBQQ__ConfiguredSKU__c;
        //system.debug(x.Description);
        only_forBundleprod_desc=[select Description from Product2 where id=:x];
        //system.debug(only_forBundleprod_desc[0].Description);
        
        allOptions =[select SBQQ__OptionalSKU__c ,SBQQ__Number__c    from SBQQ__ProductOption__c WHERE SBQQ__ConfiguredSKU__c=:x ORDER BY SBQQ__Number__c   ];
    
        for (Integer i=0;i<allOptions.size();i++){
           
            allOptionalSKU.add(allOptions[i].SBQQ__OptionalSKU__c);
            //allOptionNames.add (finalnames);
                   // system.debug(allOptionNames);

        }
                           finalnames.add(only_forBundleprod_desc[0].Description);
      Integer N = allOptionalSKU.size();
        for (integer i =0;i<N;i++){
            //system.debug(allOptionalSKU.size());
                  // allOptionNames.add( string.valueOf([select Name from Product2 WHERE ID =:allOptionalSKU[i]]));
                    allOptionNames =[select Name,Description 
                                     from Product2 
                                     WHERE ID =:allOptionalSKU[i]];
                       //system.debug(allOptionNames);

          // system.debug(allOptionNames[0].Description);
            
                        finalnames.add(allOptionNames[0].Description);
                //system.debug([select Name from Product2 WHERE ID =:allOptionalSKU[i]]);
                //system.debug(finalnames);
        }
        for (integer i=0;i<finalnames.size();i++){
                       //system.debug(finalnames[i]);

           
        }
        //joining the names of the option
            //finalnames.remove(null);
            
            string allstring = string.join(finalnames,'<br/>');
        //system.debug(finalnames);
        //system.debug(allstring);
        //List<String> listVariable = new List<String>{'value1', 'value2'};
                //String separator = ', ';
                //String.join(finalnames, separator);
        
        //inserting the names in the decscripton
       
        list<Product2> prodDecs = [SELECT Description FROM Product2 WHERE ID=:x];
                //system.debug(prodDecs);
                //system.debug(finalnames);
    for (Product2 p:prodDecs){
                        p.All_product_description__c = allstring;
           // system.debug(p.All_product_description__c);
                                update p;
        
        
}       
     
        }
}
    

recursive_triggerHandler.optionFlag=false;
}