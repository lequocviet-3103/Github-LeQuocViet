using BusinessObjects;

namespace Services.Interfaces
{
    public interface IBookingService
    {
        List<Booking> GetAllBookings();
        List<Booking> GetBookingsByCustomerId(string customerId);
        Booking? GetBookingById(string bookingId);
        void AddBooking(Booking booking);
        void UpdateBooking(Booking booking);
        void DeleteBooking(string bookingId);
        string GenerateNewBookingId();
        public void UpdateBookingStatus(string bookingId, string newStatus);
    }
}
