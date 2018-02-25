using System;

namespace MouseApi.ViewModels
{
    public class OrderModel
    {
        public string Id { get; set; }       
        public string Lab { get; set; }        
        public int Protocol { get; set; }        
        public string PrincipalInvestigator { get; set; }        
        public string Charged { get; set; }        
        public string DeliveryDate { get; set; }       
        public int MaleMice { get; set; }      
        public int FemaleMice { get; set; }        
        public int Gender { get; set; }        
        public int MinimumAge { get; set; }        
        public int MaximumAge { get; set; }
        public string Address { get; set; }
        public string Room { get; set; }
        public int Active { get; set; }
    }
}