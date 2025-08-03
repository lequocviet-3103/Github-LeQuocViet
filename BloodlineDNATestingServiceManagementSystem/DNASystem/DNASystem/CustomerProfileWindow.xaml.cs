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
    /// Interaction logic for CustomerProfileWindow.xaml
    /// </summary>
    public partial class CustomerProfileWindow : Window
    {
        public User currentUser { get; set; }
        public UserService userService = new UserService();
        public CustomerProfileWindow(User user)
        {
            InitializeComponent();
            currentUser = user;
            LoadUserInfo();
            this.WindowState = WindowState.Maximized;
        }

        private void LoadUserInfo()
        {
            txtFullName.Text = currentUser.Fullname;
            txtEmail.Text = currentUser.Email;
            txtPhone.Text = currentUser.Phone;
            txtAddress.Text = currentUser.Address;
            dtpBirthdate.SelectedDate = currentUser.Birthdate.Value.ToDateTime(TimeOnly.MinValue);
            var gender = currentUser.Gender?.Trim();
            cboGender.SelectedValue = currentUser.Gender;
        }

        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                currentUser.Fullname = txtFullName.Text.Trim();
                currentUser.Email = txtEmail.Text.Trim();
                currentUser.Phone = txtPhone.Text.Trim();
                currentUser.Address = txtAddress.Text.Trim();
                currentUser.Birthdate = DateOnly.FromDateTime(dtpBirthdate.SelectedDate.Value);
                currentUser.Gender = cboGender.SelectedValue.ToString();
                userService.UpdateUser(currentUser);

                MessageBox.Show("✅ Cập nhật thông tin thành công!", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
                LoadUserInfo();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi cập nhật: " + ex.Message);
            }
        }

        private void btnCancel_Click(object sender, RoutedEventArgs e)
        {
            HomeWindow homeWindow = new HomeWindow(currentUser);
            homeWindow.Show();
            this.Close();
        }
    }
}
