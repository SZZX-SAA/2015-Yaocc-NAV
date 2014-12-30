<%@ WebHandler Language="C#" Class="boothinfo" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.SessionState;

public class boothinfo : IHttpHandler, IRequiresSessionState
{

    protected string connstr = System.Configuration.ConfigurationManager.ConnectionStrings["YaoccConnectionString"].ToString();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        if (context.Request["action"] != null)
        {
            if (context.Session["refused"] == null)
            {
                context.Session["refused"] = 0;
            }
            if ((int)context.Session["refused"] > 5)
            {
                context.Response.Write("-2");
            }
            else
            {
                log(context.Request["action"].ToString(), context.Request.UserAgent.ToString(), context.Request.Browser.Platform.ToString(), context.Request.UserHostAddress.ToString(), context.Session["BoothSession"]);
                if (context.Request["action"].ToString() == "fetchboothinfo")
                {
                    string boothkey = context.Request["boothkey"].ToString();
                    SqlParameter para1 = new SqlParameter("@boothkey", SqlDbType.VarChar, 10);
                    para1.Value = boothkey;
                    SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM [BoothInfo] WHERE [key]=@boothkey", connstr);
                    da.SelectCommand.Parameters.Add(para1);
                    DataSet ds = new DataSet();
                    try
                    {
                        da.Fill(ds);
                    }
                    catch
                    {
                        context.Response.Write("-2");
                    }
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count <= 0)
                    {
                        context.Response.Write("-1");
                        context.Session["refused"] = (int)context.Session["refused"] + 1;
                    }
                    else
                    {
                        context.Session["BoothSession"] = boothkey;

                        DataRow drow = dt.Rows[0];
                        string rtmodal = "{'boothtype':'@thetype@','boothname':'@thename@','boothowner':'@theowner@','booth_introduction':'@theintro@','boothphone':'@thephone@','boothacrule':'@therule@'}";
                        rtmodal = rtmodal.Replace("'", "\"");
                        rtmodal = rtmodal.Replace("@thetype@", drow["type"].ToString());
                        rtmodal = rtmodal.Replace("@thename@", drow["name"].ToString());
                        rtmodal = rtmodal.Replace("@theowner@", drow["owner"].ToString());
                        rtmodal = rtmodal.Replace("@theintro@", drow["introduction"].ToString());
                        rtmodal = rtmodal.Replace("@thephone@", drow["phone"].ToString());
                        rtmodal = rtmodal.Replace("@therule@", drow["acrule"].ToString());
                        context.Response.Write(rtmodal);
                    }
                }
                else if (context.Request["action"].ToString() == "applyboothinfo")
                {
                    if (context.Session["BoothSession"] == null)
                    {
                        context.Response.Write("-1");
                        context.Session["refused"] = (int)context.Session["refused"] + 1;
                    }
                    else
                    {
                        string newowner = context.Request.Form["boothowner"].ToString();
                        string newphone = context.Request.Form["boothphone"].ToString();
                        string newname = context.Request.Form["boothname"].ToString();
                        string newintroduction = context.Request.Form["booth_introduction"].ToString();
                        string newrule = context.Request.Form["boothrule"].ToString();
                        string boothkey = context.Session["BoothSession"].ToString();

                        SqlConnection conn = new SqlConnection(connstr);
                        SqlCommand cmd = new SqlCommand("UPDATE [BoothInfo] SET [name]=@newname,[owner]=@newowner,[introduction]=@newintroduction,[phone]=@newphone,[acrule]=@newrule WHERE [key]='" + boothkey + "'", conn);
                        SqlParameter para1 = new SqlParameter("@newname", SqlDbType.VarChar, 8000);
                        para1.Value = newname;
                        SqlParameter para2 = new SqlParameter("@newowner", SqlDbType.VarChar, 8000);
                        para2.Value = newowner;
                        SqlParameter para3 = new SqlParameter("@newintroduction", SqlDbType.VarChar, 8000);
                        para3.Value = newintroduction;
                        SqlParameter para4 = new SqlParameter("@newphone", SqlDbType.VarChar, 20);
                        para4.Value = newphone;
                        SqlParameter para5 = new SqlParameter("@newrule", SqlDbType.VarChar, 8000);
                        para5.Value = newrule;
                        cmd.Parameters.Add(para1);
                        cmd.Parameters.Add(para2);
                        cmd.Parameters.Add(para3);
                        cmd.Parameters.Add(para4);
                        cmd.Parameters.Add(para5);

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch
                        {
                            context.Response.Write("-2");
                        }
                        finally
                        {
                            conn.Close();
                        }

                        context.Response.Write("1");
                    }
                }
            }
        }
    }

    public void log(string context, string browser, string OS, string IP_address, object session)
    {
        session = session == null ? string.Empty : session.ToString();
        SqlConnection conn = new SqlConnection(connstr);
        SqlCommand cmd = new SqlCommand("INSERT INTO [Log] ([context],[browser],[OS],[IP_address],[session]) VALUES ('" + context + "','" + browser + "','" + OS + "','" + IP_address + "','" + session.ToString() + "')", conn);
        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        finally
        {
            conn.Close();
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