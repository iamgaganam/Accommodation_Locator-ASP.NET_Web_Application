using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Net;
using System.Web.Profile;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

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

        [WebMethod]
        public static void ApproveOrRejectProperty(string propertyId, string action)
        {
            int id = int.Parse(propertyId);

            if (action == "approve")
            {
                DatabaseData.UpdateProperty(id, 1);
            }
            else if (action == "reject")
            {
                DatabaseData.UpdateProperty(id, 0);
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