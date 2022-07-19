public class CustomePath {
	
    @AuraEnabled(cacheable=true)
    public static List<CustomPathResponseWrapper> getPath(){
        try{
            	List<CustomPathResponseWrapper> result = new List<CustomPathResponseWrapper>();
        		for(ProposalPathFlow1__c path : [select Id,Path_Name__c,Order__c,Active__c from ProposalPathFlow1__c where Active__c = true order by Order__c ASC]){
                	CustomPathResponseWrapper pathRec = new CustomPathResponseWrapper();
                	pathRec.isActive = true;
                	pathRec.order = Integer.valueOf(path.Order__c);
                	pathRec.stageName = path.Path_Name__c;
                    pathRec.pathId = path.Id;
                	result.add(pathRec);
            		
       			}
        		return result;
        	}
        	catch (Exception e){
          	  System.debug(e.getMessage());
           	  return null;
        	}
    	}
    
	}