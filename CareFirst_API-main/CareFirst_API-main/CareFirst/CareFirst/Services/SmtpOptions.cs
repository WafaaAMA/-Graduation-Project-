﻿namespace CareFirst.Services
{
    public class SmtpOptions
    {
        public int Port { get; set; }
        public string AppPassword { get; set; }
        public string EmailSend { get; set; }
        public string SmtpServer { get; set; }
    }
}
