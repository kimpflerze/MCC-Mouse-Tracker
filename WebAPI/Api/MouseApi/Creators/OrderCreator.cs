using System;

namespace MouseApi.Creators
{
    public class OrderCreator
    {
        public string Lab { get; set; }
        public int Protocol { get; set; }
        public string PrincipalInvestigator { get; set; }
        public int Charged = 0;
        public DateTime DeliveryDate { get; set; }
        public int MaleMice { get; set; }
        public int FemaleMice { get; set; }
        public int Gender { get; set; }
        public int MinimumAge { get; set; }
        public int MaximumAge { get; set; }
        public string Address { get; set; }
        public string Room { get; set; }
        public int Active = 1;
    }
}