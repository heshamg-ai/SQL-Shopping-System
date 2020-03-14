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
    public partial class phonenumbers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void phone(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addMobile", conn);
            cmd.CommandType = CommandType.StoredProcedure;



            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", Session["usernameReg"]));
            cmd.Parameters.Add(new SqlParameter("@mobile_number", txt_phoneNumber.Text));

            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            if (txt_phoneNumber.Text == "")
            {
                Response.Write("<script>alert('Please enter phone number!')</script>");

            }
            else
            {

                try
                {
                    //Executing the SQLCommand
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    if (outp.Value.ToString() == "1")
                    {
                        Response.Write("<script>alert('Sorry, you have entered this phone number before!')</script>");

                    }
                    else { 
                    Response.Write("<script>alert('Phone is added successfully!')</script>");
                         }

                }
                catch (Exception)
                {
                    Response.Write("<script>alert('Sorry, please enter a phone number!')</script>");

                }
            }

        }
        protected void login(object sender, EventArgs e)
        {
            Response.Redirect("userLogin.aspx", true);
        }

    }
}