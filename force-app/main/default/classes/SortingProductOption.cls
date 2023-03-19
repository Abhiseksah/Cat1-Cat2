public class SortingProductOption {
    public static void program(string x)
    {
        list<SBQQ__ProductOption__c> allOptions = new list<SBQQ__ProductOption__c>();
       // ID x='01t5e000002f9c6AAA' ;    <----EXample
       list<string>  allOptionalSKU = new list<string>();
       list<Product2>  allOptionNames = new list<Product2>();
		       list<string>  finalnames = new list<string>();

        allOptions =[select SBQQ__OptionalSKU__c ,SBQQ__Number__c	 from SBQQ__ProductOption__c WHERE SBQQ__ConfiguredSKU__c=:x ORDER BY SBQQ__Number__c	];
        for (Integer i=0;i<allOptions.size();i++){
           
            allOptionalSKU.add(allOptions[i].SBQQ__OptionalSKU__c);
            //allOptionNames.add (finalnames);
                   // system.debug(allOptionNames);

        }
        for (integer i =0;i<allOptionalSKU.size();i++){
            
                  // allOptionNames.add( string.valueOf([select Name from Product2 WHERE ID =:allOptionalSKU[i]]));
					allOptionNames =[select Name from Product2 WHERE ID =:allOptionalSKU[i]];
            			finalnames.add(allOptionNames[0].Name);
				//system.debug([select Name from Product2 WHERE ID =:allOptionalSKU[i]]);
				system.debug(finalnames);
        }
        for (integer i=0;i<finalnames.size();i++){
                       system.debug(finalnames[i]);

           
        }
        //joining the names of the option
        	//finalnames.remove(null);
			string allstring = string.join(finalnames,',');
        system.debug(finalnames);
        system.debug(allstring);
        //List<String> listVariable = new List<String>{'value1', 'value2'};
				//String separator = ', ';
				//String.join(finalnames, separator);
        
        //inserting the names in the decscripton
        list<Product2> prodDecs = [SELECT Description FROM Product2 WHERE ID=:x];
				system.debug(prodDecs);
        		system.debug(finalnames);
        for (Product2 p:prodDecs){
            			p.All_product_description__c = allstring;
            system.debug(p.All_product_description__c);
								update prodDecs;
        }
        
        
					
    }
//change from vs code.
}