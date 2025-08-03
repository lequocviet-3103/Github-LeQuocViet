using BusinessObjects;
using Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services
{
    public class InvoiceService : IInvoiceService
    {
        private IInvoiceRepository invoiceRepository;
        public InvoiceService()
        {
            invoiceRepository = new InvoiceRepository();
        }
        public List<Invoice> GetAllInvoices()
        {
            return invoiceRepository.GetAllInvoices();
        }
        public void AddInvoice(Invoice invoice)
        {
            invoiceRepository.AddInvoice(invoice);
        }
        public void UpdateInvoice(Invoice invoice)
        {
            invoiceRepository.UpdateInvoice(invoice);
        }
        public void DeleteInvoice(Invoice invoice)
        {
            invoiceRepository.DeleteInvoice(invoice);
        }

        public string GenerateNewInvoiceId()
        {
            return invoiceRepository.GenerateNewInvoiceId();
        }

        public Invoice? GetInvoiceByIdWithBooking(string invoiceId)
        {
            return invoiceRepository.GetInvoiceByIdWithBooking(invoiceId);
        }
    }
}
