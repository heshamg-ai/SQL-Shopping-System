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
    public partial class reviewOrders : System.Web.UI.Page
    {
        
            protected void Page_Load(object sender, EventArgs e)
            {
                string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand cmd = new SqlCommand("reviewOrders", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    GridView1.DataSource = reader;
                    GridView1.DataBind();
                }
                conn.Close();

            /* conn.Open();

             //IF the output is a table, then we can read the records one at a time
             SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
             while (rdr.Read())
             {
                 int orderno = rdr.GetInt32(rdr.GetOrdinal("order_no"));
                 DateTime orderdate = rdr.GetDateTime(rdr.GetOrdinal("order_date"));
                 decimal totalamount = rdr.GetDecimal(rdr.GetOrdinal("total_amount"));
                 decimal cashamount = rdr.GetDecimal(rdr.GetOrdinal("cash_amount"));
                 decimal creditamount = rdr.GetDecimal(rdr.GetOrdinal("credit_amount"));
                 string paymenttype = rdr.GetString(rdr.GetOrdinal("payment_type"));
                 string orderstatus = rdr.GetString(rdr.GetOrdinal("order_status"));
                 int remainingdays = rdr.GetInt32(rdr.GetOrdinal("remaining_days"));
                 string timelimit = rdr.GetString(rdr.GetOrdinal("time_limit"));
                 int deliveryid = rdr.GetInt32(rdr.GetOrdinal("delivery_id"));
                 string creditnum = rdr.GetString(rdr.GetOrdinal("creditcard_number"));
                 string cname = rdr.GetString(rdr.GetOrdinal("customer_name"));



                 Label lbl_order_no = new Label();
                 lbl_order_no.Text = orderno + " < br > < /br > ";
                 form1.Controls.Add(lbl_order_no);

                 Label lbl_order_date = new Label();
                 lbl_order_date.Text = orderdate + " < br > < /br > ";
                 form1.Controls.Add(lbl_order_date);

                 Label lbl_total_amount = new Label();
                 lbl_total_amount.Text = totalamount + " < br > < /br > ";
                 form1.Controls.Add(lbl_total_amount);

                 Label lbl_cash_amount = new Label();
                 lbl_cash_amount.Text = cashamount + " < br > < /br > ";
                 form1.Controls.Add(lbl_cash_amount);

                 Label lbl_credit_amount = new Label();
                 lbl_credit_amount.Text = creditamount + " < br > < /br > ";
                 form1.Controls.Add(lbl_credit_amount);

                 Label lbl_payment_type = new Label();
                 lbl_payment_type.Text = paymenttype + " < br > < /br > ";
                 form1.Controls.Add(lbl_payment_type);

                 Label lbl_order_status = new Label();
                 lbl_order_status.Text = orderstatus + " < br > < /br > ";
                 form1.Controls.Add(lbl_order_status);


                 Label lbl_remaining_days = new Label();
                 lbl_remaining_days.Text = remainingdays + " < br > < /br > ";
                 form1.Controls.Add(lbl_remaining_days);



                 Label lbl_time_limit = new Label();
                 lbl_time_limit.Text = timelimit + " < br > < /br > ";
                 form1.Controls.Add(lbl_time_limit);

                 Label lbl_delivery_id = new Label();
                 lbl_delivery_id.Text = deliveryid + " < br > < /br > ";
                 form1.Controls.Add(lbl_delivery_id);


                 Label lbl_credit_num = new Label();
                 lbl_credit_num.Text = creditnum + " < br > < /br > ";
                 form1.Controls.Add(lbl_credit_num);

                 Label lbl_cname = new Label();
                 lbl_cname.Text = cname + " < br > < /br > ";
                 form1.Controls.Add(lbl_cname);



             }
             //this is how you retrive data from session variable.
             string field1 = (string)(Session["field1"]);
             Response.Write(field1);
             conn.Close();
             */



        }
        
        protected void adm(object sender, EventArgs e)
        {
            Response.Redirect("admin.aspx", true);
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }


}