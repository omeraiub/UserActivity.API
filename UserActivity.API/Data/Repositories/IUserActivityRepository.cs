
using UserActivity.API.Models;

namespace UserActivity.API.Data.Repositories
{
    public interface IUserActivityRepository
    {
        Task<List<Activity>> GetUserActivitiesAsync(int userId, DateTime startDate, DateTime endDate);
        Task InsertUserActivityAsync(int userId, string activityType);
    }
}
