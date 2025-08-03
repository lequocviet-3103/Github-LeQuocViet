using BusinessObjects;
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
    /// Interaction logic for BlogWindow.xaml
    /// </summary>
    public partial class BlogWindow : Window
    {
        public User currentuser { get; set; }
        public Service selectedService;
        private List<Article> allArticles = new List<Article>();

        public BlogWindow(User user)
        {
            InitializeComponent();
            this.WindowState = WindowState.Maximized;
            currentuser = user;
            txtWelcomeUser.Text = $"Welcome, " + currentuser.Fullname;
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            allArticles = new List<Article>
            {
                new Article
                {
                    Title = "Một số điều cần biết về giám định ADN",
                    Source = "Pháp y Hà Nội",
                    ImageUrl = "https://cdn.pixabay.com/photo/2020/01/20/15/24/dna-4778487_1280.jpg",
                    Url = "http://phapyhanoi.vn/mot-so-dieu-can-biet-ve-giam-dinh-adn-2654.htm"
                },
                new Article
                {
                    Title = "GenPlus và dịch vụ xét nghiệm gen",
                    Source = "GenPlus",
                    ImageUrl = "https://cdn.pixabay.com/photo/2017/08/29/00/45/dna-2695636_1280.jpg",
                    Url = "https://hn.genplus.vn/?gad_campaignid=8938152378"
                },
                new Article
                {
                    Title = "Tạp chí nghiên cứu y học: ADN trong y sinh",
                    Source = "Tạp chí Nghiên cứu Y học",
                    ImageUrl = "https://cdn.pixabay.com/photo/2020/04/04/21/38/dna-5008260_960_720.jpg",
                    Url = "https://tapchinghiencuuyhoc.vn/index.php/tcncyh/article/view/508"
                },
                new Article
                {
                    Title = "ADN và DNA trong khoa học y sinh",
                    Source = "Nhà thuốc Long Châu",
                    ImageUrl = "https://cdn.pixabay.com/photo/2021/03/01/21/16/dna-6060147_1280.jpg",
                    Url = "https://nhathuoclongchau.com.vn/bai-viet/adn-va-dna-su-khac-biet-va-diem-chung-trong-khoa-hoc-y-sinh.html"
                },
                new Article
                {
                    Title = "Gene Solutions và nghiên cứu ung thư",
                    Source = "Gene Solutions",
                    ImageUrl = "https://cdn.pixabay.com/photo/2020/06/07/01/59/dna-5266259_1280.jpg",
                    Url = "https://genesolutions.vn/tin-tuc/lien-tiep-2-bai-bao-ve-ung-thu-cua-vien-di-truyen-y-hoc-gene-solutions-duoc-chap-thuan-dang-tren-cac-an-pham-khoa-hoc-hang-dau-the-gioi/"
                },
                new Article
                {
                    Title = "Kỳ diệu: ADN lưu trữ dữ liệu số 2000 năm",
                    Source = "Thanh Niên",
                    ImageUrl = "https://cdn.pixabay.com/photo/2020/01/28/19/52/dna-4803195_1280.jpg",
                    Url = "https://thanhnien.vn/ky-dieu-adn-co-the-luu-du-lieu-so-trong-2000-nam-185495165.htm"
                },
                new Article
                {
                    Title = "Sự thật về xét nghiệm tài năng qua gene",
                    Source = "Dân trí",
                    ImageUrl = "https://cdn.pixabay.com/photo/2016/10/17/20/30/dna-1749089_1280.jpg",
                    Url = "https://dantri.com.vn/suc-khoe/that-hu-ve-xet-nghiem-tai-nang-qua-gene-adn-20200104092647342.htm"
                },
                new Article
                {
                    Title = "Xét nghiệm gen và bệnh di truyền",
                    Source = "VnExpress",
                    ImageUrl = "https://cdn.pixabay.com/photo/2017/03/12/19/16/dna-2137090_960_720.jpg",
                    Url = "https://vnexpress.net/xet-nghiem-gen-danh-gia-nguy-co-mac-benh-di-truyen-4413383.html"
                }
            };

            ArticlePanel.Children.Clear();
            foreach (var article in allArticles)
            {
                ArticlePanel.Children.Add(CreateArticleCard(article));
            }
        }

        private UIElement CreateArticleCard(Article article)
        {
            var imageBrush = new ImageBrush
            {
                ImageSource = new BitmapImage(new Uri(article.ImageUrl)),
                Stretch = Stretch.UniformToFill,
                Opacity = 0.5
            };

            var border = new Border
            {
                Width = 280,
                Margin = new Thickness(10),
                Background = imageBrush,
                CornerRadius = new CornerRadius(10),
                BorderBrush = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#E5E7EB")),
                BorderThickness = new Thickness(1)
            };

            var stack = new StackPanel { Margin = new Thickness(10) };

            var title = new TextBlock
            {
                Text = article.Title,
                FontWeight = FontWeights.Bold,
                FontSize = 14,
                TextWrapping = TextWrapping.Wrap,
                Foreground = Brushes.Black
            };

            var source = new TextBlock
            {
                Text = article.Source,
                FontSize = 12,
                Foreground = Brushes.Black
            };

            var button = new Button
            {
                Content = "Đọc bài viết",
                Background = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#1D4ED8")),
                Foreground = Brushes.White,
                Margin = new Thickness(0, 10, 0, 0),
                Tag = article.Url
            };
            button.Click += OpenArticle_Click;

            stack.Children.Add(title);
            stack.Children.Add(source);
            stack.Children.Add(button);

            var overlay = new Border
            {
                Background = new SolidColorBrush(Color.FromArgb(180, 255, 255, 255)),
                CornerRadius = new CornerRadius(10),
                Child = stack
            };

            border.Child = overlay;
            return border;
        }

        private void btnTimKiem_Click(object sender, RoutedEventArgs e)
        {
            string keyword = txtSearch.Text.Trim().ToLower();
            ArticlePanel.Children.Clear();

            var filtered = string.IsNullOrEmpty(keyword)
                ? allArticles
                : allArticles.Where(a => a.Title.ToLower().Contains(keyword)).ToList();

            foreach (var article in filtered)
            {
                ArticlePanel.Children.Add(CreateArticleCard(article));
            }

            if (filtered.Count == 0)
            {
                MessageBox.Show("Không tìm thấy bài viết nào phù hợp.", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

        private void OpenArticle_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button btn && btn.Tag is string url)
            {
                System.Diagnostics.Process.Start(new System.Diagnostics.ProcessStartInfo
                {
                    FileName = url,
                    UseShellExecute = true
                });
            }
        }

        private void btnTrangChu_Click(object sender, RoutedEventArgs e)
        {
            HomeWindow homeWindow = new HomeWindow(currentuser);
            homeWindow.Show();
            this.Close();
        }

        private void btnDichVu_Click(object sender, RoutedEventArgs e)
        {
            DNATestingServiceLanding dNATestingServiceLanding = new DNATestingServiceLanding(currentuser);
            dNATestingServiceLanding.Show();
            this.Close();
        }

        private void btnVeChungToi_Click(object sender, RoutedEventArgs e)
        {
            AboutUsWindow aboutUsWindow = new AboutUsWindow(currentuser);
            aboutUsWindow.Show();
            this.Close();
        }

        private void btnBlog_Click(object sender, RoutedEventArgs e)
        {
            BlogWindow blogWindow = new BlogWindow(currentuser);
            blogWindow.Show();
            this.Close();
        }

        private void btnLienHe_Click(object sender, RoutedEventArgs e)
        {
            ContactWindow contactWindow = new ContactWindow(currentuser);
            contactWindow.Show();
            this.Close();
        }

        private void btnDangKy_Click(object sender, RoutedEventArgs e)
        {
            BookingWindow bookingWindow = new BookingWindow(selectedService, currentuser);
            bookingWindow.Show();
            this.Close();
        }

        private void btnUserMenu_Click(object sender, RoutedEventArgs e)
        {
            UserPopup.IsOpen = true;
        }

        private void btnProfile_Click(object sender, RoutedEventArgs e)
        {
            CustomerProfileWindow profileWindow = new CustomerProfileWindow(currentuser);
            profileWindow.Show();
            this.Close();
        }

        private void btnHistory_Click(object sender, RoutedEventArgs e)
        {
            TestHistoryWindow testHistoryWindow = new TestHistoryWindow(currentuser);
            testHistoryWindow.Show();
            this.Close();
        }

        private void btnLogout_Click(object sender, RoutedEventArgs e)
        {
            LoginWindow loginWindow = new LoginWindow();
            loginWindow.Show();
            this.Close();
        }
    }

    public class Article
    {
        public string Title { get; set; }
        public string Source { get; set; }
        public string ImageUrl { get; set; }
        public string Url { get; set; }
    }
}