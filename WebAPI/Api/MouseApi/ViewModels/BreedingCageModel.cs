using System;
using System.Collections.Generic;

namespace MouseApi.ViewModels
{
    public class BreedingCageModel
    {
        public string Id { get; set; }
        public GenericCageModel GenericCage { get; set; }
        public string LitterDOB { get; set; }
        public int LittersFromCage { get; set; }
        public ICollection<AlertModel> Alerts { get; set; }
    }
}