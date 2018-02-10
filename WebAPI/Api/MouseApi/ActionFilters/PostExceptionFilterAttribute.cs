using FluentValidation;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http.Filters;

namespace MouseApi.ActionFilters
{
    public class PostExceptionFilterAttribute : ExceptionFilterAttribute
    {
        public override void OnException(HttpActionExecutedContext context)
        {
            if(context.Exception is SqlException || context.Exception is MySqlException)
            {
                context.Response = context.Request.CreateResponse(HttpStatusCode.Conflict, context.Exception.Message);
            }
            if(context.Exception is ValidationException)
            {
                context.Response = context.Request.CreateResponse(HttpStatusCode.PreconditionFailed, context.Exception.Message);
            }
        }
    }
}