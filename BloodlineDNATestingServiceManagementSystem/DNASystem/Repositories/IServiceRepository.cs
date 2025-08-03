using BusinessObjects;
using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories
{
    public interface IServiceRepository
    {
        public List<Service> GetAllServices();

        public Service GetServiceById(string serviceId);
        public void AddService(Service service);
        public void UpdateService(Service service);
        public void DeleteService(Service service);

        public string GenerateNewServiceId();
        public List<Service> GetServicesByType(string type);
    }
}
