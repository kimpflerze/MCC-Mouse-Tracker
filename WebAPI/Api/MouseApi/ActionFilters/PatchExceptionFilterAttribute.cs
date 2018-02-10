using FluentValidation;
using MySql.Data.MySqlClient;
using System;
using System.Data.SqlClient;
using System.Net;
using System.Net.Http;
using System.Web.Http.Filters;

namespace MouseApi.ActionFilters
{
    public class PatchExceptionFilterAttribute : ExceptionFilterAttribute
    {
        public override void OnException(HttpActionExecutedContext context)
        {
            if (context.Exception is SqlException || context.Exception is MySqlException)
            {
                context.Response = context.Request.CreateResponse(HttpStatusCode.Conflict, context.Exception.Message);
            }
            if (context.Exception is ValidationException)
            {
                context.Response = context.Request.CreateResponse(HttpStatusCode.PreconditionFailed, context.Exception.Message);
            }
            if(context.Exception is NullReferenceException)
            {
                context.Response = context.Request.CreateResponse(HttpStatusCode.NotFound, "No Model Found with Given Id");
            }
        }
    }
}