using System;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace FishTracker
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        public float userLat = 0;
        public float userLon = 0;
        public string m_connStr = "";
        public bool m_trial = true;

        private Control FindControlRecursive(Control rootControl, string controlID)
        {
            if (rootControl.ID == controlID) return rootControl;

            foreach (Control controlToSearch in rootControl.Controls)
            {
                Control controlToReturn =
                    FindControlRecursive(controlToSearch, controlID);
                if (controlToReturn != null) return controlToReturn;
            }
            return null;
        }
        public static void RemoveMenuItemByValue(MenuItemCollection items, String value)
        {
            MenuItem itemToRemove = null;

            //Breadth first, look in the collection
            foreach (MenuItem item in items)
            {
                if (item.Value == value)
                {
                    itemToRemove = item;
                    break;
                }
            }

            if (itemToRemove != null)
            {
                items.Remove(itemToRemove);
                return;
            }


            //Search children
            foreach (MenuItem item in items)
            {
                RemoveMenuItemByValue(item.ChildItems, value);
            }
        }
        public static void SetMenuItemByValue(MenuItemCollection items, String value, bool state)
        {
            MenuItem itemToRemove = null;

            //Breadth first, look in the collection
            foreach (MenuItem item in items)
            {
                if (item.Value == value)
                {
                    itemToRemove = item;
                    break;
                }
            }
            if (itemToRemove != null)
            {
                itemToRemove.Enabled = state;
                return;
            }
            //Search children
            foreach (MenuItem item in items)
            {
                SetMenuItemByValue(item.ChildItems, value, state);
            }
        }
        public static MenuItem FindMenuItemByValue( MenuItemCollection items, String value )
        {
            //Breadth first, look in the collection
            foreach (MenuItem item in items)
            {
                if (item.Value == value)
                {
                    return item;
                }
            }
            //Search children
            foreach (MenuItem item in items)
            {
                return FindMenuItemByValue( item.ChildItems, value );
            }
            return null;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        private bool m_admin = false;
        public struct trial_struct { public string name; public bool state;  };
        public trial_struct[] trialas = new trial_struct[] { new trial_struct() { name = "Admin", state = true } };

        // https://docs.microsoft.com/en-us/previous-versions/aspnet/dct97kc3(v=vs.100)
        protected void Page_Init(object sender, EventArgs e)
        {
            try
            {
                try
                {
                    m_connStr = ConfigurationManager.ConnectionStrings["xConnectionString"].ConnectionString;

                    if (String.IsNullOrEmpty(m_connStr))
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Cannot get connection string", "alert('[Page_Load]: Site.Master');", true);
                        return;
                    }
                    CurrentTime.Text = DateTime.Now.ToString();

                    var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];

                    if (null == cookie)
                    {
                        return;
                    }
                    var ticketInfo = FormsAuthentication.Decrypt(cookie.Value);

                    if (null == ticketInfo || null == ticketInfo.UserData || 36 != ticketInfo.UserData.Length)
                    {
                        return;
                    }
                    string userGuid = ticketInfo.UserData;
                    string visited = Session["Visited"].ToString();
                    string userName = ticketInfo.UserData;

                    if (String.IsNullOrEmpty(userGuid))
                    {
                        return;
                    }

                    if ( !String.IsNullOrEmpty(userGuid) )  // 
                    {
                        m_admin = ( "bb30165a-fd1a-4b54-b921-9334242c9bf6" == userGuid);
                        m_trial = false;
                    }
                    if (!String.IsNullOrEmpty(userGuid))

                    {
                        Session["user"] = userGuid;
                        Session["trial"] = "0";
                    }
                    else
                    if (null != visited && 0 != visited.Length)
                    {
                        Session["Visited"] = Convert.ToInt32(visited) + 1;
                    }
                }
                catch (Exception ex)
                {
                    m_trial = true;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Oops!! following error occured : " + ex.Message.ToString() + "');", true);
                    Response.Write("[Page_Load]: following error occured: " + ex.Message.ToString());
                }
            }
            finally
            {
                if (m_trial)
                {
                    string[] nontrial = { "Pond", "Stream", "Canal", "Reservoir", "Sport", "Hobby" };

                    foreach (string value in nontrial)
                    {
                        RemoveMenuItemByValue(NavigationMenu.Items, value);
                    }
                    MenuItem planning = FindMenuItemByValue(NavigationMenu.Items, "Planning");

                    if(planning != null)
                    {
                        planning.NavigateUrl = "/Forecast/Planning.aspx?type=3";
                    }
                }
                else
                {
                    MenuItem miCreek = FindMenuItemByValue(NavigationMenu.Items, "Creek");

                    if (miCreek != null)
                    {
                        miCreek.Enabled = true;
                    }
                    foreach (trial_struct iter in trialas)
                    {
                        SetMenuItemByValue(NavigationMenu.Items, iter.name, true);
                    }
                    MenuItem add_news = FindMenuItemByValue(NavigationMenu.Items, "AddNews");

                    if (m_admin && add_news != null)
                    {
                        add_news.Enabled = true;
                        add_news.Text = "Add News";
                    }
                }
            }
        }
    }
}
