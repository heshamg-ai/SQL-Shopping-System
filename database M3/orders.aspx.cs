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
    public partial class orders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("reviewOrders", conn);



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
        }
    }
}