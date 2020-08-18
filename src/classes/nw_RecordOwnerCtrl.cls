public without sharing class nw_RecordOwnerCtrl {
    @AuraEnabled
    public static RecordOwnerWrapper getRecordOwnerApex(String recordId, String objectType) {

        RecordOwnerWrapper wrapper = new RecordOwnerWrapper();
        try {
            String userQuery = 'SELECT Id, Owner.Name, Owner.MediumPhotoUrl FROM ' + objectType + ' WHERE Id = \'' + recordId + '\'';
            System.debug('### userQuery: ' + userQuery);
            List<sObject> sobjList = Database.query(userQuery);

            if(sobjList != NULL && sobjList.size() > 0) {
                wrapper.recordOwnerName = (String) sobjList[0].getsObject('Owner').get('Name');
                wrapper.recordOwnerImage = (String) sobjList[0].getsObject('Owner').get('MediumPhotoUrl');
            } else {
                wrapper.errorMessage = 'Record owner not found.';
            }
        } catch(Exception e) {
            wrapper.errorMessage = e.getMessage();
        }
        return wrapper;
    }

    public class RecordOwnerWrapper {
        @AuraEnabled public String recordOwnerName;
        @AuraEnabled public String recordOwnerImage;
        @AuraEnabled public String errorMessage;
    }
}