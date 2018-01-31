using MouseApi.Entities;

namespace MouseApi.ViewModels
{
    public class AlertModel
    {
        public string AlertId { get; set; }
        public int AlertTypeId { get; set; }
        public AlertTypeEntity AlertType { get; set; }
        public string SubjectId { get; set; }
        public string AlertDate { get; set; }
    }
}