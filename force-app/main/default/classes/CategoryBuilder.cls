public with sharing class CategoryBuilder {
     
    public static void createCategoryTree(){
        List<Map<string,Map<string,List<string>>>> categoriesByPriceList = new List<Map<string,Map<string,List<string>>>>();
        
        Map<string,Map<string,List<string>>> data = new Map<string,Map<string,List<string>>>();
        
        Map<Id,List<string>> leafList = new Map<Id,List<string>>();
        
        
        List<Apttus_Config2__PriceListCategory__c> priceListCategoryIds = [
            							 select Apttus_Config2__HierarchyId__r.Id 
                                         from Apttus_Config2__PriceListCategory__c 
                                         where Apttus_Config2__PriceListId__c = 'a3L0p000000CbeXEAS'];
        
        
        
        List<Apttus_Config2__ClassificationHierarchy__c> CategoryData = [
            select Id,Name,Apttus_Config2__AncestorId__c, Apttus_Config2__IsLeaf__c,Apttus_Config2__AncestorId__r.Name
            from Apttus_Config2__ClassificationHierarchy__c 
            where Apttus_Config2__HierarchyId__c = 'a1Q0p000000CnhBEAS'
        ];
        
        Map<Id,Id> childParent = new Map<Id,Id>();
        for(Apttus_Config2__ClassificationHierarchy__c leaf:CategoryData)
        {
            childParent.put(leaf.Id,leaf.Apttus_Config2__AncestorId__c);
            if(leaf.Apttus_Config2__IsLeaf__c == 'Yes')
            {
                if(leafList.containsKey(leaf.Apttus_Config2__AncestorId__c))
                {
                	leafList.get(leaf.Apttus_Config2__AncestorId__c).add(leaf.Name);
            	}
            	else
                {
                	leafList.put(leaf.Apttus_Config2__AncestorId__c,new List<string>{leaf.Name});
            	}
            }		
        }
        
        
        Map<Id,List<Map<Id,List<string>>>> categoryTree = new Map<Id,List<Map<Id,List<string>>>>();
        List<Id> mapKey = new List<Id>(leafList.keySet());
        
        for(integer i=0;i<mapKey.size();i++){
            Map<Id,List<string>> newMap = new Map<Id,List<string>>();
            
            if(categoryTree.containsKey(childParent.get(mapKey[i]))){
                categoryTree.get(childParent.get(mapKey[i])).add(new Map<Id,List<string>>{mapKey[i]=>leafList.get(mapKey[i])});
            }
            else{
                categoryTree.put(childParent.get(mapKey[i]),new List<Map<Id,List<string>>> {new Map<Id,List<string>>{mapKey[i]=>leafList.get(mapKey[i])}});
            }
        }
    }
}