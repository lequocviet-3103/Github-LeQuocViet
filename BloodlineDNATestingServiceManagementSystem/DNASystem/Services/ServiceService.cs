using BusinessObjects;
using Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services
{
    public class ServiceService : IServiceService
    {
        private readonly IServiceRepository iServiceRepository;
        public ServiceService()
        {
            iServiceRepository = new ServiceRepository();
        }

        public void AddService(Service service)
        {
            service.ServiceId = iServiceRepository.GenerateNewServiceId();

            iServiceRepository.AddService(service);
        }

        public void DeleteService(Service service)
        {
            iServiceRepository.DeleteService(service);
        }

        public List<Service> GetAllServices()
        {
            return iServiceRepository.GetAllServices();
        }

        public Service GetServiceById(string serviceId)
        {
            return iServiceRepository.GetServiceById(serviceId);
        }

        public void UpdateService(Service service)
        {
            iServiceRepository.UpdateService(service);
        }

        public List<Service> GetServicesByType(string type)
        {
            return iServiceRepository.GetServicesByType(type);
        }
    }
}
