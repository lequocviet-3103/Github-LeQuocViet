using System;
using System.Collections.Generic;
using System.IO;
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
    /// Interaction logic for LoginWindow.xaml
    /// </summary>
    public partial class LoginWindow : Window
    {
        private readonly IUserService iUserService;
        private string rememberFile = "remember_me.txt";
        public LoginWindow()
        {
            InitializeComponent();
            iUserService = new UserService();
            this.WindowState = WindowState.Maximized;
            LoadRememberedLogin();
        }
        private void RememberLogin()
        {
            File.WriteAllText(rememberFile, $"{txtTenDangNhap.Text}|{txtPassword.Password}");
        }
        private void LoadRememberedLogin()
        {
            if (File.Exists(rememberFile))
            {
                string[] parts = File.ReadAllText(rememberFile).Split('|');
                if (parts.Length == 2)
                {
                    txtTenDangNhap.Text = parts[0];
                    txtPassword.Password = parts[1];
                    chkGhiNhoDangNhap.IsChecked = true;
                }
            }
        }

        private void ClearRememberedLogin()
        {
            if (File.Exists(rememberFile))
            {
                File.Delete(rememberFile);
            }
        }

        private void btnTrangChu_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Vui lòng đăng nhập để sử dụng chức năng này.", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            return;
        }

        private void chkGhiNhoDangNhap_Checked(object sender, RoutedEventArgs e)
        {
            RememberLogin();
        }

        private void chkGhiNhoDangNhap_Unchecked(object sender, RoutedEventArgs e)
        {
            ClearRememberedLogin();
        }

        private void btnDichVu_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Vui lòng đăng nhập để sử dụng chức năng này.", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            return;
        }

        private void btnVeChungToi_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Vui lòng đăng nhập để sử dụng chức năng này.", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            return;
        }

        private void btnBlog_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Vui lòng đăng nhập để sử dụng chức năng này.", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            return;
        }

        private void btnLienHe_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Vui lòng đăng nhập để sử dụng chức năng này.", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            return;
        }

        private void btnDangNhap_Click(object sender, RoutedEventArgs e)
        {
            User user = iUserService.GetAccountByUsername(txtTenDangNhap.Text);
            if (user != null && user.Password.Equals(txtPassword.Password) && user.RoleId.Equals("R001"))
            {

                AdminWindow adminWindow = new AdminWindow();
                adminWindow.ShowDialog();
                Close();
            }
            else if (user != null && user.Password.Equals(txtPassword.Password) && user.RoleId.Equals("R002"))
            {
                HomeWindow cusWindow = new HomeWindow(user);
                cusWindow.ShowDialog();
                Close();
            }
            else if (user != null && user.Password.Equals(txtPassword.Password) && user.RoleId.Equals("R003"))
            {
                SatffWindow staffWindow = new SatffWindow(user);
                staffWindow.ShowDialog();
                Close();
            }
            else
            {
                MessageBox.Show("Tên đăng nhập hoặc mật khẩu không đúng!", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        private void btnDangKy_Click(object sender, RoutedEventArgs e)
        {
            RegisterWindow registerWindow = new RegisterWindow();
            registerWindow.ShowDialog();
            Close();
        }

        private void btnQuenMatKhau_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Chức năng này chưa được triển khai. Xin quý khách thông cảm.", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            return;
        }

        private void btnGioiThieu_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Vui lòng đăng nhập để sử dụng chức năng này.", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            return;
        }

        private void btnTinTuc_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Vui lòng đăng nhập để sử dụng chức năng này.", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            return;
        }

        private void btnChinhSach_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Vui lòng đăng nhập để sử dụng chức năng này.", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            return;
        }
    }
}
