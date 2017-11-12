using System;

namespace MouseApi.ViewModels
{
    public class TransactionModel
    {
        public string Id { get; set; }
        public string Event { get; set; }
        public string Object { get; set; }
        public DateTime TransactionDate { get; set; }
    }
}