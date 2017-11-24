using System.Collections.Generic;

namespace MouseApi.Creators
{
    public class BreedingCageCreator
    {
        public string Id { get; set; }
        public int Row { get; set; }
        public int Column { get; set; }
        public int Rack { get; set; }
        public int Active { get; set; }
        public IEnumerable<ParentCageLookupCreator> ParentCages { get; set; }

        public GenericCageCreator GenericCage
        {
            get
            {
                return new GenericCageCreator
                {
                    Id = Id,
                    Row = Row,
                    Column = Column,
                    Rack = Rack,
                    Active = Active,
                    ParentCages = ParentCages
                };
            }
        }
    }
}