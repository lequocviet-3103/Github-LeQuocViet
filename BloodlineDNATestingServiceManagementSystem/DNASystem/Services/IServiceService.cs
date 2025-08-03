using BusinessObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services
{
    public interface IServiceService
    {
        public List<Service> GetAllServices();

        public Service GetServiceById(string serviceId);
        public void AddService(Service service);
        public void UpdateService(Service service);
        public void DeleteService(Service service);
        public List<Service> GetServicesByType(string type);
    }
}
