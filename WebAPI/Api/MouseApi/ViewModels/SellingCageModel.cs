namespace MouseApi.ViewModels
{
    public class SellingCageModel
    {
        public string Id { get; set; }
        public GenericCageModel GenericCage { get; set; }
        public int NumberOfMice { get; set; }
        public int Gender { get; set; }
        public bool MarkedForOrder { get; set; }
    }
}