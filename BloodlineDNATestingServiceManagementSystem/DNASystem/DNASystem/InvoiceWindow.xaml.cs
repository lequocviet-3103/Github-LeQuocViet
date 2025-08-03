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
    /// Interaction logic for InvoiceWindow.xaml
    /// </summary>
    public partial class InvoiceWindow : Window
    {
        private readonly InvoiceService _invoiceService ;
        private readonly string _invoiceId;

        public InvoiceWindow(InvoiceService invoiceService, string invoiceId)
        {
            InitializeComponent();
            _invoiceService = invoiceService;
            _invoiceId = invoiceId;
            LoadInvoiceDetails();

        }

        private void LoadInvoiceDetails()
        {
            try
            {
                Invoice? invoice = _invoiceService.GetInvoiceByIdWithBooking(_invoiceId);

                if (invoice == null)
                {
                    MessageBox.Show("Không tìm thấy hóa đơn.", "Lỗi", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                txtInvoiceId.Text = invoice.InvoiceId;
                txtCustomerName.Text = invoice.Booking?.Customer?.Fullname ?? "Không xác định";
                txtStaffName.Text = invoice.Booking?.Staff?.Fullname ?? "Không xác định";
                txtServiceName.Text = invoice.Booking?.Service?.Name ?? "Không xác định";
                txtDate.Text = invoice.Date?.ToString("dd/MM/yyyy") ?? "N/A";
                txtPrice.Text = invoice.Price?.ToString("0") + " VNĐ";
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Đã xảy ra lỗi khi tải chi tiết hóa đơn:\n{ex.Message}", "Lỗi", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void BtnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
