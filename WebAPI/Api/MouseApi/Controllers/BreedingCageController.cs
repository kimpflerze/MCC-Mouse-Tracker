using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.Service.Cages;
using MouseApi.ViewModels;

namespace MouseApi.Controllers
{
    /// <summary>
    /// Controller for interacting with Breeding Cages in the Database.
    /// </summary>
    public class BreedingCageController : BaseController<IBreedingCageService, BreedingCageCreator, BreedingCageModel, BreedingCageEntity>
    {
        /// <summary>
        /// Constructs a new instance of <see cref="BreedingCageController"/>.
        /// </summary>
        /// <param name="service">The <see cref="IBreedingCageService"/>to use.</param>
        /// <param name="mapper">The <see cref="IMapper"/>to handle mapping.</param>
        public BreedingCageController(IBreedingCageService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
    }
}