using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using MouseApi.DataAccess;
using System.Data.Entity;
using MouseApi.Entities.Test;
using System.Collections;
using System.Collections.Generic;
using FluentAssertions;
using System.Linq;
using System.Data.Entity.Infrastructure;
using System;

namespace MouseApiTest.DataAccessTests
{
    [TestClass]
    public class BaseRepositoryTest
    {
        private Mock<MouseTrackDbContext> _mockDbContext;
        private Mock<DbSet<TestEntity>> _mockDbSet;
        private BaseRepository<TestEntity> _baseRepository;

        [TestInitialize]
        public void TestInit()
        {
            _mockDbContext = new Mock<MouseTrackDbContext>();          
            _mockDbSet = new Mock<DbSet<TestEntity>>();
            _mockDbSet.As<IQueryable<TestEntity>>().Setup(m => m.GetEnumerator()).Returns(SampleList.GetEnumerator());
            _mockDbContext.Setup(x => x.TestEntities).Returns(_mockDbSet.Object);
            _mockDbContext.Setup(x => x.Set<TestEntity>()).Returns(_mockDbSet.Object);
        }

        [TestMethod]
        public void Get_Positive()
        {        
            _baseRepository = new BaseRepository<TestEntity>(_mockDbContext.Object);
            var response = _baseRepository.Get();
            response.Should().NotBeNull();
        }

        [TestMethod]
        public void Find_Positive()
        {
            string keyValue = "A";
            _mockDbSet.Setup(x => x.Find(keyValue)).Returns(SampleList.Where(x => x.Id == keyValue).FirstOrDefault());
            _baseRepository = new BaseRepository<TestEntity>(_mockDbContext.Object);
            var response = _baseRepository.Find(keyValue);
            response.Should().NotBeNull();
            response.Number.Should().Equals(1);
        }

        [TestMethod]
        public void Add_Positive()
        {
            TestEntity entity = SampleList.FirstOrDefault();
            _mockDbSet.Setup(x => x.Add(entity)).Returns(entity);

            _baseRepository = new BaseRepository<TestEntity>(_mockDbContext.Object);
            var response = _baseRepository.Add(entity);

            response.Should().Equals(entity);
        }

        [TestMethod]
        [ExpectedException(typeof(DbUpdateException), "INNER")]
        public void Add_ExceptionThrown()
        {
            TestEntity entity = SampleList.FirstOrDefault();
            _mockDbSet.Setup(x => x.Add(entity)).Returns(entity);
            _mockDbContext.Setup(x => x.SaveChanges()).Throws(new Exception("OUTER", new DbUpdateException("INNER")));

            _baseRepository = new BaseRepository<TestEntity>(_mockDbContext.Object);
            var response = _baseRepository.Add(entity);
        }

        [TestMethod]
        public void Update_Positive()
        {
            TestEntity entity = SampleList.FirstOrDefault();
            _baseRepository = new BaseRepository<TestEntity>(_mockDbContext.Object);
            var response = _baseRepository.Update(entity);

            response.Should().Equals(entity);
        }

        [TestMethod]
        [ExpectedException(typeof(DbUpdateException), "INNER")]
        public void Update_ExceptionThrown()
        {
            TestEntity entity = SampleList.FirstOrDefault();
            _mockDbContext.Setup(x => x.SaveChanges()).Throws(new Exception("OUTER", new DbUpdateException("INNER")));

            _baseRepository = new BaseRepository<TestEntity>(_mockDbContext.Object);
            var response = _baseRepository.Add(entity);
        }

        private List<TestEntity> SampleList = new List<TestEntity>()
        {
            new TestEntity {Id = "A", Number = 1},
            new TestEntity {Id = "B", Number = 2}
        };
    }
}
