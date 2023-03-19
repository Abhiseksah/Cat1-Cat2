public class CPQ_ProductTriggerHandler implements CPQ_ITriggerHandler{
public void AfterUpdate(Map<Id,sObject> newItems,Map<Id, SObject> oldItems) {
         
         CPQ_ProductTriggerHelper.updateDescriptionCheckbox(newItems,oldItems);
    }


	public Boolean IsDisabled(){
        return false ;
    }
    public void BeforeInsert(List<SObject> newItems){}
    public void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {}     
    public void BeforeDelete(Map<Id, SObject> oldItems) {}
    public void AfterInsert(Map<Id, SObject> newItems) {}
    public void AfterDelete(Map<Id, SObject> oldItems) {}
    public void AfterUndelete(Map<Id, SObject> oldItems) {}

}