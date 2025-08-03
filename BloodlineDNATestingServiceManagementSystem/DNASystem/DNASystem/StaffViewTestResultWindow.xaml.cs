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
    /// Interaction logic for StaffViewTestResultWindow.xaml
    /// </summary>
    public partial class StaffViewTestResultWindow : Window
    {
        public User user { get; set; }
        public Booking EditedOne { get; set; }
        private TestResultService testResultService;
        private BookingService bookingService;
        public StaffViewTestResultWindow()
        {
            InitializeComponent();
        }

        public StaffViewTestResultWindow(User am, Booking booking)
        {
            InitializeComponent();
            this.user = am;
            EditedOne = booking;
            testResultService = new TestResultService();
            bookingService = new BookingService();
            this.WindowState = WindowState.Maximized;
        }
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            FillElement();
        }
        private void FillElement()
        {
            if (EditedOne.Status == "Hoàn thành")
            {
                var result = testResultService.GetTestResults().
                FirstOrDefault(r => r.BookingId == EditedOne.BookingId);
                txtResultId.Text = result.ResultId;
                txtCustomerId.Text = result.CustomerId;
                txtStaffId.Text = result.StaffId;
                txtBookingId.Text = result.BookingId;
                txtServiceId.Text = result.ServiceId;
                dpReceiveDate.SelectedDate = result.Date;
                txtDescription.Text = result.Description;
                txtStatus.Text = result.Status;

            }


            else
            {
                MessageBox.Show("Booking này chưa có kết quả!", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            SatffWindow staffWindow = new SatffWindow(user);
            staffWindow.Show();

        }
    }
}
