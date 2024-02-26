namespace MauiApp2_Juntilla
{
    public partial class MainPage : ContentPage
    {

        public MainPage()
        {
            InitializeComponent();
        }

        private void ChangeOnClick(object sender, EventArgs e)
        {
            if(lbl.Text.Equals("Expectation"))
            {

                imgBtn.Source = "woman.jpg";
                lbl.Text = "Reality";

            }else
            {
                imgBtn.Source = "man.jpg";
                lbl.Text = "Expectation";
            }
        }
        
    }

}
