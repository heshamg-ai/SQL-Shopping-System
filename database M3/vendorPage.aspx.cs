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
    public partial class vendorPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("vendorviewProducts", conn);
            cmd.Parameters.Add(new SqlParameter("@vendorname", Session["usernameLog"]));
            cmd.CommandType = CommandType.StoredProcedure;


            conn.Open();

            using (SqlDataReader reader = cmd.ExecuteReader())
            {
                GridView1.DataSource = reader;
                GridView1.DataBind();
            }
            conn.Close();

            /*  conn.Open();


              SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
              while (rdr.Read())
              {

                  //Get the value of the attribute name in the Company table
                  string pname = rdr.GetString(rdr.GetOrdinal("product_name"));
                  //Get the value of the attribute field in the Company table
                  int serialno = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                  string pdescription = rdr.GetString(rdr.GetOrdinal("product_description"));
                  decimal pprice = rdr.GetDecimal(rdr.GetOrdinal("price"));
                  decimal pfinalprice = rdr.GetDecimal(rdr.GetOrdinal("final_price"));
                  string pcolor = rdr.GetString(rdr.GetOrdinal("color"));
                  string category = rdr.GetString(rdr.GetOrdinal("category"));


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

                  Label lbl_category = new Label();
                  lbl_category.Text = "Category:" + category + "  <br /> <br />";
                  form1.Controls.Add(lbl_category);









              }
              //this is how you retrive data from session variable.
              string field1 = (string)(Session["field1"]);
              Response.Write(field1);
              conn.Close();
              */





        }


        protected void Post(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("postProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@vendorUsername", Session["usernameLog"]));
            cmd.Parameters.Add(new SqlParameter("@product_name", pnam.Text));
            cmd.Parameters.Add(new SqlParameter("@category", cat1.Text));
            cmd.Parameters.Add(new SqlParameter("@product_description", des1.Text));
            cmd.Parameters.Add(new SqlParameter("@price", pric1.Text));
            cmd.Parameters.Add(new SqlParameter("@color", col1.Text));


            if (pnam.Text == "" | cat1.Text == "" | des1.Text == "" | pric1.Text == "" | col1.Text == "")
            {
                Response.Write("<script>alert('Please make sure to enter all details of the product!')</script>");

            }
            else
            {
                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();



                Response.Write("<script>alert('Product successfully added!')</script>");
            }

        }

        protected void Edit(object sender, EventArgs e)
        {

            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("EditProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            double price = 0;
            




            if (productn1.Text == "")
            {
                cmd.Parameters.Add(new SqlParameter("@product_name", "no"));

            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@product_name", productn1.Text));

            }

            if (cat12.Text == "")
            {
                cmd.Parameters.Add(new SqlParameter("@category", "no"));
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@category", cat12.Text));
            }
            if (desc1.Text == "")
            {
                cmd.Parameters.Add(new SqlParameter("@product_description", "no"));
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@product_description", desc1.Text));
            }
            if (price77.Text == "")
            {
                cmd.Parameters.Add(new SqlParameter("@price", price));

            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@price", price77.Text));

            }
            if (color776.Text == "")
            {
                cmd.Parameters.Add(new SqlParameter("@color", "no"));
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@color", color776.Text));
            }



            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@vendorname", Session["usernameLog"]));
            cmd.Parameters.Add(new SqlParameter("@serialnumber", serial1.Text));

            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;





            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            if (outp.Value.ToString() == "1")
            {
                Response.Write("<script>alert('Please enter serial number!')</script>");

            }
            else
            {
                Response.Write("<script>alert('You have edited the product successfully!')</script>");

            }






        }

        protected void category_TextChanged(object sender, EventArgs e)
        {


        }

        protected void color_TextChanged(object sender, EventArgs e)
        {

        }
        protected void logout(object sender, EventArgs e)
        {
            Response.Redirect("userLogin.aspx", true);

        }
        protected void createoffer(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addOﬀer", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@oﬀeramount", txt_offer.Text));
            cmd.Parameters.Add(new SqlParameter("@expiry_date", txt_date.Text));

           


            if (txt_offer.Text == "")
            {
                Response.Write("<script>alert('Please enter offer amount!')</script>");

            }
            else
            {
                if (txt_date.Text == "")
                {
                    Response.Write("<script>alert('Please enter expiry date!')</script>");

                }
                else
                {
                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                        
                        Response.Write("<script>alert('Offer is created successfully!')</script>");
                    }
                    catch
                    {
                        Response.Write("<script>alert('Please enter correct format of date : MM/DD/YYYY or a valid offer amount!')</script>");

                    }


                }

            }
        }
        protected void applyoffer(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("applyOﬀer", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@vendorname", Session["usernameLog"]));
            cmd.Parameters.Add(new SqlParameter("@oﬀerid", txt_offer1.Text));
            cmd.Parameters.Add(new SqlParameter("@serial", txt_date1.Text));

            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            if (txt_offer1.Text == "")
            {
                Response.Write("<script>alert('Please enter offer number!')</script>");

            }
            else
            {
                if (txt_date1.Text == "")
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
                        Response.Write("<script>alert('Please insert a valid offer number or serial number!')</script>");

                    }
                }
            }


        }
        protected void removeOffer(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("checkandremoveExpiredoﬀer", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@oﬀerid", txt_offerid.Text));

            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            if (txt_offerid.Text == "")
            {
                Response.Write("<script>alert('Please enter offer number!')</script>");

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
                        Response.Write("<script>alert('Offer is removed successfuly!')</script>");

                    }
                    else
                    {
                        if (outp.Value.ToString().Equals("2"))
                        {
                            Response.Write("<script>alert('Offer is not expired!')</script>");

                        }
                        else
                        {
                            Response.Write("<script>alert('Offer does not exist!')</script>");

                        }
                    }
                }
                catch (Exception)
                {
                    Response.Write("<script>alert('Please insert a valid offer number!')</script>");

                }
            }


        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}