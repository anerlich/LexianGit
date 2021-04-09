using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Mail;

namespace SMTP
{
    class Program
    {
        static void Main(string[] args)
        {
            string logPath = "";
            if (args.Length > 1)
            {
                logPath = args[1].Replace("\"","");
                if (!logPath.EndsWith("\\"))
                {
                    logPath += "\\";
                }
            }
            string fn = logPath + DateTime.Now.ToString("yyyyMMdd") + " smtp.log";
            int nxt = 0;
            while (System.IO.File.Exists(fn))
            {
                nxt++;
                fn = logPath + DateTime.Now.ToString("yyyyMMdd") + nxt.ToString() + " smtp.log";
            }
            System.IO.FileStream fs = new System.IO.FileStream(fn, System.IO.FileMode.Create);
            // First, save the standard output.
            System.IO.StreamWriter sw = new System.IO.StreamWriter(fs);

            sw.WriteLine("Smtp Started");
            if (args.Length > 0)
            {
                sw.WriteLine("ini file: " + args[0]);
                string output = args[0];

                if (System.IO.File.Exists(output))
                {
                    sw.WriteLine("File Found");
                    string line;
                    try
                    {
                        MailMessage MyMailMessage = new MailMessage();
                        System.Net.NetworkCredential nc = new System.Net.NetworkCredential();
                        string sender = "Optimiza", senderaddress = "";

                        //Create the SMTPClient object and specify the SMTP GMail server
                        SmtpClient SMTPServer = new SmtpClient();

                        // Read the file and display it line by line.
                        System.IO.StreamReader file = new System.IO.StreamReader(output);
                        while ((line = file.ReadLine()) != null)
                        {
                            if (line.ToLower().StartsWith("host="))
                            {
                                SMTPServer = new SmtpClient(line.Substring(5));
                            }
                            else if (line.ToLower().StartsWith("port="))
                            {
                                SMTPServer.Port = int.Parse(line.Substring(5));
                            }
                            else if (line.ToLower().StartsWith("user id="))
                            {
                                nc.UserName = line.Substring(8);
                            }
                            else if (line.ToLower().StartsWith("password="))
                            {
                                nc.Password = line.Substring(9);
                            }
                            else if (line.ToLower().StartsWith("sender name="))
                            {
                                sender = line.Substring(12);
                            }
                            else if (line.ToLower().StartsWith("sender email="))
                            {
                                senderaddress = line.Substring(13);
                            }
                            else if ((line.ToLower().StartsWith("to=")) && (line.Substring(3).Trim() != ""))
                            {
                                MyMailMessage.To.Add(line.Substring(3));
                            }
                            else if ((line.ToLower().StartsWith("cc=")) && (line.Substring(3).Trim() != ""))
                            {
                                MyMailMessage.CC.Add(line.Substring(3));
                            }
                            else if ((line.ToLower().StartsWith("bcc=")) && (line.Substring(4).Trim() != ""))
                            {
                                MyMailMessage.Bcc.Add(line.Substring(4));
                            }
                            else if (line.ToLower().StartsWith("subject="))
                            {
                                MyMailMessage.Subject = line.Substring(8);
                            }
                            else if (line.ToLower().StartsWith("message="))
                            {
                                MyMailMessage.Body = line.Substring(8).Replace(",", "\n").Replace("\"", "");
                            }
                            else if (line.ToLower().StartsWith("attachments="))
                            {
                                string[] attach = line.Substring(12).Replace("\"", "").Split(',');
                                foreach (var item in attach)
                                {
                                    if (item != "")
                                    {
                                        MyMailMessage.Attachments.Add(new Attachment(item));
                                    }
                                }
                            }
                        }

                        file.Close();
                        MyMailMessage.Sender = new MailAddress(senderaddress, sender);
                        MyMailMessage.From = new MailAddress(senderaddress, sender);
                        //SMTPServer.Credentials = nc;
                        //SMTPServer.EnableSsl = true;
                        try
                        {
                            sw.WriteLine("Sending");
                            SMTPServer.Send(MyMailMessage);
                            sw.WriteLine("Sent");
                        }
                        catch (SmtpException ex)
                        {
                            sw.WriteLine("error: " + ex.Message);
                        }
                    }
                    catch (SmtpException ex)
                    {
                        sw.WriteLine("error: " + ex.Message);
                    }
                }
            }
            else
            {
                sw.WriteLine("ini file not found?");
            }
            sw.Flush();
            sw.Close();

        }


    }
}

