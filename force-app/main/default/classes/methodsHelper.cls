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
public inherited sharing class MethodsHelper {
    /*
    public List<ExternalUpdate__c> retrieveUpdateRecords(){
        String recordStatus = 'Successfull';
        String sqlStringExternalData = 'SELECT CIF__C, IBAN__C, PHONE__C, STATUS__C, ERROR__C, ExternalIDAccount__c, ExternalIDContact__c FROM ExternalUpdate__c WHERE STATUS__C != recordStatus';
        return Database.query(sqlStringExternalData);
    }Method to retrieve the external data that will be update*/  
    public List<ExternalUpdate__c> validateRecords(List<ExternalUpdate__c> externalData){
    /*    List<ExternalUpdate__c> externalData = New List<ExternalUpdate__c>();*/
        List<ExternalUpdate__c> externalDataAux = New List<ExternalUpdate__c>();
        externalData = externalData;
        for(ExternalUpdate__c ext : externalData){
            if(!REGEX(ext.CIF__C ,'([A-Z]|[a-z]){1}[0-9]{8}')){
                ext.error__c = 'The CIF should start for a letter and them 8 numbers';
                ext.status__c = 'Error';
                continue;
            }
            else{
                externalDataAux.add(ext);
                }
            if(!REGEX( ext.IBAN__c , '([ES]{2}[0-9]{20})')){
                ext.error__c = 'IBAN should start for "ES" and then 20 numbers';
                ext.status__c = 'Error';
                continue;
            }
            else{
                externalDataAux.add(ext);
                }
            if(!REGEX( ext.phone__c , '([6|7]{1}[0-9]{8})')){
                ext.error__c = 'The phone should start from 6 o 7';
                ext.status__c = 'Error';
                continue;
            }
            else{
                externalDataAux.add(ext);
                }
        }
        Update externalData;
        return externalDataAux;
    }/*Method to validate the data is correct*/

    public List<Account> retrieveInternalAccountRecords(List<ExternalUpdate__c> ext){
        List<String> accountList = new List<String>();
        for(ExternalUpdate__c eo : ext)
        {
            if(!accountList.contains(eo.ExternalIDAccount__c))
            {
                accountList.add(eo.ExternalIDAccount__c);
            }
        }
        List <Account> accountUpdate = new List<Account> ();
        accountUpdate = [SELECT Id, Name, IBAN__c, CIF__c, ExternalIdAccount__c FROM Account WHERE ExternalIdAccount__c  IN :accountList];
        return accountUpdate;
    }/*Method to retrieve the internal data Account that will be update*/

    public List<Contact> retrieveInternalContactRecords(List<ExternalUpdate__c> ext){
        List<String> contactList = new List<String>();
            for(ExternalUpdate__c eo : ext)
            {
                if(!contactList.contains(eo.ExternalIDContact__c))
                {
                    contactList.add(eo.ExternalIDContact__c);
                }
            }
            List <Contact> contactUpdate = new List<Contact> ();
            contactUpdate = [SELECT Id, Name, Phone, ExternalIDContact__c FROM Contact WHERE ExternalIDContact__c  IN :contactList];
    }/*Method to retrieve the internal Account data that will be update*/

    public Map<String, Account> mapRecordAccount(List<Account> acc){
        Map<String, Account> accountExtById = new Map<String, Account>();
            for(Account acc  : accountUpdate)
            {
                accountExtById.put(acc.ExternalIdAccount__c,acc);
            }
            return accountExtById;
    }/*Method to map the external Account data with the internal data*/

    public Map<String, Contact> mapRecordsContact(List<Contact> cont){
        Map<String, Contact> contactExtById = new Map<String, Contact>();
            for(Contact cont  : contactUpdate)
            {
                contactExtById.put(cont.ExternalIDContact__c,cont);
            }
            return contactExtById;
    }/*Method to map the external Contact data with the internal data*/

    public void updateRecords(List<ExternalUpdate__c> ext, Map<String, Account> mAcc, Map<String, Contact> mCont){
        for(ExternalUpdate__c externalUpdate : ext){
            Account acc = accountExtById.get(externalUpdate.ExternalIDAccount__c);
                acc.iban__c = externalUpdate.iban__c;
                acc.cif__c = externalUpdate.cif__c;
        
            Contact cont = contactExtById.get(external.ExternalIDContact__c);
                cont.phone = externalUpdate.phone__c;
        
        update acc;
        update cont;
        }
    }/*Method to update the records*/
}
