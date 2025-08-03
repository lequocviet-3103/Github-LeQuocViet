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
    /// Interaction logic for CreateAndUpdateServiceWindow.xaml
    /// </summary>
    public partial class CreateAndUpdateServiceWindow : Window
    {
        private readonly IServiceService iServiceService;
        public Service EditedOne { get; set; }
        public CreateAndUpdateServiceWindow()
        {
            InitializeComponent();
            iServiceService = new ServiceService();
            this.WindowState = WindowState.Maximized;

        }
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            txtServiceID.IsEnabled = false;
            if (EditedOne != null)
            {
                FillElements();
            }
        }


        public void FillElements()
        {
            if (EditedOne != null)
            {
                txtServiceID.Text = EditedOne.ServiceId;
                txtServiceType.Text = EditedOne.Type;
                txtServiceName.Text = EditedOne.Name;
                txtPrice.Text = EditedOne.Price.ToString();
                txtDescription.Text = EditedOne.Description;
                //txtDescription.selectedValue = EditedOne.DescriptionID;aaaa
            }
        }

        

        private void txtSave_Click(object sender, RoutedEventArgs e)
        {
            Service service = new Service();

            //service.ServiceId = txtServiceID.Text;
            service.Type = txtServiceType.Text ;
            service.Name = txtServiceName.Text;
            service.Price = decimal.Parse(txtPrice.Text);
            service.Description = txtDescription.Text;
            if(EditedOne == null)
            {
                iServiceService.AddService(service);
                MessageBox.Show("Service added successfully.", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            else
            {
                service.ServiceId = EditedOne.ServiceId;
                iServiceService.UpdateService(service);
                MessageBox.Show("Service updated successfully.", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            this.Close();
        }

        private void txtExit_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
