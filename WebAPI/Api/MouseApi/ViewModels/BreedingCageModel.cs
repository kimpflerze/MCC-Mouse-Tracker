using System;
using System.Collections.Generic;

namespace MouseApi.ViewModels
{
    public class BreedingCageModel
    {
        public string Id { get; set; }
        public GenericCageModel GenericCage { get; set; }
        public DateTime? LitterDOB { get; set; }
        public int LittersFromCage { get; set; }
        
    }
}