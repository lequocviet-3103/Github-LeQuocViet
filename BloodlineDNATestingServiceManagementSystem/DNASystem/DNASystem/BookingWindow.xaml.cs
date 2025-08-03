using System;
using System.Windows;
using BusinessObjects;
using Services;
using Repositories;

namespace DNASystem
{
    public partial class BookingWindow : Window
    {
        private readonly Service selectedService;
        BookingService bookingService = new BookingService();
        UserService userService = new UserService();
        User curruntuser = new User();
        InvoiceService invoiceService = new InvoiceService();
        InvoiceDetailService invoiceDetailService = new InvoiceDetailService();

        public BookingWindow(Service service, User user)
        {
            InitializeComponent();
            selectedService = service;

            this.WindowState = WindowState.Maximized;
            curruntuser = user;
            txtServiceName.Text = selectedService.Name;
            txtPrice.Text = selectedService.Price.HasValue
                ? selectedService.Price.Value.ToString("N0") + " VNĐ"
                : "Chưa có giá";
            txtDescription.Text = selectedService.Description;
            txtServiceType.Text = selectedService.Type;
            this.WindowState = WindowState.Maximized;
        }

        private void btnXacNhan_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var staffList = userService.GetAllUsers()
                               .Where(u => !string.IsNullOrEmpty(u.RoleId) && u.RoleId == "R003")
                               .ToList();

                if (staffList == null)
                {
                    MessageBox.Show("Không có nhân viên nào khả dụng để gán!", "Lỗi", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtFullName.Text) ||
                    string.IsNullOrWhiteSpace(txtPhone.Text) ||
                    dpNgayDat.SelectedDate == null ||
                    string.IsNullOrWhiteSpace(txtSampleAddress.Text))
                {
                    MessageBox.Show("Vui lòng nhập đầy đủ các thông tin bắt buộc!", "Thiếu thông tin", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }


                var random = new Random();
                var randomStaff = staffList[random.Next(staffList.Count)];


                var booking = new Booking
                {
                    BookingId = bookingService.GenerateNewBookingId(),
                    CustomerId = curruntuser.UserId,
                    Date = dpNgayDat.SelectedDate.Value,
                    StaffId = randomStaff.UserId,
                    ServiceId = selectedService.ServiceId,
                    Address = txtSampleAddress.Text.Trim(),
                    Method = rbHome.IsChecked == true ? "Tại nhà" : "Tại phòng khám",
                    Status = "Đang chờ mẫu"
                };
                bookingService.AddBooking(booking);

                var invoice = new Invoice
                {
                    InvoiceId = invoiceService.GenerateNewInvoiceId(),
                    BookingId = booking.BookingId,
                    Date = DateTime.Now,
                    Price = selectedService.Price ?? 0

                };
                invoiceService.AddInvoice(invoice);
                //chi tiet hoa don
                var invoiceDetail = new InvoiceDetail
                {
                    InvoicedetailId = invoiceDetailService.GenerateNewInvoiceDetailId(),
                    InvoiceId = invoice.InvoiceId,
                    ServiceId = selectedService.ServiceId,
                    Quantity = 1
                };
                invoiceDetailService.AddInvoiceDetail(invoiceDetail);


                InvoiceWindow invoiceWindow = new InvoiceWindow(invoiceService, invoice.InvoiceId);
                invoiceWindow.ShowDialog();

            }
            catch (Exception ex)
            {
                string error = ex.InnerException?.Message ?? ex.Message;
                MessageBox.Show("Đã xảy ra lỗi khi đặt dịch vụ: " + error, "Lỗi", MessageBoxButton.OK, MessageBoxImage.Error);

            }
        }
        private void btnQuayVe_Click(object sender, RoutedEventArgs e)
        {
            HomeWindow home = new HomeWindow(curruntuser);
            home.Show();
            this.Close();
        }

        private void Method_Checked(object sender, RoutedEventArgs e)
        {
            if (txtSampleAddress == null || curruntuser == null)
                return;

            if (rbHome.IsChecked == true)
            {
                txtSampleAddress.Text = curruntuser.Address;
                txtSampleAddress.IsReadOnly = false;
            }
            else
            {
                txtSampleAddress.Text = "273 An Dương Vương, Quận 5, TP.HCM";
                txtSampleAddress.IsReadOnly = true;
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            txtFullName.Text = curruntuser.Fullname;
            txtPhone.Text = curruntuser.Phone;
            txtEmail.Text = curruntuser.Email;
            rbHome.IsChecked = true;
            txtSampleAddress.Text = curruntuser.Address;
            dpDOB.SelectedDate = curruntuser.Birthdate.Value.ToDateTime(TimeOnly.MinValue);
        }
    }
}
