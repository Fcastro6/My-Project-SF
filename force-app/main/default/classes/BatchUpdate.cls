/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-22-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   03-22-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public class BatchUpdate implements Database.Batchable<sObject> {
    // collect the batches of records or objects to be passed to execute
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT CIF__C, IBAN__C, PHONE__C, STATUS__C, ERROR__C, ExternalIDAccount__c, ExternalIDContact__c FROM ExternalUpdate__c WHERE STATUS__C != recordStatus');
    }
    // process each batch of records
    public void execute(Database.BatchableContext bc, List<ExternalUpdate__c> scope){
        /*Validate the data is correct*/
        List<ExternalUpdate__c> validatedExternalData = new List<ExternalUpdate__c>();
        validatedExternalData = MethodsHelper.validateRecords(bc);

        /*Retrieve the internal data Account that will be update*/
        List<String> accountList = new List<String>();
        accountList = MethodsHelper.retrieveInternalAccountRecords(validatedExternalData);

        /*Retrieve the internal Account data that will be update*/
        List<String> contactList = new List<String>();
        contactList = MethodsHelper.retrieveInternalContactRecords(validatedExternalData);

        /*Map the external Account data with the internal data*/
        Map<String, Account> accountExtById = new Map<String, Account>();
        accountExtById = MethodsHelper.mapRecordAccount(accountList);

        /*Map the external Contact data with the internal data*/
        Map<String, Contact> contactExtById = new Map<String, Contact>();
        contactExtById = MethodsHelper.mapRecordContact(contactList);

        /*Update the records*/
        MethodsHelper.updateRecords(validatedExternalData, accountExtById, contactExtById);
    }
    // execute any post-processing operations
    public void finish(Database.BatchableContext bc){ 
    }
}    