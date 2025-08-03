using BusinessObjects;
using Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services
{
    public class KitService : IKitService
    {
        private readonly IKitRepository kitRepository;
        public KitService()
        {
            kitRepository = new KitRepository();
        }
        public List<Kit> GetKits()
        {
            return kitRepository.GetKits();
        }
        public Kit GetKitById(string kitId)
        {
            return kitRepository.GetKitById(kitId);
        }
        public void AddKit(Kit kit)
        {
            kit.KitId = kitRepository.GenerateNewKitId();
            kitRepository.AddKit(kit);
        }

        public void UpdateKit(Kit kit)
        {
            kitRepository.UpdateKit(kit);
        }
        public void DeleteKit(Kit kit)
        {
            kitRepository.DeleteKit(kit);
        }
        public void UpdateKitStatus(string kitId, string newStatus)
        {
            kitRepository.UpdateKitStatus(kitId, newStatus);
        }

    }
}
