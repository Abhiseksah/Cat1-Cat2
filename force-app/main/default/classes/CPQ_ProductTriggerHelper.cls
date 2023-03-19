public class CPQ_ProductTriggerHelper {
public static void updateDescriptionCheckbox(Map<Id,sObject> newItems,Map<Id, SObject> oldItems){
    
    List<Product2> products = new List<Product2>();
    List<SBQQ__ProductOption__c> prodOption = new List<SBQQ__ProductOption__c>();
    List<SBQQ__ProductOption__c> updatedProdOption = new List<SBQQ__ProductOption__c>();
    Map<Id,Product2> newProd = (Map<Id,Product2>) newItems; 
    Map<Id,Product2> oldProd = (Map<Id,Product2>) oldItems;

        for(Product2 prdNew : newProd.values()){
            Product2 prdOld = oldProd.get(prdNew.Id);
            if(prdNew.Description != prdOld.Description){
                products.add(prdNew);
            }
        }
        
        if(products.size()>0){
            prodOption = [select id,SBQQ__OptionalSKU__c ,SBQQ__ConfiguredSKU__c,for_update_the_option__c  
                          from SBQQ__ProductOption__c 
                          where SBQQ__OptionalSKU__c in :products 
                          OR SBQQ__ConfiguredSKU__c in :products ];
        }
        
        if(prodOption.size()>0){
            for(SBQQ__ProductOption__c prodOpt :prodOption){
                if(prodOpt.for_update_the_option__c  == false){
                    prodOpt.for_update_the_option__c = true;
                    updatedProdOption.add(prodOpt);
                    break;
                }
            }
        }
        
        if(updatedProdOption.size()>0){
            update updatedProdOption;
        }
     }           
       
    
}