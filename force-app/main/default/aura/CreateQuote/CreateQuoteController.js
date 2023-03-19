({
	doInit : function(component, event, helper) {              
    var action = component.get("c.createQuoteClone");
        var newQuoteId=component.get("v.recordId");
        
        action.setParams({
            "current_id2" : newQuoteId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var NQuoteId = response.getReturnValue();
            if (NQuoteId === "In Review" || NQuoteId === "Draft" ) {
               alert('This Feature is not available for '+NQuoteId+' status of the Quote.');
                
                var urlEvent = $A.get("e.force:navigateToURL");
    urlEvent.setParams({
        "url": "/"+newQuoteId
    });

    urlEvent.fire();
            }
            else {
                //console.log("Failed with state: " + state);
                var urlEvent = $A.get("e.force:navigateToURL");
    urlEvent.setParams({
        "url": "/"+NQuoteId
    });

    urlEvent.fire();
            }
        });
        $A.enqueueAction(action);
        //====
        
    } ,
    
    
    

})