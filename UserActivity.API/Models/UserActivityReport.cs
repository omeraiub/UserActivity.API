namespace UserActivity.API.Models
{
    public class UserActivityReport
    {
        public List<Activity> Activities { get; set; }

        public UserActivityReport(List<Activity> activities)
        {
            Activities = activities;
        }
    }
}
