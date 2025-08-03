using BusinessObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services
{
    public interface IKitService
    {
        public List<Kit> GetKits();
        public Kit GetKitById(string kitId);
        public void AddKit(Kit kit);

        public void UpdateKit(Kit kit);
        public void DeleteKit(Kit kit);
        public void UpdateKitStatus(string kitId, string newStatus);
    }
}
