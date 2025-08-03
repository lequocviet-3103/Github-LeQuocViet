using BusinessObjects;
using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories
{
    public interface IKitRepository
    {
        public List<Kit> GetKits();
        public Kit GetKitById(string kitId);
        public void AddKit(Kit kit);

        public void UpdateKit(Kit kit);
        public void DeleteKit(Kit kit);
        public string GenerateNewKitId();
        public void UpdateKitStatus(string kitId, string newStatus);
    }
}
