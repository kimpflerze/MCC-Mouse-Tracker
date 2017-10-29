using FluentValidation.Results;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Net;

namespace MouseApi.Utility
{
    public class Response<T>
    {
        public Response()
        {
            Errors = new List<string>();
        }
        public T Content { get; set; }
        [JsonIgnore]
        public ValidationResult Result { get; set; }
        [JsonIgnore]
        public HttpStatusCode StatusCode { get; set; }
        [JsonIgnore]
        public List<string> Errors { get; set; }
    }
}