using BusinessObjects;
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
    /// Interaction logic for RegisterWindow.xaml
    /// </summary>
    public partial class RegisterWindow : Window
    {
        private readonly IUserService iUserService;
        public RegisterWindow()
        {
            InitializeComponent();
            iUserService = new UserService();
        }

        private void Register_Click(object sender, RoutedEventArgs e)
        {
            //try
            //{
                var user = new User
                {
                    Username = txtUsername.Text,
                    Password = txtPassword.Password,
                    Fullname = txtFullname.Text,

                    Email = txtEmail.Text,
                    RoleId = "R002",
                    Address = txtAddress.Text,
                    Phone = txtPhone.Text
                };
                iUserService.Register(user);
                MessageBox.Show("Đăng ký thành công!", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            //catch (Exception ex)
            //{
            //    MessageBox.Show("Đăng ký không thành công: " + ex.Message, "Thông báo", MessageBoxButton.OK, MessageBoxImage.Error);
            //    return;
            //}
        }
    }

