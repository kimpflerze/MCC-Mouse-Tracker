using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MouseApi.Entities
{
    public abstract class BaseEntity
    {
        public virtual string Id { get; set; }
    }
}