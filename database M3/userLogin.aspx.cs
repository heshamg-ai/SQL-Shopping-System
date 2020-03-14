using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;

namespace database_M3
{
    public partial class userLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }
        protected void login(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("userLogin", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", txt_username.Text));
            cmd.Parameters.Add(new SqlParameter("@password", txt_password.Text));

            //Save the output from the procedure
            SqlParameter success = cmd.Parameters.Add("@success", SqlDbType.Bit);
            success.Direction = ParameterDirection.Output;

            SqlParameter type = cmd.Parameters.Add("@type", SqlDbType.Int);
            type.Direction = ParameterDirection.Output;

         if(txt_username.Text == "" && txt_password.Text == "")
            {
                Response.Write("<script>alert('Please enter username and password!')</script>");

            }
            else {



                if (txt_username.Text == "")
                {
                    Response.Write("<script>alert('Please enter username!')</script>");

                }
                else
                {
                    if (txt_password.Text == "")
                    {
                        Response.Write("<script>alert('Please enter password!')</script>");

                    }

                    else
                    {
                        //Executing the SQLCommand
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();

                        if (success.Value.ToString().Equals("True"))
                        {

                            Session["usernameLog"] = txt_username.Text;

                            //To navigate to another webpage
                            //  if(type.Value==)
                            if (type.Value.ToString().Equals("0"))
                            {
                                Response.Redirect("showProducts.aspx", true);
                            }
                            else
                            {
                                if (type.Value.ToString().Equals("1"))
                                {
                                    Response.Redirect("vendorPage.aspx", true);
                                }
                                else
                                {
                                    if (type.Value.ToString().Equals("2"))
                                    {
                                        Response.Redirect("admin.aspx", true);
                                    }
                                }
                            }

                        }
                        else
                        {
                            Response.Write("<script>alert('Username or password is incorrect')</script>");


                        }
                    }
                }
            }



        }
        protected void reg(object sender, EventArgs e)
        {
            Response.Redirect("customerVendorRegister.aspx", true);

        }



    }
}