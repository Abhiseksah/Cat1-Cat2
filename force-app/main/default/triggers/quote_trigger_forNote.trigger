trigger quote_trigger_forNote on SBQQ__Quote__c (before insert , after insert, before update , after update) {
    
    if (trigger.isInsert){
        if (trigger.isBefore){
            quoteTriggerHandler.updateDesc(trigger.new , trigger.oldMap);
        }
        
    }
    
    if(trigger.isUpdate){
        if(trigger.isBefore){
            quoteTriggerHandler.updateDesc(trigger.new , trigger.oldMap);
        }
    }

}