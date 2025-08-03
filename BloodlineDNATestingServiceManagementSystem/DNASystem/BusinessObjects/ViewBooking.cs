using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects
{
    public class ViewBooking
    {
        public string BookingId { get; set; } = null!;
        public string? Fullname { get; set; }
        public string? ServiceName { get; set; }
        public DateTime? Date { get; set; }

        public string? Address { get; set; }

        public string? Method { get; set; }

        public string? Status { get; set; }
        public string? KitStatus { get; set; }
    }
}
