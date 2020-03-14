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
    public partial class viewWish : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("showProductsinAllWishlists",conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@customername", Session["usernameLog"]));


                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    GridView1.DataSource = reader;
                    GridView1.DataBind();
                }
                conn.Close();
            }




          /*  SqlCommand cmd = new SqlCommand("showProductsinAllWishlists", conn);
            cmd.Parameters.Add(new SqlParameter("@customername", Session["usernameLog"]));

          

            cmd.CommandType = System.Data.CommandType.StoredProcedure;

           

            conn.Open();


            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);


             while (rdr.Read())
             {

                 string pname = rdr.GetString(rdr.GetOrdinal("product_name"));
                 string pdescription = rdr.GetString(rdr.GetOrdinal("product_description"));
                 decimal pprice = rdr.GetDecimal(rdr.GetOrdinal("price"));
                 int serialno = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                 decimal pfinalprice = rdr.GetDecimal(rdr.GetOrdinal("final_price"));
                 string pcolor = rdr.GetString(rdr.GetOrdinal("color"));
                 string wname = rdr.GetString(rdr.GetOrdinal("wish_name"));


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

                 Label lbl_wname = new Label();
                 lbl_wname.Text = "WishList Name:" + wname + "  <br /> <br />";
                 form1.Controls.Add(lbl_wname);




             }
             //this is how you retrive data from session variable.
             string field1 = (string)(Session["field1"]);
             Response.Write(field1);
             conn.Close();
             */
             




        }
        protected void removefromwish(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("removefromWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@customername", Session["usernameLog"]));
            cmd.Parameters.Add(new SqlParameter("@wishlistname", txt_wishname1.Text));
            cmd.Parameters.Add(new SqlParameter("@serial", txt_serialnum.Text));

            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            if (txt_wishname1.Text == "")
            {
                Response.Write("<script>alert('Please enter wishlist name')</script>");

            }
            else
            {
                if (txt_serialnum.Text == "")
                {
                    Response.Write("<script>alert('Please enter serial number')</script>");

                }
                else
                {
                    //Executing the SQLCommand
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    if (outp.Value.ToString()=="1")
                    {
                        Response.Write("<script>alert('You do not have this wishlist!')</script>");

                    }
                    else
                    {
                        if (outp.Value.ToString() == "2")
                        {
                            Response.Write("<script>alert('This product does not exist in this wishlist!')</script>");

                        }
                        else
                        {
                            Response.Write("<script>alert('Product removed succesfully from this wishlist!')</script>");

                        }
                    }
                }
            }

            
               
           
                
        }
        protected void redirec(object sender, EventArgs e)
        {
            Response.Redirect("showProducts.aspx", true);
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}