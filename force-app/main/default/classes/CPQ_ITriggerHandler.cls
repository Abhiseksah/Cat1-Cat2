public interface CPQ_ITriggerHandler {
    
    /*
    * Method to handle Before Insert trigger execution
    */
    void BeforeInsert(List<SObject> newItems);
    
    /*
    * Method to handle Before Update trigger execution
    */
    void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems);
    
    /*
    * Method to handle Before Delete trigger execution
    */
    void BeforeDelete(Map<Id, SObject> oldItems);
    
    /*
    * Method to handle After Insert trigger execution
    */
    void AfterInsert(Map<Id, SObject> newItems);
    
    /*
    * Method to handle After Update trigger execution
    */
    void AfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems);
    
    /*
    * Method to handle After Delete trigger execution
    */
    void AfterDelete(Map<Id, SObject> oldItems);
    
    /*
    * Method to handle After Undelete trigger execution
    */
    void AfterUndelete(Map<Id, SObject> oldItems);
    
    /*
    * Method to check if the trigger is enable/disbaled manually
    */
    Boolean IsDisabled();
}