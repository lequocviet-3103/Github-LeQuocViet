using BusinessObjects;
using Repositories;
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
    /// Interaction logic for KitWindow.xaml
    /// </summary>
    public partial class KitWindow : Window
    {
        private readonly BookingService bookingService;
        private readonly KitService kitService;
        public Booking EditedOne { get; set; }
        public User user { get; set; }
        public KitWindow()
        {
            InitializeComponent();
        }
        public KitWindow(User am)
        {
            InitializeComponent();
            this.user = am;
            bookingService = new BookingService();
            kitService = new KitService();
        }
        //hello every one, this is a comment to test the code snippet
        private void BackButton_Click(object sender, RoutedEventArgs e)
        {

        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            // Validate required fields
            if (dpReceiveDate.SelectedDate == null)
            {
                MessageBox.Show("Vui lòng chọn ngày nhận!", "Lỗi", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            Kit kit = new Kit();

            kit.CustomerId = txtCustomerId.Text;
            kit.StaffId = txtStaffId.Text;
            kit.BookingId = txtBookingId.Text;
            kit.Description = txtDescription.Text;
            kit.Status = cbStatus.Text;
            kit.Receivedate = dpReceiveDate.SelectedDate; // No need for casting, as both are DateTime?
            kitService.AddKit(kit);
            MessageBox.Show("Tạo Kit thành công!", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            Close();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            FillElememt();
        }

        private void FillElememt()
        {
            
            txtBookingId.Text = EditedOne.BookingId;
            txtStaffId.Text = user.UserId;
            txtCustomerId.Text = EditedOne.CustomerId;

        }
    }
}
