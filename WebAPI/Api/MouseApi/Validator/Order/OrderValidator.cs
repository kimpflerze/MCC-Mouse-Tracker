using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.Order
{
    public class OrderValidator : AbstractValidator<OrderEntity>, IOrderValidator
    {
        public OrderValidator()
        {

        }
    }
}