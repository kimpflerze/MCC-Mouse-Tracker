using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MouseApi.Validator
{
    public class BaseValidator<TEntity> : AbstractValidator<TEntity>
    {
    }
}