using FluentValidation;
using MouseApi.Entities;

namespace MouseApi.Validator.Statistics
{
    public class StatisticsValidator : AbstractValidator<StatisticsEntity>, IStatisticsValidator
    {
    }
}