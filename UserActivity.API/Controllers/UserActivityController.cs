using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using UserActivity.API.Services;

namespace UserActivity.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserActivityController : ControllerBase
    {
        private readonly IUserActivityService _userActivityService;

        public UserActivityController(IUserActivityService userActivityService)
        {
            _userActivityService = userActivityService;
        }

        [HttpPost("formloaded")]
        public async Task<IActionResult> FormLoaded(int userId)
        {
            await _userActivityService.TrackFormLoadedAsync(userId);
            return Ok();
        }

        [HttpPost("formsubmitted")]
        public async Task<IActionResult> FormSubmitted(int userId)
        {
            await _userActivityService.TrackFormSubmittedAsync(userId);
            return Ok();
        }

        [HttpGet("{userId}/report")]
        public async Task<IActionResult> GenerateReport(int userId,DateTime startDate, DateTime endDate)
        {
            var report = await _userActivityService.GenerateReportAsync(userId,startDate, endDate);
            return Ok(report);
        }
    }

}
