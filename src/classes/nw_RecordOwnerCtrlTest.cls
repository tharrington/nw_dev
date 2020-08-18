@isTest
private class nw_RecordOwnerCtrlTest {
    @isTest static void testGetRecordOwner() {
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id,
            FirstName = 'Test',
            LastName = 'Test',
            Email = 'test@test.com',
            Username = 'test@test.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert u;

        Account acct = new Account(Name='Test Account', OwnerId=u.Id);
        insert acct;

        nw_RecordOwnerCtrl.RecordOwnerWrapper wrapper;

        Test.startTest();
        wrapper = nw_RecordOwnerCtrl.getRecordOwnerApex(acct.Id, 'Account');
        Test.stopTest();

        System.assertEquals('Test Test', wrapper.recordOwnerName); 
    }

    @isTest static void testJunkId() {
        nw_RecordOwnerCtrl.RecordOwnerWrapper wrapper;

        Test.startTest();
        wrapper = nw_RecordOwnerCtrl.getRecordOwnerApex('Junk', 'Account');
        Test.stopTest();

        System.assertEquals('invalid ID field: Junk', wrapper.errorMessage); 
    }
}