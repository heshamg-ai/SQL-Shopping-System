using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;


namespace database_M3
{
    public partial class admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void activate(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("activateVendors", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@admin_username", Session["usernameLog"]));
            cmd.Parameters.Add(new SqlParameter("@vendor_username", txt_vendorUsername.Text));

            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;


            if (txt_vendorUsername.Text=="")
            {
                Response.Write("<script>alert('Please enter vendor username!')</script>");

            }
            else
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (outp.Value.ToString() == "1")
                {
                    Response.Write("<script>alert('This vendor is already activated by an admin!')</script>");

                }
                else
                {
                    if (outp.Value.ToString() == "2")
                    {
                        Response.Write("<script>alert('This vendor does not exist!')</script>");

                    }
                    else
                    {
                        Response.Write("<script>alert('You have activated this vendor successfully!')</script>");

                    }

                }

            }

            


        }
        protected void updateorder(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("updateOrderStatusInProcess", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@order_no", txt_orderid.Text));


            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            if (txt_orderid.Text == "")
            {
                Response.Write("<script>alert('Please enter order number!')</script>");

            }
            else
            {
                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    if (outp.Value.ToString() == "1")
                    {
                        Response.Write("<script>alert('This order does not exist!')</script>");

                    }
                    else
                    {
                        Response.Write("<script>alert('Order status updated successfully!')</script>");

                    }
                }
                catch (Exception)
                {
                    Response.Write("<script>alert('Please enter a valid order number!')</script>");

                }


            }

            

        }
        protected void createdeal(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("createTodaysDeal", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@deal_amount", txt_amount.Text));
            cmd.Parameters.Add(new SqlParameter("@admin_username", Session["usernameLog"]));

            cmd.Parameters.Add(new SqlParameter("@expiry_date", txt_date.Text));

            if (txt_amount.Text == "")
            {
                Response.Write("<script>alert('Please enter deal amount')</script>");

            }
            else
            {
                if(txt_date.Text == "")
                {
                    Response.Write("<script>alert('Please enter expiry date')</script>");

                }
                else
                {
                    try
                    {


                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                        Response.Write("Today's Deal created successfully");
                    }
                    catch (Exception)
                    {
                        Response.Write("<script>alert('Please enter correct format of date : MM/DD/YYYY or a valid deal amount!')</script>");

                    }
                }
            }

        }
        protected void add(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addTodaysDealOnProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@deal_id", txt_deal.Text));
            cmd.Parameters.Add(new SqlParameter("@serial_no", txt_serial.Text));

            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;



            if (txt_deal.Text == "")
            {
                Response.Write("<script>alert('Please enter deal id')</script>");

            }
            else
            {
                if (txt_serial.Text == "")
                {
                    Response.Write("<script>alert('Please enter serial number')</script>");

                }
                else
                {
                    try
                    {

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                        Response.Write(outp.Value.ToString());

                        if (outp.Value.ToString() == "1")
                        {
                            Response.Write("<script>alert('This product has already an active offer!')</script>");
                        }
                        else
                        {
                            if (outp.Value.ToString() == "2")
                            {
                                Response.Write("<script>alert('This product does not exist!')</script>");

                            }
                            else
                            {
                                if (outp.Value.ToString() == "3")
                                {
                                    Response.Write("<script>alert('This offer does not exist!')</script>");

                                }
                                else
                                {
                                    if (outp.Value.ToString() == "4")
                                    {
                                        Response.Write("<script>alert('Sorry, this offer has already expired!')</script>");

                                    }
                                    else
                                    {
                                        Response.Write("<script>alert('Offer is added successfully to the product!')</script>");

                                    }


                                }

                            }
                        }
                    }
                    catch (Exception)
                    {
                        Response.Write("<script>alert('Please insert a valid deal number or serial number!')</script>");

                    }



                }
            }

        }
        protected void remove(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("removeExpiredDeal", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@deal_iD", txt_id.Text));

            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            if (txt_id.Text == "")
            {
                Response.Write("<script>alert('Please enter today deal!')</script>");

            }
            else
            {
                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    if (outp.Value.ToString().Equals("1"))
                    {
                        Response.Write("<script>alert('Today Deal is removed successfuly!')</script>");

                    }
                    else
                    {
                        if (outp.Value.ToString().Equals("2"))
                        {
                            Response.Write("<script>alert('Today Deal is not expired!')</script>");

                        }
                        else
                        {
                            Response.Write("<script>alert('Today Deal does not exist!')</script>");

                        }
                    }
                }
                catch (Exception)
                {
                    Response.Write("<script>alert('Please insert a valid deal number!')</script>");

                }
            }



        }
        protected void logout(object sender, EventArgs e)
        {
            Response.Redirect("userLogin.aspx", true);

        }
        protected void revOrd(object sender, EventArgs e)
        {
            Response.Redirect("reviewOrders.aspx", true);

        }




    }
}