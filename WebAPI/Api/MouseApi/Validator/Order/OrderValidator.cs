using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.Order
{
    public class OrderValidator : AbstractValidator<OrderEntity>, IOrderValidator
    {
        public OrderValidator()
        {
            RuleFor(order => order.Active).InclusiveBetween(0, 1).WithMessage($"{nameof(OrderEntity.Active)} must be either 0 or 1");
            RuleFor(order => order.Charged).InclusiveBetween(0, 1).WithMessage($"{nameof(OrderEntity.Charged)} must be either 0 or 1");

        }
    }
}