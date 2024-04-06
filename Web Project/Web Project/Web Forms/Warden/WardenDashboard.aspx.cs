using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Web.UI;

namespace Web_Project.Web_Forms.Warden
{
    public partial class WardenDashboard : System.Web.UI.Page
    {
        public string propertyDataJson { get; private set; }
        public string approvedPropertiesJson { get; private set; }
        public string rejectedPropertiesJson { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProperties();
                LoadApprovedProperties();
                LoadRejectedProperties();
            }
        }

        private void LoadProperties()
        {
            string constraint = "WHERE status = -1 ORDER BY id DESC";
            List<PropertyData> propertyData = DatabaseData.GetProperties(constraint);
            
            propertyDataJson = JsonConvert.SerializeObject(propertyData);
        }

        private void LoadApprovedProperties()
        {
            string constraint = "WHERE status = 1 ORDER BY id DESC";
            List<PropertyData> propertyData = DatabaseData.GetProperties(constraint);

            approvedPropertiesJson = JsonConvert.SerializeObject(propertyData);
        }

        private void LoadRejectedProperties()
        {
            string constraint = "WHERE status = 0 ORDER BY id DESC";
            List<PropertyData> propertyData = DatabaseData.GetProperties(constraint);

            rejectedPropertiesJson = JsonConvert.SerializeObject(propertyData);
        }


    }
}