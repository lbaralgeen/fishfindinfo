using System;
using System.Configuration;
using System.Web;
using System.IO;
using System.Data;
using System.Data.SqlClient;

namespace FishTracker.Editor
{
    /// <summary>
    /// Summary description for HandlerImage
    /// </summary>
    public class HandlerImage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            Guid fishGuid = Guid.Empty;
            Int32 imageID = 0;
            Int32 pageID = 0;
            string param1 = null;
            Stream strm = null;

            try
            {
                try { param1 = context.Request.QueryString["lake"]; } catch (Exception) { }

                if (!String.IsNullOrEmpty(param1))
                {
                    strm = ShowImage("lake_image", "lake_image_ownerid", Guid.Parse(param1));
                }
                else
                {
                    if (context.Request.QueryString["id"] != null)
                        fishGuid = Guid.Parse(context.Request.QueryString["id"]);
                    else
                        throw new ArgumentException("1 No parameter specified");
                    try
                    {
                        if (context.Request.QueryString["sid"] != null)
                            imageID = Convert.ToInt32(context.Request.QueryString["sid"]);
                    }
                    catch { }

                    if (context.Request.QueryString["page"] != null)
                        pageID = Convert.ToInt32(context.Request.QueryString["page"]);
                    else
                        throw new ArgumentException("3 No parameter specified");

                    if (fishGuid == Guid.Empty)
                    {
                        return;
                    }
                    strm = ShowEmpImage(fishGuid, imageID, pageID);
                }
                if (strm != null)
                {
                    context.Response.ContentType = "image/jpeg";

                    byte[] buffer = new byte[64192];
                    int byteSeq = strm.Read(buffer, 0, 64192);

                    while (byteSeq > 0)
                    {
                        context.Response.OutputStream.Write(buffer, 0, byteSeq);
                        byteSeq = strm.Read(buffer, 0, 64192);
                    }
                }
            }
            catch (Exception) { }
        }
        public Stream ShowImage(string tableName, string fieldName, Guid imageGuid)
        {
            if (Guid.Empty == imageGuid || String.IsNullOrEmpty(tableName))
            {
                return null;
            }
            try
            {
                string conn = ConfigurationManager.ConnectionStrings["xConnectionString"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(conn))
                {
                    string sqlcmd = String.Format("SELECT TOP 1 lake_image_pic FROM [{1}] WHERE [{0}] = @id", fieldName, tableName);
                    using (SqlCommand cmd = new SqlCommand(sqlcmd, connection))
                    {
                        cmd.CommandType = CommandType.Text;

                        cmd.Parameters.AddWithValue("@id", imageGuid);

                        connection.Open();
                        object img = cmd.ExecuteScalar();
                        try
                        {
                            return new MemoryStream((byte[])img);
                        }
                        catch
                        {
                            return null;
                        }
                    }
                }
            }
            catch
            {
                return null;
            }
        }
        public Stream ShowEmpImage(Guid fishGuid, int? imageID, int pageID)
        {
            if (Guid.Empty == fishGuid)
            {
                return null;
            }
            try
            {
                string conn = ConfigurationManager.ConnectionStrings["xConnectionString"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(conn))
                {
                    string sql = string.Empty;

                    switch(pageID)
                    {
                        case 2: sql = "SELECT dbo.fn_fish_image_handler( @id, @sid )"; break;
                        default: return null;
                    }
                    using (SqlCommand cmd = new SqlCommand(sql, connection))
                    {
                        cmd.CommandType = CommandType.Text;

                        if (imageID == null)
                        {
                            cmd.Parameters.AddWithValue("@sid", DBNull.Value );
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@sid", imageID);
                        }
                        cmd.Parameters.AddWithValue("@id", fishGuid);

                        connection.Open();
                        object img = cmd.ExecuteScalar();
                        try
                        {
                            return new MemoryStream((byte[])img);
                        }
                        catch
                        {
                            return null;
                        }
                    }
                }
            }
            catch
            {
                return null;
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}