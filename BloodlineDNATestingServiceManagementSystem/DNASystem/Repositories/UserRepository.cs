using BusinessObjects;
using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories
{
    public class UserRepository : IUserRepository
    {
        UserDAO userDAO = new UserDAO();

        
        public string GenerateNewUserId()
        {
            return userDAO.GenerateNewUserId();
        }

        public User GetAccountByUsername(string username)
        {
            return userDAO.GetAccountByUsername(username);
        }

        public List<User> GetAllUsers()
        {
           return userDAO.GetAllUsers();
        }

        public void Register(User user)
        {
            userDAO.Register(user);
        }

        public bool DeleteUser(string userId)
        {
            return UserDAO.DeleteUser(userId);
        }

        public void UpdateUser(User user)
        {
            userDAO.UpdateUser(user);
        }
    }
}
