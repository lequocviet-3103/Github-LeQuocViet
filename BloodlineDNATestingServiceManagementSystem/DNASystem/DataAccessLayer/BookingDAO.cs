using BusinessObjects;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;

namespace DataAccessLayer
{
    public class BookingDAO
    {
        public List<Booking> GetAllBookings()
        {
            using var context = new DnasystemContext();
            return context.Bookings
                          .Include(b => b.Customer)
                          .Include(b => b.Staff)
                          .Include(b => b.Service)
                          .Include(b => b.Invoices)
                          .Include(b => b.Kits)
                          .Include(b => b.TestResults)
                          .OrderByDescending(b => b.Date)
                          .ToList();
        }

        public List<Booking> GetBookingsByCustomerId(string customerId)
        {
            using var context = new DnasystemContext();
            return context.Bookings
                          .Include(b => b.Service)
                          .Where(b => b.CustomerId == customerId)
                          .OrderByDescending(b => b.Date)
                          .ToList();
        }

        public Booking? GetBookingById(string bookingId)
        {
            using var context = new DnasystemContext();
            return context.Bookings
                          .Include(b => b.Customer)
                          .Include(b => b.Staff)
                          .Include(b => b.Service)
                          .Include(b => b.Invoices)
                          .Include(b => b.Kits)
                          .Include(b => b.TestResults)
                          .FirstOrDefault(b => b.BookingId == bookingId);
        }

        public void AddBooking(Booking booking)
        {
            using var context = new DnasystemContext();
            context.Bookings.Add(booking);
            context.SaveChanges();
        }

        public void UpdateBooking(Booking updatedBooking)
        {
            using var context = new DnasystemContext();
            var existing = context.Bookings.FirstOrDefault(b => b.BookingId == updatedBooking.BookingId);
            if (existing != null)
            {
                existing.CustomerId = updatedBooking.CustomerId;
                existing.StaffId = updatedBooking.StaffId;
                existing.ServiceId = updatedBooking.ServiceId;
                existing.Date = updatedBooking.Date;
                existing.Address = updatedBooking.Address;
                existing.Method = updatedBooking.Method;
                existing.Status = updatedBooking.Status;

                context.SaveChanges();
            }
        }

        public void DeleteBooking(string bookingId)
        {
            using var context = new DnasystemContext();
            var booking = context.Bookings.FirstOrDefault(b => b.BookingId == bookingId);
            if (booking != null)
            {
                context.Bookings.Remove(booking);
                context.SaveChanges();
            }
        }

        public string GenerateNewBookingId()
        {
            using var context = new DnasystemContext();

            var lastBooking = context.Bookings
                .Where(b => b.BookingId.StartsWith("BK"))
                .OrderByDescending(b => b.BookingId)
                .FirstOrDefault();

            if (lastBooking == null)
            {
                return "BK001";
            }

            var numberPart = int.TryParse(lastBooking.BookingId.Substring(2), out int number)
                ? number
                : 0;

            return "BK" + (number + 1).ToString("D3");
        }

        public void UpdateBookingStatus(string bookingId, string newStatus)
        {
            using (var context = new DnasystemContext())
            {
                var booking = context.Bookings.FirstOrDefault(b => b.BookingId == bookingId);
                if (booking != null)
                {
                    booking.Status = newStatus;
                    context.SaveChanges();
                }
            }
        }
    }
}
