using UserActivity.API.Models;

namespace UserActivity.API.Services
{
    public interface IUserActivityService
    {
        Task<UserActivityReport> GenerateReportAsync(int userId, DateTime startDate, DateTime endDate);
        Task TrackFormLoadedAsync(int userId);
        Task TrackFormSubmittedAsync(int userId);
    }
}