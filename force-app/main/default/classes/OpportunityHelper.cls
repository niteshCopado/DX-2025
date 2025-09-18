public class OpportunityHelper {
    
    // Method to create a new Opportunity
    public static Opportunity createOpportunity(String oppName, String stage, Date closeDate, Decimal amount) {
        Opportunity opp = new Opportunity(
            Name = oppName,
            StageName = stage,
            CloseDate = closeDate,
            Amount = amount
        );
        insert opp;
        return opp;
    }

    // Method to fetch Opportunities by Stage
    public static List<Opportunity> getOpportunitiesByStage(String stage) {
        return [
            SELECT Id, Name, StageName, Amount, CloseDate
            FROM Opportunity
            WHERE StageName = :stage
            ORDER BY CloseDate ASC
        ];
    }

    // Method to update Opportunity amount
    public static void updateOpportunityAmount(Id oppId, Decimal newAmount) {
        Opportunity opp = [
            SELECT Id, Amount 
            FROM Opportunity 
            WHERE Id = :oppId
            LIMIT 1
        ];
        opp.Amount = newAmount;
        update opp;
    }
}