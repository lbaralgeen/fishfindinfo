<%@ WebHandler Language="C#" Class="ShowImage" %>

using System;
using System.Configuration;
using System.Web;
using System.IO;
using System.Data;
using System.Data.SqlClient;

public class ShowImage : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        Guid empno = Guid.Empty;
        if (context.Request.QueryString["id"] != null)
            empno = Guid.Parse(context.Request.QueryString["id"]);
        else
            throw new ArgumentException("No parameter specified");

        context.Response.ContentType = "image/jpeg";
        Stream strm = ShowEmpImage(empno);
        byte[] buffer = new byte[72000];
        int byteSeq = strm.Read(buffer, 0, 72000);

        while (byteSeq > 0)
        {
            context.Response.OutputStream.Write(buffer, 0, byteSeq);
            byteSeq = strm.Read(buffer, 0, 72000);
        }
        //context.Response.BinaryWrite(buffer);
    }

    public Stream ShowEmpImage(Guid id)
    {
        string conn = ConfigurationManager.ConnectionStrings["EmployeeConnString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(conn))
        {
            string sql = "SELECT img FROM fish WHERE fish_id = @ID AND img IS NULL";
            SqlCommand cmd = new SqlCommand(sql, connection);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@ID", id);
            connection.Open();
            object img = cmd.ExecuteScalar();

            if (null == img)
            {
                return null;
            }
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

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


}