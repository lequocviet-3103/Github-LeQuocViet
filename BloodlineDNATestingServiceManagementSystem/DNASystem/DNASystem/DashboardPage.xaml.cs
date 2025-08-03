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
using Services;

namespace DNASystem
{
    /// <summary>
    /// Interaction logic for DashboardPage.xaml
    /// </summary>
    public partial class DashboardPage : UserControl
    {
        private readonly UserService userService;
        private readonly BookingService bookingService;
        private readonly TestResultService testResultService;
        private readonly KitService kitService;

        public DashboardPage()
        {
            InitializeComponent();

            // Initialize services - đây là các service đã có trong dự án của bạn
            userService = new UserService();
            bookingService = new BookingService();
            testResultService = new TestResultService();
            kitService = new KitService();

            LoadDashboardData();
        }

        private void LoadDashboardData()
        {
            try
            {
                // Set current date
                txtCurrentDate.Text = DateTime.Now.ToString("dd/MM/yyyy");

                // Load statistics từ database thông qua các service
                LoadStatistics();

                // Load recent activities từ database (nếu cần)
                // LoadRecentActivities(); // Đã bỏ phần này
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Lỗi khi tải dữ liệu dashboard: {ex.Message}", "Lỗi",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void LoadStatistics()
        {
            try
            {
                // Get total users từ UserService
                var totalUsers = userService.GetAllUsers()?.Count ?? 0;
                txtTotalUsers.Text = totalUsers.ToString();

                // Get total bookings từ BookingService
                var totalBookings = bookingService.GetAllBookings()?.Count ?? 0;
                txtTotalBookings.Text = totalBookings.ToString();

                // Get all test results từ TestResultService
                var allTestResults = testResultService.GetTestResults();

                // Debug: In ra console để kiểm tra
                Console.WriteLine($"Total test results: {allTestResults?.Count ?? 0}");
                if (allTestResults != null)
                {
                    foreach (var result in allTestResults)
                    {
                        Console.WriteLine($"Test Result ID: {result.ResultId}, Status: '{result.Status}'");
                    }
                }

                // Get completed tests - sử dụng status từ database (Completed)
                var completedTests = allTestResults
                    ?.Count(t => t.Status != null &&
                                (t.Status.Equals("Completed", StringComparison.OrdinalIgnoreCase) ||
                                 t.Status.Equals("Hoàn thành", StringComparison.OrdinalIgnoreCase))) ?? 0;
                txtCompletedTests.Text = completedTests.ToString();

                // Get pending tests - sử dụng status từ database (Processing và các trạng thái khác)
                var pendingTests = allTestResults
                    ?.Count(t => t.Status != null &&
                                (t.Status.Equals("Processing", StringComparison.OrdinalIgnoreCase) ||
                                 t.Status.Equals("Pending", StringComparison.OrdinalIgnoreCase) ||
                                 t.Status.Equals("Đang xử lý", StringComparison.OrdinalIgnoreCase) ||
                                 t.Status.Equals("Đang chờ xử lý", StringComparison.OrdinalIgnoreCase))) ?? 0;
                txtPendingTests.Text = pendingTests.ToString();

                // Debug: In ra kết quả
                Console.WriteLine($"Completed Tests: {completedTests}");
                Console.WriteLine($"Pending Tests: {pendingTests}");

            }
            catch (Exception ex)
            {
                // Handle individual stat loading errors
                Console.WriteLine($"Error loading statistics: {ex.Message}");
                MessageBox.Show($"Lỗi khi tải thống kê: {ex.Message}", "Lỗi",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        public void RefreshDashboard()
        {
            LoadDashboardData();
        }
    }

    public class ActivityItem
    {
        public string Icon { get; set; } = "";
        public string Title { get; set; } = "";
        public string Description { get; set; } = "";
        public string Time { get; set; } = "";
        public string Color { get; set; } = "";
    }
}
