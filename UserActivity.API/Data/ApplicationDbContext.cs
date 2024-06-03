using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using UserActivity.API.Models;

namespace UserActivity.API.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

        public DbSet<User> Users { get; set; }
        public DbSet<Activity> UserActivities { get; set; }
    }
}
