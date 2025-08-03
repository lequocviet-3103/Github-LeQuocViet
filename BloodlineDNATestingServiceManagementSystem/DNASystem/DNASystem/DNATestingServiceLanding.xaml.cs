using BusinessObjects;
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
    /// Interaction logic for DNATestingServiceLanding.xaml
    /// </summary>
    public partial class DNATestingServiceLanding : Window
    {
        public User currentuser { get; set; }
        public Service selectedService { get; set; }
        public DNATestingServiceLanding(User user)
        {
            InitializeComponent();
            this.WindowState = WindowState.Maximized;
            currentuser = user;
            txtWelcomeUser.Text = $"Welcome, " + currentuser.Fullname;
        }

        private void btnXetNghiemHuyetThong_Click(object sender, RoutedEventArgs e)
        {
            string message = "Xét nghiệm huyết thống:\n" +
                     "- Bố con\n" +
                     "- Mẹ con";
            MessageBox.Show(message, "Thông tin dịch vụ", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        private void btnTrangChu_Click(object sender, RoutedEventArgs e)
        {
            HomeWindow homeWindow = new HomeWindow(currentuser);
            homeWindow.Show();
            this.Close();
        }

        private void btnDichVu_Click(object sender, RoutedEventArgs e)
        {
            DNATestingServiceLanding dNATestingServiceLanding = new DNATestingServiceLanding(currentuser);
            dNATestingServiceLanding.Show();
            this.Close();
        }

        private void btnVeChungToi_Click(object sender, RoutedEventArgs e)
        {
            AboutUsWindow aboutUsWindow = new AboutUsWindow(currentuser);
            aboutUsWindow.Show();
            this.Close();
        }

        private void btnBlog_Click(object sender, RoutedEventArgs e)
        {
            BlogWindow blogWindow = new BlogWindow(currentuser);
            blogWindow.Show();
            this.Close();
        }

        private void btnLienHe_Click(object sender, RoutedEventArgs e)
        {
            ContactWindow contactWindow = new ContactWindow(currentuser);
            contactWindow.Show();
            this.Close();
        }

        private void btnDangKy_Click(object sender, RoutedEventArgs e)
        {
            BookingWindow bookingWindow = new BookingWindow(selectedService, currentuser);
            bookingWindow.Show();
            this.Close();
        }

        private void btnDatLichHen_Click(object sender, RoutedEventArgs e)
        {
            BookingWindow bookingWindow = new BookingWindow(selectedService, currentuser);
            bookingWindow.Show();
            this.Close();
        }

        private void btnTuVanMienPhi_Click(object sender, RoutedEventArgs e)
        {
            BookingWindow bookingWindow = new BookingWindow(selectedService, currentuser);
            bookingWindow.Show();
            this.Close();
        }

        private void btnXetNghiemADNHanhChinh_Click(object sender, RoutedEventArgs e)
        {
            string message = "Xét nghiệm ADN hành chính:\n" +
                     "- Hành chính – pháp lý\n" +
                     "- Di chúc – tài sản";
            MessageBox.Show(message, "Thông tin dịch vụ", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        private void btnXetNghiemADNDanSu_Click(object sender, RoutedEventArgs e)
        {
            string message = "Xét nghiệm ADN dân sự:\n" +
                     "- Truy tìm người thân\n" +
                     "- Nhận con nuôi";
            MessageBox.Show(message, "Thông tin dịch vụ", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        private void btnUserMenu_Click(object sender, RoutedEventArgs e)
        {
            UserPopup.IsOpen = true;
        }


        private void btnProfile_Click(object sender, RoutedEventArgs e)
        {
            CustomerProfileWindow profileWindow = new CustomerProfileWindow(currentuser);
            profileWindow.Show();
            this.Close();
        }

        private void btnHistory_Click(object sender, RoutedEventArgs e)
        {
            TestHistoryWindow testHistoryWindow = new TestHistoryWindow(currentuser);
            testHistoryWindow.Show();
            this.Close();
        }

        private void btnLogout_Click(object sender, RoutedEventArgs e)
        {
            LoginWindow loginWindow = new LoginWindow();
            loginWindow.Show();
            this.Close();
        }
    }
}
