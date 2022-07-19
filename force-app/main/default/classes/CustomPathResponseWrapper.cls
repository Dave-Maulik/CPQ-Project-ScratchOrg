public class CustomPathResponseWrapper {
    @AuraEnabled
    public Id pathId {get;set;}
    @AuraEnabled
    public string stageName {get;set;}
    @AuraEnabled
    public integer order {get;set;}
    @AuraEnabled
    public boolean isActive {get;set;}
}