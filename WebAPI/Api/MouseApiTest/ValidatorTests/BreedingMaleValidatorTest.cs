using FluentAssertions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MouseApi.Entities;
using MouseApi.Validator.Breeder;
using System;
using System.Linq;

namespace MouseApiTest.ValidatorTests
{
    [TestClass]
    public class BreedingMaleValidatorTest
    {
        private BreedingMaleValidator _validator;
        private BreedingMaleEntity _entity;

        [TestInitialize]
        public void TestInit()
        {
            _validator = new BreedingMaleValidator();
            _entity = new BreedingMaleEntity()
            {
                Id = "ID",
                MotherCageId = "MOTHERID",
                CurrentCageId = "CURRENTID",
                DOB = DateTime.Now,
                Active = 0
            };
        }

        [TestMethod]
        public void Validate_BreedingMale_Positive()
        {
            var results = _validator.Validate(_entity);
            results.IsValid.Should().BeTrue();
            results.Errors.Count.Should().Be(0);
        }

        [TestMethod]
        public void Validate_BreedingMale_NullId()
        {
            _entity.Id = null;

            var results = _validator.Validate(_entity);
            results.IsValid.Should().BeFalse();
            results.Errors.Count.Should().Be(1);
            results.Errors.First().ErrorMessage.Should().Contain($"Missing property: {nameof(BreedingMaleEntity.Id)}");
        }

        [TestMethod]
        public void Validate_BreedingMale_NullMotherId()
        {
            _entity.MotherCageId = null;

            var results = _validator.Validate(_entity);
            results.IsValid.Should().BeFalse();
            results.Errors.Count.Should().Be(1);
            results.Errors.First().ErrorMessage.Should().Contain($"Missing property: {nameof(BreedingMaleEntity.MotherCageId)}");
        }

        [TestMethod]
        public void Validate_BreedingMale_NullCurrentCageId()
        {
            _entity.CurrentCageId = null;

            var results = _validator.Validate(_entity);
            results.IsValid.Should().BeFalse();
            results.Errors.Count.Should().Be(1);
            results.Errors.First().ErrorMessage.Should().Contain($"Missing property: {nameof(BreedingMaleEntity.CurrentCageId)}");
        }

        [TestMethod]
        public void Validate_BreedingMale_InvalidActive()
        {
            _entity.Active = 2;

            var results = _validator.Validate(_entity);
            results.IsValid.Should().BeFalse();
            results.Errors.Count.Should().Be(1);
            results.Errors.First().ErrorMessage.Should().Contain("Active must be set to either 0 (inactive) or 1 (active)");
        }
    }
}
