using MouseApi.Entities;
using Newtonsoft.Json;
using System;

namespace MouseApi.ViewModels
{
    public class AlertModel
    {
        public string Id { get; set; }
        public int AlertTypeId { get; set; }
        public AlertTypeEntity AlertType { get; set; }
        public string SubjectId { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public BreedingCageModel BreedingCage { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public BreedingMaleModel BreedingMale { get; set; }
        public DateTime AlertDate { get; set; }
    }
}