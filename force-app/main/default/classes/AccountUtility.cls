public class AccountUtility {
    public static void viewAnnualRevenue(){
        list<Account> accountsList =[select name, AnnualRevenue from Account];
        
        for(Account acc : accountsList){
            
            string acctRev= acc.Name +':'+ acc.AnnualRevenue;
            System.debug(acctRev);
            
        }
    }
}