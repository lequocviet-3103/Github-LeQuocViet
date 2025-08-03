using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
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
    /// Interaction logic for HomeWindow.xaml
    /// </summary>
    public partial class HomeWindow : Window
    {
        public User currentuser { get; set; }
        public Service selectedService { get; set; }
        ContextMenu userMenu = new ContextMenu();
        private readonly IServiceService serviceService;
        public HomeWindow(User user)
        {
            InitializeComponent();
            serviceService = new ServiceService();
            this.WindowState = WindowState.Maximized;
            currentuser = user;
            txtWelcomeUser.Text = $"Welcome, " + currentuser.Fullname;


            btnHuyetThong.IsChecked = true;
            LoadServices("Huyết thống");
        }


        private void LoadServices(string type)
        {
            try
            {
                if (serviceService == null) return;

                var services = serviceService.GetServicesByType(type);

                if (services == null || !services.Any())
                {
                    // fallback: load mẫu nếu rỗng
                    icServiceList.ItemsSource = new List<Service>
            {
                new Service { Name = "Xét nghiệm cha con", Description = "Mẫu dữ liệu", Price = 123456 }
            };
                }
                else
                {
                    icServiceList.ItemsSource = services;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi LoadServices: " + ex.Message);
            }
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
            AboutUsWindow AboutUsWindow = new AboutUsWindow(currentuser);
            AboutUsWindow.Show();
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

        private void ServiceTab_Checked(object sender, RoutedEventArgs e)
        {
            var clicked = sender as ToggleButton;

            if (btnHuyetThong != null && clicked != btnHuyetThong) btnHuyetThong.IsChecked = false;
            if (btnHanhChinh != null && clicked != btnHanhChinh) btnHanhChinh.IsChecked = false;
            if (btnDanSu != null && clicked != btnDanSu) btnDanSu.IsChecked = false;

            if (clicked?.Content is string type)
            {
                LoadServices(type);
            }
        }

        private void btnDangKyTuVan_Click(object sender, RoutedEventArgs e)
        {
        }

        private void btnChiTiet_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button btn && btn.DataContext is Service selectedService)
            {
                var bookingWindow = new BookingWindow(selectedService, currentuser);
                bookingWindow.Show();
                this.Hide();
            }
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

        public class ServiceItem
        {
            public string Name { get; set; }
            public string Description { get; set; }
            public int Price { get; set; }
        }
    }
}
