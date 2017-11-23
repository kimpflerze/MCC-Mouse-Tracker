using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MouseApi.Validator.Cages;
using MouseApi.Entities;
using FluentAssertions;
using System.Linq;

namespace MouseApiTest.ValidatorTests
{
    [TestClass]
    public class BreedingCageValidatorTest
    {
        private BreedingCageValidator _validator;
        private BreedingCageEntity _entity;

        [TestInitialize]
        public void TestInit()
        {
            _validator = new BreedingCageValidator();
            _entity = new BreedingCageEntity()
            {
                Id = "TEST ID",
                LitterDOB = DateTime.Now,
                LittersFromCage = 0,
                GenericCage = new GenericCageEntity()
                {
                    Id = "TEST ID",
                    Row = 1,
                    Column = 1,
                    Rack = 1,
                    Active = 1,
                    Created = DateTime.Now
                }
            };
        }

        [TestMethod]
        public void Validate_BreedingCage_Positive()
        {
            var results = _validator.Validate(_entity);
            results.IsValid.Should().BeTrue();
            results.Errors.Count.Should().Be(0);
        }

        [TestMethod]
        public void Validate_BreedingCage_NullId()
        {
            _entity.Id = null;
            var result = _validator.Validate(_entity);
            result.IsValid.Should().BeFalse();
            result.Errors.Count.Should().Be(1);
            result.Errors.First().ErrorMessage.Should().Contain($"Missing property: {nameof(BreedingCageEntity.Id)}");
        }

        [TestMethod]
        public void Validate_BreedingCage_InvalidRow()
        {
            _entity.GenericCage.Row = 0;
            var result = _validator.Validate(_entity);
            result.IsValid.Should().BeFalse();
            result.Errors.Count.Should().Be(1);
            result.Errors.First().ErrorMessage.Should().Contain($"Invalid Row Number");
        }

        [TestMethod]
        public void Validate_BreedingCage_InvalidColumn()
        {
            _entity.GenericCage.Column = 0;
            var result = _validator.Validate(_entity);
            result.IsValid.Should().BeFalse();
            result.Errors.Count.Should().Be(1);
            result.Errors.First().ErrorMessage.Should().Contain($"Invalid Column Number");
        }

        [TestMethod]
        public void Validate_BreedingCage_InvalidRack()
        {
            _entity.GenericCage.Rack = 0;
            var result = _validator.Validate(_entity);
            result.IsValid.Should().BeFalse();
            result.Errors.Count.Should().Be(1);
            result.Errors.First().ErrorMessage.Should().Contain($"Invalid Rack Number");
        }

        [TestMethod]
        public void Validate_BreedingCage_InvalidActive()
        {
            _entity.GenericCage.Active = 2;
            var result = _validator.Validate(_entity);
            result.IsValid.Should().BeFalse();
            result.Errors.Count.Should().Be(1);
            result.Errors.First().ErrorMessage.Should().Contain("Active must be set to either 0 (inactive) or 1 (active)");
        }
    }
}
