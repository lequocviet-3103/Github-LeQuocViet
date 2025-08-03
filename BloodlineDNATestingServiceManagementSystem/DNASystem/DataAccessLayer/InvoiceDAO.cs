using BusinessObjects;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class InvoiceDAO
    {
        public List<Invoice> GetAllInvoices()
        {
            using var context = new DnasystemContext();
            return context.Invoices.ToList();
        }
        public void AddInvoice(Invoice invoice)
        {
            using var context = new DnasystemContext();
            context.Invoices.Add(invoice);
            context.SaveChanges();
        }
        public void UpdateInvoice(Invoice invoice)
        {
            using var context = new DnasystemContext();
            context.Invoices.Update(invoice);
            context.SaveChanges();
        }
        public void DeleteInvoice(Invoice invoice)
        {
            using var context = new DnasystemContext();
            context.Invoices.Remove(invoice);
            context.SaveChanges();
        }

        public string GenerateNewInvoiceId()
        {
            using var context = new DnasystemContext();

            var lastInvoice = context.Invoices
                .Where(k => k.InvoiceId.StartsWith("IV"))
                .OrderByDescending(s => s.InvoiceId)
                .FirstOrDefault();

            if (lastInvoice == null)
            {
                return "IV001";
            }

            var numberPart = int.Parse(lastInvoice.InvoiceId.Substring(2));
            return "IV" + (numberPart + 1).ToString("D3");
        }
        public Invoice? GetInvoiceByIdWithBooking(string invoiceId)
        {
            using var context = new DnasystemContext();

            return context.Invoices
                .Include(i => i.Booking)
                    .ThenInclude(b => b.Customer)
                .Include(i => i.Booking.Staff)
                .Include(i => i.Booking.Service)
                .Include(i => i.InvoiceDetails)
                .FirstOrDefault(i => i.InvoiceId == invoiceId);
        }
    }
}
