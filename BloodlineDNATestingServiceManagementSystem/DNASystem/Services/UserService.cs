using BusinessObjects;
using DataAccessLayer;
using Repositories;

namespace Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository iUserRepository;

        

        public UserService()
        {
            this.iUserRepository = new UserRepository();
        }

        public User GetAccountByUsername(string username)
        {
            return iUserRepository.GetAccountByUsername(username);
        }

        public List<User> GetAllUsers()
        {
            return iUserRepository.GetAllUsers();
        }

        public void Register(User user)
        {
            if(GetAccountByUsername(user.Username) != null)
            {
                throw new Exception("Username already exists.");
            }
            user.UserId = iUserRepository.GenerateNewUserId(); 
            iUserRepository.Register(user);
        }

        public bool DeleteUser(string userId)
        {
            return iUserRepository.DeleteUser(userId);
        }

        public bool AddUser(User user)
        {
            if (GetAccountByUsername(user.Username) != null)
                return false; // Username đã tồn tại

            try
            {
                iUserRepository.Register(user);
                return true;
            }
            catch
            {
                return false;
            }
        }

        public void UpdateUser(User user)
        {
            iUserRepository.UpdateUser(user);
        }
    }
}
