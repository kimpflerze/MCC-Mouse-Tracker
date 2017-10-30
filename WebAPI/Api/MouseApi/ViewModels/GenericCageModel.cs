using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MouseApi.ViewModels
{
    public class GenericCageModel
    {
        public string Id { get; set; }
        public DateTime Created { get; set; }
        public int Row { get; set; }
        public int Column { get; set; }
        public int Rack { get; set; }
        public int Active { get; set; }

        public ICollection<ParentCageLookupModel> ParentCages { get; set; }
    }
}