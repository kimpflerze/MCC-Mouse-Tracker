using System;

namespace MouseApi.ViewModels
{
    public class ParentCageLookupModel
    {
        public string Id { get; set; }
        public string ParentCageId { get; set; }
        public string CurrentCageId { get; set; }
        public DateTime DOB { get; set; }
    }
}