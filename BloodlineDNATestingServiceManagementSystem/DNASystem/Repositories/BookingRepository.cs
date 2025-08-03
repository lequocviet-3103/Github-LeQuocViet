using BusinessObjects;
using DataAccessLayer;
using Repositories.Interfaces;

namespace Repositories
{
    public class BookingRepository : IBookingRepository
    {
        private readonly BookingDAO dao = new BookingDAO();

        public void AddBooking(Booking booking) => dao.AddBooking(booking);

        public void DeleteBooking(string bookingId) => dao.DeleteBooking(bookingId);

        public List<Booking> GetAllBookings() => dao.GetAllBookings();

        public Booking? GetBookingById(string bookingId) => dao.GetBookingById(bookingId);

        public List<Booking> GetBookingsByCustomerId(string customerId) => dao.GetBookingsByCustomerId(customerId);

        public void UpdateBooking(Booking booking) => dao.UpdateBooking(booking);

        public string GenerateNewBookingId() => dao.GenerateNewBookingId();
        public void UpdateBookingStatus(string bookingId, string newStatus)
        {
                        dao.UpdateBookingStatus(bookingId, newStatus);
        }
    }
}
