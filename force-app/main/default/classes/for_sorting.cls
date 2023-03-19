public class for_sorting {
    
    public String showInfo {get;set;}
    public List<sbqq__productoption__c> productOption{get;set;}
    Public for_sorting(){
        productOption=new list<sbqq__productoption__c>() ;
        showInfo = (Id)ApexPages.currentPage().getParameters().get('recordId');
        productOption=[select SBQQ__Number__c,SBQQ__OptionalSKU__r.name,SBQQ__OptionalSKU__r.Description from sbqq__productoption__c where SBQQ__ConfiguredSKU__c=:showInfo order by SBQQ__Number__c ASC];
    }
    @AuraEnabled
    Public static list<wrapperClass> productoptions(string showInfo){
        list<sbqq__productoption__c> productOptions=new list<sbqq__productoption__c>() ;
        product2 p=[select name,Description from product2 where id=:showInfo];
        productOptions=[select SBQQ__Number__c,SBQQ__OptionalSKU__r.name,SBQQ__OptionalSKU__r.Description from sbqq__productoption__c where SBQQ__ConfiguredSKU__c=:showInfo order by SBQQ__Number__c ASC];
        list<wrapperClass> objDT=new  list<wrapperClass>();
        //p.CPQ_Product_Long_Description__c=p.CPQ_Product_Long_Description__c.stripHtmlTags();
        objDT.add(new wrapperClass(p,productOptions));
        system.debug('objDT'+objDT);
        return objDT;
    }
   public class wrapperClass{
      @AuraEnabled public Product2 product{get;set;}
      @AuraEnabled public List<SBQQ__ProductOption__c> optionlist {get;set;} 
       public wrapperClass(Product2 bundleproduct,  List<SBQQ__ProductOption__c> options){
        this.product= bundleproduct;
        this.optionlist = options;           
       }
   }
}