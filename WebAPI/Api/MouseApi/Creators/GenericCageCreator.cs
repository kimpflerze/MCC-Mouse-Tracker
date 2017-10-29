using System.Collections.Generic;

namespace MouseApi.Creators
{
    public class GenericCageCreator
    {
        public int Row { get; set; }
        public int Column { get; set; }
        public int Rack { get; set; }
        public int Active { get; set; }
        public IEnumerable<ParentCageLookupCreator> ParentCages { get; set; }
    }
}