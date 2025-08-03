using BusinessObjects;
using Repositories;
using Repositories.Interfaces;
using Services.Interfaces;

namespace Services
{
    public class BookingService : IBookingService
    {
        private readonly IBookingRepository _bookingRepository;

       public BookingService()
        {
            _bookingRepository =new BookingRepository() ;
        }

        public void AddBooking(Booking booking) => _bookingRepository.AddBooking(booking);

        public void DeleteBooking(string bookingId) => _bookingRepository.DeleteBooking(bookingId);

        public List<Booking> GetAllBookings() => _bookingRepository.GetAllBookings();

        public Booking? GetBookingById(string bookingId) => _bookingRepository.GetBookingById(bookingId);

        public List<Booking> GetBookingsByCustomerId(string customerId) => _bookingRepository.GetBookingsByCustomerId(customerId);

        public void UpdateBooking(Booking booking) => _bookingRepository.UpdateBooking(booking);

        public string GenerateNewBookingId() => _bookingRepository.GenerateNewBookingId();
        public void UpdateBookingStatus(string bookingId, string newStatus) => _bookingRepository.UpdateBookingStatus(bookingId, newStatus);
    }
}
