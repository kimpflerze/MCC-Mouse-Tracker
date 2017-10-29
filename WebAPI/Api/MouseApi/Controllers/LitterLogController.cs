using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities;
using MouseApi.Service.LitterLog;
using MouseApi.ViewModels;

namespace MouseApi.Controllers
{
    /// <summary>
    /// Controller for interacting with the Litter Log in the Database.
    /// </summary>
    public class LitterLogController : BaseController<ILitterLogService ,LitterLogCreator, LitterLogModel, LitterLogEntity>
    {
        /// <summary>
        /// Constructs a new instance of <see cref="LitterLogController"/>.
        /// </summary>
        /// <param name="service">The <see cref="ILitterLogService"/>to use.</param>
        /// <param name="mapper">The <see cref="IMapper"/>to handle mapping.</param>
        public LitterLogController(ILitterLogService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
    }
}