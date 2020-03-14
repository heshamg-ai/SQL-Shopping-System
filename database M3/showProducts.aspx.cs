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
    public partial class showProducts : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("showProducts", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            conn.Open();

            using (SqlDataReader reader = cmd.ExecuteReader())
            {
                GridView1.DataSource = reader;
                GridView1.DataBind();
            }
            conn.Close();

            /* SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
             while (rdr.Read())
             {
                 //Get the value of the attribute name in the Company table
                 string pname = rdr.GetString(rdr.GetOrdinal("product_name"));
                 //Get the value of the attribute field in the Company table
                 string pdescription = rdr.GetString(rdr.GetOrdinal("product_description"));
                 decimal pprice = rdr.GetDecimal(rdr.GetOrdinal("price"));
                 int serialno = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                 decimal pfinalprice = rdr.GetDecimal(rdr.GetOrdinal("final_price"));
                 string pcolor = rdr.GetString(rdr.GetOrdinal("color"));


                 //Create a new label and add it to the HTML form
                 Label lbl_serialno = new Label();
                 lbl_serialno.Text = "Serial Number:" + serialno + "  <br /> <br />";
                 form1.Controls.Add(lbl_serialno);



                 Label lbl_pname = new Label();
                 lbl_pname.Text = "Product Name:" + pname + "  <br /> <br />";
                 form1.Controls.Add(lbl_pname);


                 Label lbl_pdescription = new Label();
                 lbl_pdescription.Text = "Product Description:" + pdescription + "  <br /> <br />";
                 form1.Controls.Add(lbl_pdescription);


                 Label lbl_pprice = new Label();
                 lbl_pprice.Text = "Price:" + pprice + "  <br /> <br />";
                 form1.Controls.Add(lbl_pprice);

                 Label lbl_pfinalprice = new Label();
                 lbl_pfinalprice.Text = "Final Price:" + pfinalprice + "  <br /> <br />";
                 form1.Controls.Add(lbl_pfinalprice);

                 Label lbl_pcolor = new Label();
                 lbl_pcolor.Text = "Color:" + pcolor + "  <br /> <br />";
                 form1.Controls.Add(lbl_pcolor);






             }
             //this is how you retrive data from session variable.
             string field1 = (string)(Session["field1"]);
             Response.Write(field1);
             conn.Close();
             */



        }
        protected void createwish(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("createWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@customername", Session["usernameLog"]));
            cmd.Parameters.Add(new SqlParameter("@name", txt_wishname.Text));

            if (txt_wishname.Text == "")
            {
                Response.Write("<script>alert('Please enter wishlist name!')</script>");

            }
            else
            {
                try
                {
                    conn.Open();

                    cmd.ExecuteNonQuery();
                    conn.Close();
                    Response.Write("<script>alert('WishList created succesfully')</script>");



                }
                catch (Exception)
                {
                    Response.Write("<script>alert('Wishlist name used before. Please try another one!')</script>");

                }
            }




        }
        protected void gotowishlist(object sender, EventArgs e)
        {
            Response.Redirect("viewWish.aspx", true);
        }

        protected void addproductinCart(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addToCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@customername", Session["usernameLog"]));
            cmd.Parameters.Add(new SqlParameter("@serial", txt_serial.Text));



            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            if (txt_serial.Text == "")
            {
                Response.Write("<script>alert('Please enter serial number!')</script>");

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
                        Response.Write("<script>alert('This product does not exist!')</script>");

                    }
                    else {
                        if (outp.Value.ToString() == "2")
                        {
                            Response.Write("<script>alert('This product is not available!')</script>");

                        }
                        else
                        {
                            if (outp.Value.ToString() == "3")
                            {
                                Response.Write("<script>alert('Sorry you have added this product in your cart before!')</script>");

                            }
                            else
                            {
                                Response.Write("<script>alert('Product is added successfully to your Cart!')</script>");

                            }

                        }
                    }
                }
                catch (Exception)
                {
                    Response.Write("<script>alert('Please insert a valid serial number!')</script>");

                }
            }

        }

        protected void addcreditcard(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("AddcreditCard", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@number", txt_number.Text));
            cmd.Parameters.Add(new SqlParameter("@expiry_date", txt_date.Text));
            cmd.Parameters.Add(new SqlParameter("@cvv_code", txt_cvvcode.Text));

            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            if (txt_number.Text == "")
            {
                Response.Write("<script>alert('Please enter credit card number!')</script>");

            }
            else
            {
                if (txt_date.Text == "")
                {
                    Response.Write("<script>alert('Please enter expiry date!')</script>");

                }
                else
                {
                    if (txt_cvvcode.Text == "")
                    {
                        Response.Write("<script>alert('Please enter CVV code!')</script>");

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
                                Response.Write("<script>alert('This credit card is already existing!')</script>");

                            }
                            else
                            {
                                Response.Write("<script>alert('Credit Card is added successfully!')</script>");

                            }
                        }
                        catch (Exception)
                        {
                            Response.Write("<script>alert('Please enter correct format of date : MM / DD / YYYY!')</script>");

                        }
                    }
                }
            }
        }
        protected void gocart(object sender, EventArgs e)
        {
            Response.Redirect("viewCart.aspx", true);
        }
        protected void addinwish(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("AddtoWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@customername", Session["usernameLog"]));
            cmd.Parameters.Add(new SqlParameter("@wishlistname", txt_wishname1.Text));
            cmd.Parameters.Add(new SqlParameter("@serial", txt_serialnum.Text));


            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            if (txt_wishname1.Text == "" && txt_serialnum.Text == "")
            {
                Response.Write("<script>alert('Please enter wishlist name and serial number!')</script>");

            }
            else
            {

                if (txt_wishname1.Text == "")
                {
                    Response.Write("<script>alert('Please enter wishlist name!')</script>");

                }
                else
                {
                    if (txt_serialnum.Text == "")
                    {
                        Response.Write("<script>alert('Please enter serial number!')</script>");

                    }
                    else
                    {
                        //Executing the SQLCommand
                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            conn.Close();
                            // Response.Redirect("showProducts.aspx", true);
                            if (outp.Value.ToString() == "1")
                            {
                                Response.Write("<script>alert('You have added this product in this wishlist before!')</script>");

                            }
                            else
                            {
                                if (outp.Value.ToString() == "2")
                                {
                                    Response.Write("<script>alert('This wishlist does not exist!')</script>");

                                }
                                else
                                {
                                    if (outp.Value.ToString() == "3")
                                    {
                                        Response.Write("<script>alert('This product does not exist!')</script>");

                                    }
                                    else
                                    {
                                        Response.Write("<script>alert('Product is added successfully to this wishlist!')</script>");

                                    }
                                }
                            }
                        }
                        catch (Exception)
                        {
                            Response.Write("<script>alert('Please enter a valid serial number!')</script>");

                        }






                    }
                }
            }

        }


        protected void cancelO(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("cancelOrder", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@orderid", txt_orderID.Text));

            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            if (txt_orderID.Text == "")
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
                    if (outp.Value.ToString() == "3")
                    {
                        Response.Write("<script>alert('This order does not exist!')</script>");

                    }
                    else
                    {
                        if (outp.Value.ToString() == "2")
                        {
                            Response.Write("<script>alert('The order is delivered already!')</script>");

                        }
                        else
                        {


                            if (outp.Value.ToString() == "1")
                            {
                                Response.Write("<script>alert('Sorry, the order is out for delivery!')</script>");

                            }
                            else
                            {
                                Response.Write("<script>alert('The order is canceled successfully')</script>");

                            }
                        }
                    }
                }
                catch (Exception)
                {
                    Response.Write("<script>alert('Please enter a valid order number')</script>");

                }
            }   }
     
           


        
        protected void logout(object sender, EventArgs e)
        {
            Response.Redirect("userLogin.aspx", true);

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }

}