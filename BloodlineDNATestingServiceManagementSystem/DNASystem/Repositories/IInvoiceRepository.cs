using BusinessObjects;
using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories
{
    public interface IInvoiceRepository
    {
        public List<Invoice> GetAllInvoices();
        public void AddInvoice(Invoice invoice);
        public void UpdateInvoice(Invoice invoice);
        public void DeleteInvoice(Invoice invoice);
        public string GenerateNewInvoiceId();
        public Invoice? GetInvoiceByIdWithBooking(string invoiceId);
    }
}
