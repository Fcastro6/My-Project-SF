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
public with sharing class BatchUpdateSchedulable {
    global void execute(SchedulableContext SC) { 
       database.executeBatch(new BatchUpdate(),150);
   }
}
