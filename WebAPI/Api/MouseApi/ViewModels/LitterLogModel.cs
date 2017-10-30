using System;

namespace MouseApi.ViewModels
{
    public class LitterLogModel
    {
        public string Id { get; set; }
        public string MotherId { get; set; }
        public string FatherId { get; set; }
        public DateTime DOB { get; set; }
    }
}