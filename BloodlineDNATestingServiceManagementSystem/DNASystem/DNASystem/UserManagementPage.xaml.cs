using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using BusinessObjects;
using Services;

namespace DNASystem
{
    public partial class UserManagementPage : UserControl
    {
        public ObservableCollection<User> Users { get; set; } = new();
        private List<User> allUsers = new();

        public UserManagementPage()
        {
            InitializeComponent();
            DataContext = this;

            cbRole.Loaded += (s, e) =>
            {
                LoadUsers();
                ApplyRoleFilter();
                UpdateTotalUsers();
            };
            cbRole.SelectionChanged += cbRole_SelectionChanged;

        }

        private void LoadUsers()
        {
            var userService = new UserService();
            allUsers = userService.GetAllUsers();

            Users.Clear();
            foreach (var user in allUsers)
                Users.Add(user);

            // UserListView.ItemsSource = allUsers;
            UpdateTotalUsers();
        }

        private void ApplyRoleFilter()
        {
            string selectedRole = (cbRole.SelectedItem as ComboBoxItem)?.Content?.ToString() ?? "";
            IEnumerable<User> filtered = selectedRole switch
            {
                "Quản trị viên" => allUsers.Where(u => u.RoleName == "Quản trị viên"),
                "Nhân viên" => allUsers.Where(u => u.RoleName == "Nhân viên"),
                "Khách hàng" => allUsers.Where(u => u.RoleName == "Khách hàng"),
                _ => allUsers
            };

            Users.Clear();
            foreach (var user in filtered)
                Users.Add(user);

            UpdateTotalUsers();
        }


        private void BtnXoa_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.Tag is string userId)
            {
                var confirm = MessageBox.Show(
                    "Bạn có chắc muốn xóa tài khoản này?",
                    "Xác nhận",
                    MessageBoxButton.YesNo,
                    MessageBoxImage.Warning);

                if (confirm == MessageBoxResult.Yes)
                {
                    var userService = new UserService();
                    bool success = userService.DeleteUser(userId);

                    if (success)
                    {
                        LoadUsers();
                        ApplyRoleFilter();
                        MessageBox.Show("Xóa tài khoản thành công!", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
                    }
                    else
                    {
                        MessageBox.Show("Xóa tài khoản thất bại!", "Lỗi", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }
            }
        }

        private void cbRole_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ApplyRoleFilter();
        }

        private void UpdateTotalUsers()
        {
            if (UserListView != null)
            {
                txtTotalUsers.Text = (UserListView.ItemsSource as IEnumerable<User>)?.Count()
                    .ToString() ?? "0";
            }
            else
            {
                txtTotalUsers.Text = "0";
            }
        }

        private void btnThemmoi_Click(object sender, RoutedEventArgs e)
        {
            var addUserWindow = new AddUserWindow();
            if (addUserWindow.ShowDialog() == true)
            {
                LoadUsers();
                ApplyRoleFilter();
            }
        }

        private void txtSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            tbPlaceholder.Visibility = string.IsNullOrEmpty(txtSearch.Text)
        ? Visibility.Visible
        : Visibility.Collapsed;

            string keyword = txtSearch.Text.Trim().ToLower();
            string selectedRole = (cbRole.SelectedItem as ComboBoxItem)?.Content?.ToString() ?? "";

            IEnumerable<User> filtered = allUsers;

            // Search theo vai trò nếu có chọn
            // Lọc theo vai trò nếu không phải "Tất cả vai trò"
            if (selectedRole == "Quản trị viên" || selectedRole == "Nhân viên" || selectedRole == "Khách hàng")
            {
                filtered = filtered.Where(u => u.RoleName == selectedRole);
            }

            // Lọc theo từ khóa tên hoặc email
            if (!string.IsNullOrEmpty(keyword))
            {
                filtered = filtered.Where(u =>
                    (!string.IsNullOrEmpty(u.Fullname) && u.Fullname.ToLower().Contains(keyword)) ||
                    (!string.IsNullOrEmpty(u.Email) && u.Email.ToLower().Contains(keyword))
                );
            }

            Users.Clear();
            foreach (var user in filtered)
                Users.Add(user);

            UpdateTotalUsers();
        }
    }
}
