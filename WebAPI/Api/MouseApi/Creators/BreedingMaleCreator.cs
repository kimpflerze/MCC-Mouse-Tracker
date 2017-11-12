using System;

namespace MouseApi.Creators
{
    public class BreedingMaleCreator
    {
        public string MotherCageId { get; set; }
        public DateTime DOB { get; set; }
        public string CurrentCageId { get; set; }
        public int Active { get; set; }
    }
}