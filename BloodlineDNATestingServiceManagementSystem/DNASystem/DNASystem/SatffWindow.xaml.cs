using BusinessObjects;
using Repositories;
using Services;
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

namespace DNASystem
{
    /// <summary>
    /// Interaction logic for SatffWindow.xaml
    /// </summary>
    public partial class SatffWindow : Window
    {
        private readonly BookingService bookingService;
        private readonly KitService kitService;
        private readonly UserService userService;
        private readonly ServiceService serviceService;
        private readonly InvoiceService invoiceService;

        public User user { get; set; }
        public SatffWindow()
        {
            InitializeComponent();
        }

        public SatffWindow(User am)
        {
            InitializeComponent();
            user = am;
            bookingService = new BookingService();
            kitService = new KitService();
            serviceService = new ServiceService();
            userService = new UserService();
            txtWelcomeUser.Text = $"Welcome, " + user.Fullname;
            this.WindowState = WindowState.Maximized;
            invoiceService = new InvoiceService();

        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            LoadDataBooking();
        }


        private void LoadDataBooking()
        {
            var booking = bookingService.GetAllBookings();
            lvBooking.ItemsSource = null;
            lvBooking.ItemsSource = booking;
        }

        private void ActionButton_Loaded(object sender, RoutedEventArgs e)
        {
            if (sender is Button btn && btn.Tag != null)
            {
                var bookingItem = btn.Tag;
                var props = bookingItem.GetType().GetProperties();

                string method = props.FirstOrDefault(p => p.Name == "Method")?.GetValue(bookingItem)?.ToString();
                string status = props.FirstOrDefault(p => p.Name == "Status")?.GetValue(bookingItem)?.ToString();

                string kitStatus = null;

                var kitsProp = props.FirstOrDefault(p => p.Name == "Kits")?.GetValue(bookingItem) as IEnumerable<object>;
                var firstKit = kitsProp?.Cast<object>().FirstOrDefault();
                if (firstKit != null)
                {
                    var kitProps = firstKit.GetType().GetProperties();
                    kitStatus = kitProps.FirstOrDefault(p => p.Name == "Status")?.GetValue(firstKit)?.ToString();
                }

                if (method == "Tại phòng khám" && status == "Đã Check-in" && kitStatus == "Đang lấy mẫu")
                {
                    btn.Content = "Đang thực hiện";
                    btn.Visibility = Visibility.Visible;
                }
                 else if (method == "Tại nhà" && status == "Đã gửi mẫu" && kitStatus == "Đang lấy mẫu")
                 {
                    btn.Content = "Đã lấy mẫu";
                    btn.Visibility = Visibility.Visible;
                 }
                else
                {
                    btn.Visibility = Visibility.Collapsed;
                }
            }
        }



        private void btnAddKit_Click(object sender, RoutedEventArgs e)
        {
            Booking selected = lvBooking.SelectedItem as Booking;
            if (selected == null)
            {
                MessageBox.Show("Chọn khách hàng để tạo Kit!", "Tạo Kit", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                KitWindow kitWindow = new KitWindow(user);
                kitWindow.EditedOne = selected;
                kitWindow.ShowDialog();
                LoadDataBooking();
            }
        }

        private void btnAddTest_Click(object sender, RoutedEventArgs e)
        {
            Booking selected = lvBooking.SelectedItem as Booking;
            if (selected == null)
            {
                MessageBox.Show("Chọn khách hàng để tạo kết quả xét nghiệm!", "Tạo kết quả xét nghiệm", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                TestResultWindow testResult = new TestResultWindow(user);
                testResult.EditedOne = selected;
                testResult.ShowDialog();
                LoadDataBooking();
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
                    case "Đã lấy mẫu":
                        kitService.UpdateKitStatus(bookingId, "Đã lấy mẫu");
                        bookingService.UpdateBookingStatus(bookingId, "Đang thực hiện");
                        MessageBox.Show("Đã cập nhật trạng thái nhận Kit.");
                        break;
                    case "Đang thực hiện":
                        kitService.UpdateKitStatus(bookingId, "Đã lấy mẫu");
                        bookingService.UpdateBookingStatus(bookingId, "Đang thực hiện");
                        MessageBox.Show("Đã cập nhật trạng thái nhận Kit.");
                        break;

                    default:
                        break;
                }

                LoadDataBooking();
            }
        }

        private void btnViewResult_Click(object sender, RoutedEventArgs e)
        {
            Booking selected = lvBooking.SelectedItem as Booking;
            if (selected == null)
            {
                MessageBox.Show("Chọn khách hàng để xem kết quả xét nghiệm!", "Xem kết quả xét nghiệm", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else if (selected.Status != "Hoàn thành")
            {
                MessageBox.Show("Booking này chưa có kết quả!", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            else
            {
                StaffViewTestResultWindow testResult = new StaffViewTestResultWindow(user, selected);
                testResult.EditedOne = selected;
                testResult.ShowDialog();
                LoadDataBooking();
            }
        }

        private void btnUserMenu_Click(object sender, RoutedEventArgs e)
        {
            UserPopupStaff.IsOpen = true;
        }

        private void btnProfile_Click(object sender, RoutedEventArgs e)
        {
            StaffProfileWindow profileWindow = new StaffProfileWindow(user);
            profileWindow.ShowDialog();
            Close();
        }

        private void btnLogout_Click(object sender, RoutedEventArgs e)
        {
            LoginWindow loginWindow = new LoginWindow();
            loginWindow.Show();
            this.Close();
        }

        private void btnViewInvoice_Click(object sender, RoutedEventArgs e)
        {
            Booking selected = lvBooking.SelectedItem as Booking;

            if (selected == null)
            {
                MessageBox.Show("Chọn khách hàng để xem hóa đơn!", "Xem hóa đơn", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            try
            {
                // Tìm invoice tương ứng với booking đã chọn
                var invoice = invoiceService.GetAllInvoices()
                                            .FirstOrDefault(i => i.BookingId == selected.BookingId);

                if (invoice == null)
                {
                    MessageBox.Show("Không tìm thấy hóa đơn tương ứng với booking này.", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
                    return;
                }

                // Truyền InvoiceId
                var invoiceWindow = new InvoiceWindow(invoiceService, invoice.InvoiceId);
                invoiceWindow.ShowDialog();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Đã xảy ra lỗi khi xem hóa đơn: " + ex.Message, "Lỗi", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
