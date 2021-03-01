namespace OWMService
{
    partial class RWS
    {
        /// <summary> 
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.eventLogRN = new System.Diagnostics.EventLog();
            ((System.ComponentModel.ISupportInitialize)(this.eventLogRN)).BeginInit();
            // 
            // eventLogRN
            // 
            this.eventLogRN.EnableRaisingEvents = true;
            this.eventLogRN.Log = "Application";
            this.eventLogRN.Source = "OWMService";
            // 
            // RWS
            // 
            this.AutoLog = false;
            this.CanPauseAndContinue = true;
            this.CanShutdown = true;
            this.ServiceName = "OWMService";
            ((System.ComponentModel.ISupportInitialize)(this.eventLogRN)).EndInit();

        }

        #endregion

        public System.Diagnostics.EventLog eventLogRN;
    }
}
