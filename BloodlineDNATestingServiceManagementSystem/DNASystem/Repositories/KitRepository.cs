using BusinessObjects;
using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories
{
    public class KitRepository : IKitRepository
    {
        private KitDAO kitDAO = new KitDAO();
        public List<Kit> GetKits()
        {
            return kitDAO.GetKits();
        }
        public Kit GetKitById(string kitId)
        {
            return kitDAO.GetKitById(kitId);
        }
        public void AddKit(Kit kit)
        {
            kitDAO.AddKit(kit);
        }

        public void UpdateKit(Kit kit)
        {
            kitDAO.UpdateKit(kit);
        }
        public void DeleteKit(Kit kit)
        {
            kitDAO.DeleteKit(kit);
        }
        public string GenerateNewKitId()
        {
            return kitDAO.GenerateNewKitId();
        }

        public void UpdateKitStatus(string kitId, string newStatus)
        {
            kitDAO.UpdateKitStatus(kitId, newStatus);
        }
    }
}
