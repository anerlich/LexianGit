using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Net.Mail;

namespace EMail
{
    public partial class SMTPForm : Form
    {
        public SMTPForm()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //Start by creating a mail message object

            {
                MailMessage MyMailMessage = new MailMessage();

                //From requires an instance of the MailAddress type
                MyMailMessage.From = new MailAddress("lexiancp@gmail.com");

                //To is a collection of MailAddress types
                MyMailMessage.To.Add("colin_mccall@lexian.com.au,colinmccall.au@gmail.com");

                MyMailMessage.Subject = "GMail Tes5t";
                MyMailMessage.Body = "This is the test text for Gmail email";

                //Create the SMTPClient object and specify the SMTP GMail server
                SmtpClient SMTPServer = new SmtpClient("smtp.gmail.com");
                SMTPServer.Port = 587;
                SMTPServer.Credentials = new System.Net.NetworkCredential("lexiancp@gmail.com", "lexadmin");
                SMTPServer.EnableSsl = true;

                try
                {
                    SMTPServer.Send(MyMailMessage);
                   // MessageBox.Show("Email Sent");
                }
                catch (SmtpException ex)
                {
                    MessageBox.Show(ex.Message);
                }
                Close();
            }
        }
    }
}

