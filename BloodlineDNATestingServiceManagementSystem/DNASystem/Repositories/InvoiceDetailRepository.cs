using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BusinessObjects;
using DataAccessLayer;

namespace Repositories
{
    public class InvoiceDetailRepository : IInvoiceDetailRepository
    {
        private InvoiceDetailDAO invoiceDetailDAO = new InvoiceDetailDAO();

        public void AddInvoiceDetail(InvoiceDetail invoiceDetail)
        {
            invoiceDetailDAO.AddInvoiceDetail(invoiceDetail);
        }

        public void DeleteInvoiceDetail(InvoiceDetail invoiceDetail)
        {
            invoiceDetailDAO.DeleteInvoiceDetail(invoiceDetail);
        }

        public string GenerateNewInvoiceDetailId()
        {
            return invoiceDetailDAO.GenerateNewInvoiceDetailId();
        }

        public List<InvoiceDetail> GetInvoiceDetail()
        {
            return invoiceDetailDAO.GetInvoiceDetail();
        }

        public void UpdateInvoiceDetail(InvoiceDetail invoiceDetail)
        {
            invoiceDetailDAO.UpdateInvoiceDetail(invoiceDetail);
        }

    }
}
