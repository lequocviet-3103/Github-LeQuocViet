using BusinessObjects;
using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories
{
    public class InvoiceRepository : IInvoiceRepository
    {
        private InvoiceDAO invoiceDAO = new InvoiceDAO();

        public List<Invoice> GetAllInvoices()
        {
            return invoiceDAO.GetAllInvoices();
        }
        public void AddInvoice(Invoice invoice)
        {
            invoiceDAO.AddInvoice(invoice);
        }
        public void UpdateInvoice(Invoice invoice)
        {
            invoiceDAO.UpdateInvoice(invoice);
        }
        public void DeleteInvoice(Invoice invoice)
        {
            invoiceDAO.DeleteInvoice(invoice);
        }

        public string GenerateNewInvoiceId()
        {
            return invoiceDAO.GenerateNewInvoiceId();
        }

        public Invoice? GetInvoiceByIdWithBooking(string invoiceId)
        {
            return invoiceDAO.GetInvoiceByIdWithBooking(invoiceId);
        }
    }
}
