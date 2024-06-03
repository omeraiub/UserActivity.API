using UserActivity.API.Data.Repositories;
using UserActivity.API.Models;

namespace UserActivity.API.Services
{
    public class UserActivityService : IUserActivityService
    {
        private readonly IUserActivityRepository _repository;

        public UserActivityService(IUserActivityRepository repository)
        {
            _repository = repository;
        }

        public async Task TrackFormLoadedAsync(int userId)
        {
            await _repository.InsertUserActivityAsync(userId, activityType: "Form Loaded");
        }

        public async Task TrackFormSubmittedAsync(int userId)
        {
            await _repository.InsertUserActivityAsync(userId, activityType: "Form Submitted");
        }

        public async Task<UserActivityReport> GenerateReportAsync(int userId, DateTime startDate, DateTime endDate)
        {
            var activities = await _repository.GetUserActivitiesAsync(userId,startDate, endDate);
            return new UserActivityReport(activities);
        }
    }
}
