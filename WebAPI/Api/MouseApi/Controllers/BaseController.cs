using AutoMapper;
using MouseApi.Entities;
using MouseApi.Service;
using System.Collections.Generic;
using System.Net.Http;
using System.Web.Http;

namespace MouseApi.Controllers
{
    /// <summary>
    /// Abstract Base Class for all Controllers.
    /// </summary>
    /// <typeparam name="TService">The Service used by the resource.</typeparam>
    /// <typeparam name="TCreate">The creator passed to the controller</typeparam>
    /// <typeparam name="TModel">The view model returned by the controller.</typeparam>
    /// <typeparam name="TEntity">The resource entity.</typeparam>
    public abstract class BaseController<TService, TCreate, TModel, TEntity> : ApiController where TService : IBaseService<TEntity> where TEntity: BaseEntity
    {
        protected TService _service;
        protected IMapper _mapper;

        /// <summary>
        /// GET Method. Returns an <see cref="IEnumerable{TModel}"/> 
        /// (filtered if query string parameters are provided).
        /// </summary>
        /// <returns>An <see cref="IEnumerable{TModel}"/>.</returns>
        public virtual IEnumerable<TModel> Get()
        {
            var queryParams = Request.GetQueryNameValuePairs();
            return _mapper.Map<IEnumerable<TModel>>(_service.Get(queryParams));
        }

        /// <summary>
        /// GET Method. Gets a <see cref="TModel"/> by id.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns>A <see cref="TModel"/>with the given id.</returns>
        public virtual TModel Get(string id)
        {
            return _mapper.Map<TModel>(_service.Find(id));
        }
        
        /// <summary>
        /// POST Method. Adds a new <see cref="TEntity"/> to the database.
        /// </summary>
        /// <param name="creator">The <see cref="TCreate"/>provided.</param>
        /// <returns>A <see cref="TModel"/>representing the newly added <see cref="TEntity"/>.</returns>
        public virtual TModel Post([FromBody]TCreate creator)
        {
            TEntity entity = _mapper.Map<TCreate, TEntity>(creator);
            return _mapper.Map<TModel>(_service.Add(entity));
        }

        /// <summary>
        /// PUT Method. Updates an existing record in the database.
        /// </summary>
        /// <param name="entity">The given <see cref="TEntity"/>.</param>
        /// <returns>The updated <see cref="TEntity"/>.</returns>
        public virtual TEntity Put([FromBody]TEntity entity)
        {
            return _service.Update(entity);
        }
    }
}