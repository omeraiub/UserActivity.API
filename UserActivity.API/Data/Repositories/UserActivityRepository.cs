using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using UserActivity.API.Models;

namespace UserActivity.API.Data.Repositories
{
    public class UserActivityRepository : IUserActivityRepository
    {
        private readonly ApplicationDbContext _context;
        public UserActivityRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<List<Activity>> GetUserActivitiesAsync(int userId, DateTime startDate, DateTime endDate)
        {
            var parameters = new[]{
                                     new SqlParameter("@UserId", userId),
                                     new SqlParameter("@StartDate", startDate),
                                     new SqlParameter("@EndDate", endDate)
                                   };
            var report = await _context.UserActivities
                .FromSqlRaw("EXEC usp_GenerateReport @UserId, @StartDate, @EndDate", parameters)
                .ToListAsync();

            return report;
        }

        public async Task InsertUserActivityAsync(int userId, string activityType)
        {
            var parameters = new[]
            {
               new SqlParameter("@UserId", userId),
              new SqlParameter("@ActivityType", activityType),
              new SqlParameter("@OccurredTime", DateTime.UtcNow)

            };
            await _context.Database.ExecuteSqlRawAsync("EXEC usp_InsertUserActivity @UserId, @ActivityType, @OccurredTime", parameters);
        }
    }
}
