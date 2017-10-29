using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.Service.Cages;
using MouseApi.ViewModels;

namespace MouseApi.Controllers
{
    /// <summary>
    /// Controller for interacting with Generic Cages in the Database.
    /// </summary>
    public class GenericCageController : BaseController<IGenericCageService, GenericCageCreator, GenericCageModel, GenericCageEntity>
    {
        /// <summary>
        /// Constructs a new instance of <see cref="GenericCageController"/>.
        /// </summary>
        /// <param name="service">The <see cref="IGenericCageService"/>to use.</param>
        /// <param name="mapper">The <see cref="IMapper"/>to handle mapping.</param>
        public GenericCageController(IGenericCageService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
    }
}