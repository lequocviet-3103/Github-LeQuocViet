using BusinessObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class ServiceDAO
    {


        public List<Service> GetServicesByType(string type)
        {
            using var context = new DnasystemContext();
            var test = context.Services.ToList();
            return context.Services
                          .Where(s => s.Type != null && s.Type == type)
                          .OrderBy(s => s.Name)
                          .ToList();
        }
        public List<Service> GetAllServices()
        {
            using var context = new DnasystemContext();
            return context.Services.ToList();
        }

        public Service GetServiceById(string serviceId)
        {
            using var context = new DnasystemContext();
            return context.Services.FirstOrDefault(s => s.ServiceId.Equals(serviceId));
        }
        public void AddService(Service service)
        {
            using var context = new DnasystemContext();
            context.Services.Add(service);
            context.SaveChanges();
        }
        public void UpdateService(Service service)
        {
            using var context = new DnasystemContext();
            context.Services.Update(service);
            context.SaveChanges();
        }

        public void DeleteService(Service service)
        {
            using var context = new DnasystemContext();
            context.Services.Remove(service);
            context.SaveChanges();
        }

        public string GenerateNewServiceId()
        { 
            using var context = new DnasystemContext();

            var lastService = context.Services
                .Where(s => s.ServiceId.StartsWith("S"))
                .OrderByDescending(s => s.ServiceId)
                .FirstOrDefault();

            if (lastService == null)
            {
                return "S001";
            }

            // Tách phần số và tăng lên
            var numberPart = int.Parse(lastService.ServiceId.Substring(1));
            return "S" + (numberPart + 1).ToString("D3");
        }
    }
}
