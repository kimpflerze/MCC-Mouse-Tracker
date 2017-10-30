using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.Service.Breeder;
using MouseApi.ViewModels;

namespace MouseApi.Controllers
{
    /// <summary>
    /// Controller for interacting with Breeding Males in the Database.
    /// </summary>
    public class BreedingMaleController : BaseController<IBreedingMaleService, BreedingMaleCreator, BreedingMaleModel, BreedingMaleEntity>
    {
        /// <summary>
        /// Constructs a new instance of <see cref="BreedingMaleController"/>.
        /// </summary>
        /// <param name="service">The <see cref="IBreedingMaleService"/>to use.</param>
        /// <param name="mapper">The <see cref="IMapper"/>to handle mapping.</param>
        public BreedingMaleController(IBreedingMaleService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
    }
}