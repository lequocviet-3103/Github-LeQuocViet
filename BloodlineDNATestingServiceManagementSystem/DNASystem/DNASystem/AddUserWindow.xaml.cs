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
    /// Interaction logic for AddUserWindow.xaml
    /// </summary>
    public partial class AddUserWindow : Window
    {
        public AddUserWindow()
        {
            InitializeComponent();
            this.WindowState = WindowState.Maximized;
        }

        private string GetRoleIdFromName(string? roleName)
        {
            return roleName switch
            {
                "Quản trị viên" => "R001",
                "Khách hàng" => "R002",
                "Nhân viên" => "R003",
                _ => "R002" // mặc định là khách hàng
            };
        }

        private void BtnLuu_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtUsername.Text) ||
                string.IsNullOrWhiteSpace(txtFullname.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                MessageBox.Show("Vui lòng nhập đầy đủ thông tin bắt buộc!", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            var userService = new UserService();

            var user = new User
            {
                Username = txtUsername.Text,
                Password = "123", // hoặc nhập từ form, hoặc sinh ngẫu nhiên
                Fullname = txtFullname.Text,
                Gender = (cbGender.SelectedItem as ComboBoxItem)?.Content?.ToString(),
                RoleId = GetRoleIdFromName((cbRole.SelectedItem as ComboBoxItem)?.Content?.ToString()),
                Email = txtEmail.Text,
                Phone = txtPhone.Text,
                Birthdate = dpBirthdate.SelectedDate.HasValue
                    ? DateOnly.FromDateTime(dpBirthdate.SelectedDate.Value)
                    : (DateOnly?)null,
                Address = txtAddress.Text
            };

            try
            {
                userService.Register(user);
                MessageBox.Show("Thêm người dùng thành công!", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
                this.DialogResult = true;
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Thêm người dùng thất bại: {ex.Message}", "Lỗi", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }
}
