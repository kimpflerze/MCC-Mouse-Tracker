using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.Service.ParentCageLookup;
using MouseApi.ViewModels;

namespace MouseApi.Controllers
{
    public class BreedingFemaleController : BaseController<IParentCageLookupService, ParentCageLookupCreator, ParentCageLookupModel, ParentCageLookupEntity>
	{
        public BreedingFemaleController(IParentCageLookupService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
	}
}