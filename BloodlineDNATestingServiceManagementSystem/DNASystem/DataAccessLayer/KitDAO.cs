using BusinessObjects;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class KitDAO
    {
        public List<Kit> GetKits()
        {
            using var context = new DnasystemContext();
            return context.Kits.Include(x=> x.Booking).Include(x=> x.Customer)
                .Include(x=>x.Staff).ToList();
        }

        public Kit GetKitById(string kitId)
        {
            using var context = new DnasystemContext();
            return context.Kits.FirstOrDefault(x => x.KitId == kitId);
        }
        public void AddKit(Kit kit)
        {
            using var context = new DnasystemContext();
            context.Kits.Add(kit);
            context.SaveChanges();
        }

        public void UpdateKit(Kit kit)
        {
            using var context = new DnasystemContext();
            context.Kits.Update(kit);
            context.SaveChanges();
        }

        public void UpdateKitStatus(string kitId, string newStatus)
        {
            using (var context = new DnasystemContext())
            {
                var kit = context.Kits.FirstOrDefault(k => k.BookingId == kitId);
                if (kit != null)
                {
                    kit.Status = newStatus;
                    context.SaveChanges();
                }
            }
        }
        public void DeleteKit(Kit kit)
        {
            using var context = new DnasystemContext();
            context.Kits.Remove(kit);
            context.SaveChanges();
        }

        public string GenerateNewKitId()
        {
            using var context = new DnasystemContext();

            var lastKit = context.Kits
                .Where(k => k.KitId.StartsWith("KIT"))
                .OrderByDescending(s => s.KitId)
                .FirstOrDefault();

            if (lastKit == null)
            {
                return "KIT001";
            }

            var numberPart = int.Parse(lastKit.KitId.Substring(3));
            return "KIT" + (numberPart + 1).ToString("D3");
        }

    }
}
