using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BusinessObjects;

namespace DataAccessLayer
{
    public class InvoiceDetailDAO
    {
        public List<InvoiceDetail> GetInvoiceDetail()
        {
            using var context = new DnasystemContext();
            return context.InvoiceDetails.ToList();
        }
        public void AddInvoiceDetail(InvoiceDetail invoiceDetail)
        {
            using var context = new DnasystemContext();
            context.InvoiceDetails.Add(invoiceDetail);
            context.SaveChanges();
        }
        public void UpdateInvoiceDetail(InvoiceDetail invoiceDetail)
        {
            using var context = new DnasystemContext();
            context.InvoiceDetails.Update(invoiceDetail);
            context.SaveChanges();
        }
        public void DeleteInvoiceDetail(InvoiceDetail invoiceDetail)
        {
            using var context = new DnasystemContext();
            context.InvoiceDetails.Remove(invoiceDetail);
            context.SaveChanges();
        }

        public string GenerateNewInvoiceDetailId()
        {
            using var context = new DnasystemContext();

            var lastInvoiceDetail = context.InvoiceDetails
                .Where(k => k.InvoicedetailId.StartsWith("IVD"))
                .OrderByDescending(s => s.InvoicedetailId)
                .FirstOrDefault();

            if (lastInvoiceDetail == null)
            {
                return "IVD001";
            }

            var numberPart = int.Parse(lastInvoiceDetail.InvoicedetailId.Substring(3));
            return "IVD" + (numberPart + 1).ToString("D3");
        }
    }
}
