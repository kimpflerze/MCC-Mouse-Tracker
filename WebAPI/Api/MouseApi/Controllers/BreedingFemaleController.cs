using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.Service.ParentCageLookup;
using MouseApi.ViewModels;

namespace MouseApi.Controllers
{
    /// <summary>
    /// Controller for interacting with Parent Cage Lookups in the Database.
    /// </summary>
    public class BreedingFemaleController : BaseController<IParentCageLookupService, ParentCageLookupCreator, ParentCageLookupModel, ParentCageLookupEntity>
    {
        /// <summary>
        /// Constructs a new instance of <see cref="BreedingFemaleController"/>.
        /// </summary>
        /// <param name="service">The <see cref="IParentCageLookupService"/>to use.</param>
        /// <param name="mapper">The <see cref="IMapper"/>to handle mapping.</param>
        public BreedingFemaleController(IParentCageLookupService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
    }
}