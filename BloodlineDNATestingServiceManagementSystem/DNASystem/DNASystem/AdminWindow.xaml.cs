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
    /// Interaction logic for AdminWindow.xaml
    /// </summary>
    public partial class AdminWindow : Window
    {
        private readonly IServiceService iServiceService;
        public AdminWindow()
        {
            InitializeComponent();
            iServiceService = new ServiceService();
            this.WindowState = WindowState.Maximized;
        }

        public void LoadServicesList()
        {
            
            var services = iServiceService.GetAllServices();
            lvService.ItemsSource = null;
            lvService.ItemsSource = services;
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            LoadServicesList();
        }

        private void btnCreate_Click(object sender, RoutedEventArgs e)
        {
            CreateAndUpdateServiceWindow details = new CreateAndUpdateServiceWindow();
            details.ShowDialog();
            LoadServicesList();
        }
        private void btnUpdate_Click(object sender, RoutedEventArgs e)
        {
            Service? selected = lvService.SelectedItem as Service;
            if (selected == null)
            {
                MessageBox.Show("Please select a service to updating.", "select on", MessageBoxButton.OK, MessageBoxImage.Stop);
                return;
            }
            
            CreateAndUpdateServiceWindow details = new CreateAndUpdateServiceWindow();
            details.EditedOne = selected;
            details.ShowDialog();
            LoadServicesList();
        }
        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {
            Service? selected = lvService.SelectedItem as Service;
            if(selected == null)
            {
                MessageBox.Show("Please select a service to delete.", "select on", MessageBoxButton.OK, MessageBoxImage.Stop);
                return;
            }
            MessageBoxResult answer = MessageBox.Show("Are you sure.", "Confirm", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (answer == MessageBoxResult.No)
            {
                return;
            }
            iServiceService.DeleteService(selected);
            LoadServicesList();

        }

        private void btnExit_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private void AdminButton_Click(object sender, RoutedEventArgs e)
        {
            MainContent.Content = new AdminHomePage();
        }
    }
}
