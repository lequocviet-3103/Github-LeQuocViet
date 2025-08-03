using BusinessObjects;
using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories
{
    public class ServiceRepository : IServiceRepository
    {
        ServiceDAO serviceDAO = new ServiceDAO();
        public void AddService(Service service)
        {
            serviceDAO.AddService(service);
        }

        public List<Service> GetServicesByType(string type)
        {
            return serviceDAO.GetServicesByType(type);
        }
        public void DeleteService(Service service)
        {
            serviceDAO.DeleteService(service);
        }

        public string GenerateNewServiceId()
        {
            return serviceDAO.GenerateNewServiceId();
        }

        public List<Service> GetAllServices()
        {
            return serviceDAO.GetAllServices();
        }

        public Service GetServiceById(string serviceId)
        {
            return serviceDAO.GetServiceById(serviceId);
        }

        public void UpdateService(Service service)
        {
            serviceDAO.UpdateService(service);
        }
    }
}
