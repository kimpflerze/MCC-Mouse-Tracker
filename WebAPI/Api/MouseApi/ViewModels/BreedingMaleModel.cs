using System.Collections.Generic;

namespace MouseApi.ViewModels
{
    public class BreedingMaleModel
    {
        public string Id { get; set; }
        public string MotherCageId { get; set; }
        public string DOB { get; set; }
        public string CurrentCageId { get; set; }
        public int Active { get; set; }
        public ICollection<AlertModel> Alerts { get; set; }
    }
}