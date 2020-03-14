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
    public partial class viewCart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("viewMyCart", conn);
            cmd.Parameters.Add(new SqlParameter("@customer", Session["usernameLog"]));
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
                 int serialno = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                 string pdescription = rdr.GetString(rdr.GetOrdinal("product_description"));
                  decimal pprice = rdr.GetDecimal(rdr.GetOrdinal("price"));
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
        protected void makeO(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("makeOrder", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@customername", Session["usernameLog"]));


            //Save the output from the procedure
            SqlParameter order_id = cmd.Parameters.Add("@order_id", SqlDbType.Int);
            order_id.Direction = ParameterDirection.Output;

            SqlParameter total_price = cmd.Parameters.Add("@totalprice", SqlDbType.Int);
            total_price.Direction = ParameterDirection.Output;

            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;



            //Executing the SQLCommand
            conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

            if (outp.Value.ToString()=="1")
            {
                 Response.Write("You don't have any products in your cart!");

            }
            else
            {
                Response.Write("Order ID: " + order_id.Value.ToString() + "\n");


                Response.Write("Total Price: " + total_price.Value.ToString());
            }

            


          




            

        }
        protected void specify(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("SpecifyAmount", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            // cmd.Parameters.Add(new SqlParameter("@customername", Session["usernameLog"]));
            //  cmd.Parameters.Add(new SqlParameter("@orderID", txt_orderid.Text));
            // cmd.Parameters.Add(new SqlParameter("@cash", txt_cash.Text));
            //cmd.Parameters.Add(new SqlParameter("@credit", txt_credit.Text));


            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;



            if (txt_orderid.Text == "")
            {
                Response.Write("<script>alert('Please enter order number')</script>");

            }
            else
            {

                if (txt_cash.Text != "")
                {
                    float cash = float.Parse(txt_cash.Text);
                    cmd.Parameters.Add(new SqlParameter("@cash", cash));

                }

                if (txt_credit.Text != "")
                {
                    float credit = float.Parse(txt_credit.Text);
                    cmd.Parameters.Add(new SqlParameter("@credit", credit));

                    //  Response.Write(credit);

                }

                if (txt_cash.Text == "")
                {
                    float cash = 0;
                    cmd.Parameters.Add(new SqlParameter("@cash", cash));

                }

                if (txt_credit.Text == "")
                {
                    float credit = 0;
                    cmd.Parameters.Add(new SqlParameter("@credit", credit));

                }


                cmd.Parameters.Add(new SqlParameter("@customername", Session["usernameLog"]));
                cmd.Parameters.Add(new SqlParameter("@orderID", txt_orderid.Text));





                if ((txt_cash.Text != "" && txt_credit.Text != "") | (txt_cash.Text == "" && txt_credit.Text == ""))
                {
                    Response.Write("<script>alert('You must specify only one payment type')</script>");

                }
                else
                {


                    //Executing the SQLCommand
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    if (outp.Value.ToString() == "1")
                    {
                        Response.Write("<script>alert('Sorry, you have specified amount of this order before!')</script>");

                    }
                    else
                    {

                        Response.Write("<script>alert('You have specified amount of this order successfully!')</script>");
                    }
                }
            }


        }
        protected void choose(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("ChooseCreditCard", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@creditcard", txt_creditcardnum.Text));
            cmd.Parameters.Add(new SqlParameter("@orderid", txt_order.Text));



            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;


            if (txt_creditcardnum.Text == "")
            {
                Response.Write("<script>alert('Please enter credit card number!')</script>");

            }
            else
            {
                if(txt_order.Text == "")
                {
                    Response.Write("<script>alert('Please enter order number!')</script>");

                }
                else
                {
                    //Executing the SQLCommand
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    if (outp.Value.ToString()=="1")
                    {
                        Response.Write("<script>alert('This credit card does not exist!')</script>");

                    }
                    else
                    {
                        if (outp.Value.ToString() == "2")
                        {
                            Response.Write("<script>alert('This order does not exist!')</script>");

                        }
                        else
                        {
                            Response.Write("<script>alert('Credit card choosed successfully!')</script>");

                        }
                    }
                }
            }


           

        }
        protected void removefromcart(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("removefromCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@customername", Session["usernameLog"]));
            cmd.Parameters.Add(new SqlParameter("@serial", txt_serialnum.Text));


            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            if (txt_serialnum.Text=="")
            {
                Response.Write("<script>alert('Please enter serial number!')</script>");

            }
            else
            {
                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (outp.Value.ToString() == "1")
                {
                    Response.Write("<script>alert('This product does not exist in your cart!')</script>");

                }
                else
                {
                    Response.Write("<script>alert('Product removed from your cart successfully!')</script>");

                }
            }

            

        }
        protected void redirec(object sender, EventArgs e)
        {
            Response.Redirect("showProducts.aspx",true);
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}