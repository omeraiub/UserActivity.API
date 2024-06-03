using System.ComponentModel.DataAnnotations;

namespace UserActivity.API.Models
{
    public class Activity
    {
        [Key]
        public int ActivityId { get; set; }
        [Required]
        public int UserId { get; set; }
        [Required]
        [MaxLength(20)]
        public string ActivityType { get; set; }
        [Required]
        public DateTime OccurredTime { get; set; }
    }

  
}
