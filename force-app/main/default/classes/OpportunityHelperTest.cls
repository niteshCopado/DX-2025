@isTest
public class OpportunityHelperTest {

    @isTest
    static void testCreateOpportunity() {
        // Create a new Opportunity using the helper method
        Opportunity opp = OpportunityHelper.createOpportunity(
            'Test Opp',
            'Prospecting',
            Date.today().addDays(30),
            5000
        );

        // Assert that the Opportunity was created
        System.assertNotEquals(null, opp.Id, 'Opportunity should be inserted');
        System.assertEquals('Test Opp', opp.Name);
        System.assertEquals('Prospecting', opp.StageName);
        System.assertEquals(5000, opp.Amount);
    }

    @isTest
    static void testGetOpportunitiesByStage() {
        // Insert Opportunities
        Opportunity opp1 = new Opportunity(
            Name = 'Opp 1',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(10),
            Amount = 1000
        );
        Opportunity opp2 = new Opportunity(
            Name = 'Opp 2',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(20),
            Amount = 2000
        );
        insert new List<Opportunity>{ opp1, opp2 };

        // Fetch by stage
        List<Opportunity> result = OpportunityHelper.getOpportunitiesByStage('Prospecting');

        System.assertEquals(2, result.size(), 'Should return 2 opportunities');
        System.assertEquals('Opp 1', result[0].Name, 'Should be ordered by CloseDate');
    }

    @isTest
    static void testUpdateOpportunityAmount() {
        // Insert an Opportunity
        Opportunity opp = new Opportunity(
            Name = 'Opp Update',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(15),
            Amount = 3000
        );
        insert opp;

        // Update amount using helper
        OpportunityHelper.updateOpportunityAmount(opp.Id, 6000);

        // Query updated record
        Opportunity updatedOpp = [SELECT Amount FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals(6000, updatedOpp.Amount, 'Amount should be updated');
    }
}