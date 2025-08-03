using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using BusinessObjects;
using Services;

namespace DNASystem
{
    /// <summary>
    /// Interaction logic for TestHistoryWindow.xaml
    /// </summary>
    public partial class TestHistoryWindow : Window
    {

        public User currentuser = new User();
        public BookingService bookingService = new BookingService();
        public TestResultService testResultService = new TestResultService();
        public TestHistoryWindow(User user)
        {
            InitializeComponent();
            currentuser = user;
            this.WindowState = WindowState.Maximized;
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            LoadData();
        }
        private void LoadData()
        {
            var bookings = bookingService.GetAllBookings().Where(b => b.CustomerId == currentuser.UserId)
        .ToList();

            var displayList = bookings.Select(b => new
            {
                BookingId = b.BookingId,
                Date = b.Date?.ToString("dd/MM/yyyy"),
                StaffName = b.Staff?.Fullname ?? "Chưa có",
                ServiceName = b.Service?.Name ?? "Chưa có",
                Address = b.Address,
                Method = b.Method,
                Status = b.Status,
                KitStatus = b.Kits != null && b.Kits.Any()
                    ? b.Kits.First().Status
                    : "Chưa có Kit"
            }).ToList();

            BookingListDataGrid.ItemsSource = displayList;
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            HomeWindow homeWindow = new HomeWindow(currentuser);
            homeWindow.Show();
            this.Close();
        }

        private void btnHuy_Click(object sender, RoutedEventArgs e)
        {
            var selectedItem = BookingListDataGrid.SelectedItem;
            if (selectedItem == null)
            {
                MessageBox.Show("Vui lòng chọn lịch đặt để hủy.", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            // Dùng reflection để lấy BookingId từ anonymous object
            var bookingIdProperty = selectedItem.GetType().GetProperty("BookingId");
            string bookingId = bookingIdProperty.GetValue(selectedItem)?.ToString();

            if (string.IsNullOrEmpty(bookingId))
            {
                MessageBox.Show("Không thể xác định Booking.", "Lỗi", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            MessageBoxResult result = MessageBox.Show($"Bạn có chắc muốn xóa booking '{bookingId}' không?",
                                                      "Xác nhận hủy booking",
                                                      MessageBoxButton.YesNo,
                                                      MessageBoxImage.Question);
            if (result == MessageBoxResult.Yes)
            {
                bookingService.DeleteBooking(bookingId);
                LoadData();
                MessageBox.Show("Xóa booking thành công.", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            }


        }

        private void ActionButton_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button btn && btn.Tag != null)
            {
                var bookingItem = btn.Tag;
                var props = bookingItem.GetType().GetProperties();

                string bookingId = props.FirstOrDefault(p => p.Name == "BookingId")?.GetValue(bookingItem)?.ToString();
                string action = btn.Content.ToString();

                if (string.IsNullOrEmpty(bookingId)) return;

                switch (action)
                {
                    case "Check-in":
                        bookingService.UpdateBookingStatus(bookingId, "Đã Check-in");
                        MessageBox.Show("Đã check-in thành công!");
                        break;

                    case "Đã nhận Kit":
                        bookingService.UpdateBookingStatus(bookingId, "Đã nhận Kit");
                        MessageBox.Show("Đã cập nhật trạng thái nhận Kit.");
                        break;

                    case "Gửi tới phòng khám":
                        bookingService.UpdateBookingStatus(bookingId, "Đã gửi mẫu");
                        MessageBox.Show("Mẫu đã được gửi tới phòng khám.");
                        break;

                    case "Xem kết quả":
                        ViewTestResultWindow viewTestResultWindow = new ViewTestResultWindow(currentuser, bookingId);
                        viewTestResultWindow.ShowDialog();
                        break;
                    default:
                        break;
                }

                LoadData();
            }
        }

        private void ActionButton_Loaded(object sender, RoutedEventArgs e)
        {
            if (sender is Button btn && btn.Tag != null)
            {
                var bookingItem = btn.Tag;
                var props = bookingItem.GetType().GetProperties();

                string method = props.FirstOrDefault(p => p.Name == "Method")?.GetValue(bookingItem)?.ToString();
                string status = props.FirstOrDefault(p => p.Name == "Status")?.GetValue(bookingItem)?.ToString();
                string kitStatus = props.FirstOrDefault(p => p.Name == "KitStatus")?.GetValue(bookingItem)?.ToString();

                if (method == "Tại phòng khám" && status == "Đang chờ mẫu")
                {
                    btn.Content = "Check-in";
                    btn.Visibility = Visibility.Visible;
                }
                else if (method == "Tại nhà" && status == "Đang chờ mẫu" && kitStatus == "Đang lấy mẫu")
                {
                    btn.Content = "Đã nhận Kit";
                    btn.Visibility = Visibility.Visible;
                }
                else if (method == "Tại nhà" && status == "Đã nhận Kit")
                {
                    btn.Content = "Gửi tới phòng khám";
                    btn.Visibility = Visibility.Visible;
                } else if (status=="Hoàn thành")
                {
                    btn.Content = "Xem kết quả";
                    btn.Visibility = Visibility.Visible;
                }
                else
                {
                    btn.Visibility = Visibility.Collapsed;
                }
            }

        }
    }
}
