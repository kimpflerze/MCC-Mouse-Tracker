using System.Collections.Generic;

namespace MouseApi.Patchers
{
    public abstract class BasePatcher<TEntity> : IBasePatcher<TEntity> where TEntity : class
    {
        public abstract TEntity Patch(TEntity oldEntity, IEnumerable<KeyValuePair<string, string>> patchedProperties);
    }
}