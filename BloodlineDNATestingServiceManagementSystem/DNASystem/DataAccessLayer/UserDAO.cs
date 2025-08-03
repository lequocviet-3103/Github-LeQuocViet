using BusinessObjects;
using Microsoft.EntityFrameworkCore;

namespace DataAccessLayer
{
    public class UserDAO
    {
        DnasystemContext context;
        public User GetAccountByUsername(string username)
        {
            using var context = new DnasystemContext();
            return context.Users.FirstOrDefault(u => u.Username.Equals(username));
        }
        public void Register(User user)
        {
                       using var context = new DnasystemContext();
            context.Users.Add(user);
            context.SaveChanges();
        }
        public string GenerateNewUserId()
        {
            using var context = new DnasystemContext();

            var lastUser = context.Users
                .Where(u => u.UserId.StartsWith("C"))
                .OrderByDescending(u => u.UserId)
                .FirstOrDefault();

            if (lastUser == null)
            {
                return "C001";
            }

            // Tách phần số và tăng lên
            var numberPart = int.Parse(lastUser.UserId.Substring(1));
            return "C" + (numberPart + 1).ToString("D3");
        }

        public List<User> GetAllUsers()
        {
            using var context = new DnasystemContext();
            var users = context.Users.ToList();

            foreach (var user in users)
            {
                user.RoleName = user.RoleId switch
                {
                    "R001" => "Quản trị viên",
                    "R002" => "Khách hàng",
                    "R003" => "Nhân viên",
                    _ => "Không xác định"
                };
            }

            return users;
        }

        public static bool DeleteUser(string userId)
        {
            // Ví dụ với Entity Framework
            using (var context = new DnasystemContext())
            {
                var user = context.Users.FirstOrDefault(u => u.UserId == userId);
                if (user != null)
                {
                    context.Users.Remove(user);
                    context.SaveChanges();
                    return true;
                }
                return false;
            }
        }
        public void UpdateUser(User user)
        {
            context = new DnasystemContext();
            context.Update(user);
            context.SaveChanges();
        }
    }
}
