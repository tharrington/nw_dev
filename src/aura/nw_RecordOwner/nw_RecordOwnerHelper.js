({
	getRecordOwner : function(component, event, helper) {
		var params = { 
			recordId  : component.get('v.recordId'),
			objectType : component.get('v.objectType')
        };   

		var action = component.get("c.getRecordOwnerApex");
        action.setParams(params);
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
				var data = response.getReturnValue();
				component.set('v.recordOwner', data);
            }
        });
        $A.enqueueAction(action);
	}
})