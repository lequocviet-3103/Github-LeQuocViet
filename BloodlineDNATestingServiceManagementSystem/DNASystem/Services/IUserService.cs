using BusinessObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services
{
    public interface IUserService
    {
        public User GetAccountByUsername(string username);
        public void Register(User user);

        public List<User> GetAllUsers();

        public bool DeleteUser(string userId);

        public bool AddUser(User user);
        public void UpdateUser(User user);
    }
}
