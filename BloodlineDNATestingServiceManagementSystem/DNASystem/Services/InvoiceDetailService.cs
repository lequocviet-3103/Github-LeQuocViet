using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BusinessObjects;
using Repositories;

namespace Services
{
    public class InvoiceDetailService : IInvoiceDetailService
    {
        private readonly IInvoiceDetailRepository invoiceDetailRepository;
        public InvoiceDetailService()
        {
            invoiceDetailRepository = new InvoiceDetailRepository();
        }

        public void AddInvoiceDetail(InvoiceDetail invoiceDetail)
        {
            invoiceDetailRepository.AddInvoiceDetail(invoiceDetail);
        }

        public void DeleteInvoiceDetail(InvoiceDetail invoiceDetail)
        {
            invoiceDetailRepository.DeleteInvoiceDetail(invoiceDetail);
        }

        public string GenerateNewInvoiceDetailId()
        {
            return invoiceDetailRepository.GenerateNewInvoiceDetailId();
        }

        public List<InvoiceDetail> GetInvoiceDetails()
        {
            return invoiceDetailRepository.GetInvoiceDetail();
        }

        public void UpdateInvoiceDetail(InvoiceDetail invoiceDetail)
        {
            invoiceDetailRepository.UpdateInvoiceDetail(invoiceDetail);
        }
    }
}
