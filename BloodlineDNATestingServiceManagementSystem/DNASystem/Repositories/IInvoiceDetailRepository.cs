using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BusinessObjects;

namespace Repositories
{
    public interface IInvoiceDetailRepository
    {
        public List<InvoiceDetail> GetInvoiceDetail();
        public void AddInvoiceDetail(InvoiceDetail invoiceDetail);
        public void UpdateInvoiceDetail(InvoiceDetail invoiceDetail);
        public void DeleteInvoiceDetail(InvoiceDetail invoiceDetail);
        public string GenerateNewInvoiceDetailId();
    }
}
