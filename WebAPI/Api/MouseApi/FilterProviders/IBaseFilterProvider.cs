using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MouseApi.FilterProviders
{
    public interface IBaseFilterProvider<TEntity> where TEntity : class
    {
        IEnumerable<TEntity> Filter(IEnumerable<TEntity> list, IEnumerable<KeyValuePair<string, string>> queryParams);
    }
}
