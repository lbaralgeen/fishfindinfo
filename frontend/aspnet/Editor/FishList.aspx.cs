using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace FishTracker
{
    public partial class TFishList : DbLayer
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string fish_type = Request.QueryString["fish_type"];

                int nfishType = -1;
                LabelTypeFishes.Text = "All";

                if (int.TryParse(fish_type, out nfishType))
                {
                    switch (nfishType)
                    {
                        case 1: LabelTypeFishes.Text = "Sport";     break;
                        case 2: LabelTypeFishes.Text = "Coarse";    break;
                        case 4: LabelTypeFishes.Text = "Commercial"; break;
                        case 8: LabelTypeFishes.Text = "Invading";  break;
                        default: LabelTypeFishes.Text = "All";      break;
                    }
                }
                if (0 > nfishType)
                {
                    LabelTypeFishes.Text = "Unassigned";
                }
                if (String.IsNullOrEmpty(fish_type))
                {
                    fish_type = "null";
                }
                CTRL.SelectCommand = "SELECT * FROM dbo.fn_get_fish_list_type( " + fish_type + " ) ORDER BY fish_name ASC";
            }
            catch (Exception ex)
            {
                DbEventLogger(ex);
            }
        }
        protected void btSearchFish_Click(object sender, EventArgs e)
        {
            CTRL.SelectCommand = "SELECT num, fish_name, name, fish_latin, fish_id FROM dbo.SearchFishList('" + tbFishSearch.Text + "') ORDER BY irank ASC";
        }
    }
}