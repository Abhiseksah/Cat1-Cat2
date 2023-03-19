public class OverviewOfContractCtrl {
    
    @AuraEnabled(cacheable=true)
    public static List<Contract> getContractsRelatedToAccount(String accId) {
        system.debug('accId1 >> ' + accId);
        return [SELECT Id ,ContractNumber, Owner.Name, EndDate from Contract where Id = :accId];
    }

    @AuraEnabled(cacheable=true)
    public static List<SBQQ__Subscription__c> getSubsRelatedToAccount(String accId2) {
        system.debug('accId2 >> ' + accId2);
        return [select Id, SBQQ__Product__r.Name, SBQQ__Quantity__c, SBQQ__NetPrice__c,
        SBQQ__ListPrice__c, SBQQ__Account__r.Name, SBQQ__Account__r.Phone, SBQQ__Account__r.ShippingAdd__c,
        SBQQ__Account__r.BillingAdd__c
        from SBQQ__Subscription__c         
        where SBQQ__Contract__r.Id =: accId2];
    }
}