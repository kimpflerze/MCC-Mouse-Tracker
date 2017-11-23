using AutoMapper;
using MouseApi.Creators;
using MouseApi.Entities.Transaction;
using MouseApi.Service.Transaction;
using MouseApi.ViewModels;

namespace MouseApi.Controllers
{
    public class TransactionController : BaseController<ITransactionService, TransactionCreator, TransactionModel, TransactionEntity>
    {
        public TransactionController(ITransactionService service, IMapper mapper)
        {
            _service = service;
            _mapper = mapper;
        }
    }
}