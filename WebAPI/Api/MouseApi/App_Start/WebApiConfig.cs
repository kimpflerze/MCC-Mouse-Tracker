using MouseApi.Profiles;
using System.Web.Http;

namespace MouseApi
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            AutoMapper.Mapper.Initialize(cfg => cfg.AddProfile<GenericCageProfile>());
            // Web API configuration and services

            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
        }
    }
}
