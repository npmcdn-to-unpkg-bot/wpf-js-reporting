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
using CefSharp;
using System.IO;
using CefSharp.SchemeHandler;
using System.Net;
using blablabla.Properties;

namespace blablabla
{

    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
       
        MyClass myClass;
        public MainWindow()
        {

            CefSharp.CefSettings settings = new CefSharp.CefSettings();
            settings.PackLoadingDisabled = true;
            myClass = new MyClass();

            
            myClass.message = "BLALBLLDFL";

            Cef.Initialize(settings);
            InitializeComponent();

            Browser.Address = "http://localhost:53689";
            Browser.RegisterJsObject("myClass", myClass);

        }

        private void button_Click(object sender, RoutedEventArgs e)
        {
            Browser.ExecuteScriptAsync("alert(myClass.sayHello()); ");


        }
    }

    public class MyClass: iUO
    {
        public MyClass()
        {
            _params.Add("Russia", "100");
            _params.Add("USA", "200");
            name = "MyClass";
        }
        public String message { get; set; }
        public String sayHello()
        {
            message = "Hello";
            return message;
        }
    }
}
