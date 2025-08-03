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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace DNASystem
{
    /// <summary>
    /// Interaction logic for AdminHomePage.xaml
    /// </summary>
    public partial class AdminHomePage : UserControl
    {
        public AdminHomePage()
        {
            InitializeComponent();
            MainContent.Content = new TextBlock
            {
                Text = "Welcome to the Admin Home Page",
                FontSize = 24,
                HorizontalAlignment = HorizontalAlignment.Center,
                VerticalAlignment = VerticalAlignment.Center
            };

        }

        private void UserManagement_Click(object sender, RoutedEventArgs e)
        {
            MainContent.Content = new UserManagementPage();
        }

        private void Home_Click(object sender, RoutedEventArgs e)
        {

        }

        private void Profile_Click(object sender, RoutedEventArgs e)
        {

        }

        private void Dashboard_Click(object sender, RoutedEventArgs e)
        {
            MainContent.Content = new DashboardPage();
        }

        private void Logout_Click(object sender, RoutedEventArgs e)
        {
            // Tìm cửa sổ cha chứa AdminHomePage
            Window parentWindow = Window.GetWindow(this);
            if (parentWindow != null)
            {
                // Mở lại cửa sổ đăng nhập
                var loginWindow = new LoginWindow();
                loginWindow.Show();

                // Đóng cửa sổ admin hiện tại
                parentWindow.Close();
            }
        }
    }
}
