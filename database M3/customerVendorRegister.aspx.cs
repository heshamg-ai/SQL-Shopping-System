using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace database_M3
{
    public partial class customerVendorRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void customerReg(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("customerRegister", conn);
            cmd.CommandType = CommandType.StoredProcedure;



            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", txt_usernamec.Text));
            cmd.Parameters.Add(new SqlParameter("@first_name", txt_firstnamec.Text));
            cmd.Parameters.Add(new SqlParameter("@last_name", txt_lastnamec.Text));
            cmd.Parameters.Add(new SqlParameter("@password", txt_passwordc.Text));
            cmd.Parameters.Add(new SqlParameter("@email", txt_emailc.Text));

            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            if (txt_usernamec.Text == "" | txt_firstnamec.Text == "" | txt_lastnamec.Text == "" | txt_passwordc.Text == "" |
                txt_emailc.Text == "")
            {
                Response.Write("<script>alert('Make sure you entered all data!')</script>");

            }

            else
            {

                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (outp.Value.ToString() == "1")
                {
                    Response.Write("<script>alert('This username is used! Please try another one.')</script>");

                }
                else
                {
                    if (outp.Value.ToString() == "2")
                    {
                        Response.Write("<script>alert('This email is used! Please try another one.')</script>");

                    }
                    else
                    {
                        Session["usernameReg"] = txt_usernamec.Text;
                        //To navigate to another webpage
                        Response.Redirect("phonenumbers.aspx", true);
                    }

                }

            }

            


        }
        protected void vendor(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("vendorRegister", conn);
            cmd.CommandType = CommandType.StoredProcedure;



            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", txt_usernamev.Text));
            cmd.Parameters.Add(new SqlParameter("@first_name", txt_firstnamev.Text));
            cmd.Parameters.Add(new SqlParameter("@last_name", txt_lastnamev.Text));
            cmd.Parameters.Add(new SqlParameter("@password", txt_passwordv.Text));
            cmd.Parameters.Add(new SqlParameter("@email", txt_emailv.Text));
            cmd.Parameters.Add(new SqlParameter("@company_name", txt_companyv.Text));
            cmd.Parameters.Add(new SqlParameter("@bank_acc_no", txt_accnum.Text));


            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            if (txt_usernamev.Text == "" | txt_firstnamev.Text == "" | txt_lastnamev.Text == "" | txt_passwordv.Text == "" |
                txt_emailv.Text == "" | txt_companyv.Text=="" | txt_accnum.Text == "")
            {
                Response.Write("<script>alert('Make sure you entered all data!')</script>");

            }
            else
            {
                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (outp.Value.ToString() == "1")
                {
                    Response.Write("<script>alert('This username is used! Please try another one.')</script>");

                }
                else
                {
                    if (outp.Value.ToString() == "2")
                    {
                        Response.Write("<script>alert('This email is used! Please try another one.')</script>");

                    }
                    else
                    {
                        Session["usernameReg"] = txt_usernamev.Text;
                        //To navigate to another webpage
                        Response.Redirect("phonenumbers.aspx", true);
                    }

                }
            }



            
            
            
        }
    }
}