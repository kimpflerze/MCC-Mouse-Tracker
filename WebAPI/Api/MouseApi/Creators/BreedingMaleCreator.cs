using System;

namespace MouseApi.Creators
{
    public class BreedingMaleCreator
    {
        public string Id { get; set; }
        public string MotherCageId { get; set; }
        public DateTime DOB { get; set; }
        public string CurrentCageId { get; set; }
        public int Active { get; set; }
    }
}