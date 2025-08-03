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
    /// Interaction logic for ViewTestResultWindow.xaml
    /// </summary>
    public partial class ViewTestResultWindow : Window
    {
        User currentuser = new User();
        private string _bookingId;
        TestResultService testResultService = new TestResultService();
        public ViewTestResultWindow(User user, string bookingid)
        {
            InitializeComponent();
            currentuser = user;
            _bookingId = bookingid;
            LoadTestResult();
            this.WindowState = WindowState.Maximized;
        }
        private void LoadTestResult()
        {
            var result = testResultService.GetTestResults().FirstOrDefault(r => r.BookingId == _bookingId);

            if (result != null)
            {
                txtResultId.Text = result.ResultId;
                txtCustomerId.Text = result.CustomerId;
                txtStaffId.Text = result.StaffId;
                txtServiceId.Text = result.ServiceId;
                txtBookingId.Text = _bookingId;
                dpReceiveDate.SelectedDate = result.Date;
                txtDescription.Text = result.Description;
                txtStatus.Text = result.Status;
            }
            else
            {
                MessageBox.Show("Không tìm thấy kết quả xét nghiệm cho BookingId: " + _bookingId);
                this.Close();
            }
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            TestHistoryWindow testHistoryWindow = new TestHistoryWindow(currentuser);
            testHistoryWindow.Show();
            this.Close();
        }
    }
}
