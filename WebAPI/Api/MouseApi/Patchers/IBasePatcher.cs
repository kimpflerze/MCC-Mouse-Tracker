using System.Collections.Generic;

namespace MouseApi.Patchers
{
    public interface IBasePatcher<TEntity> where TEntity : class
    {
        TEntity Patch(TEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties);
    }
}
