<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="showProducts.aspx.cs" Inherits="database_M3.showProducts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            font-size: xx-large;
        }
    </style>
</head>
<body>
    

    <form id="form1" runat="server">
        <div>


            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


            <asp:Button ID="cart" runat="server" Text="My Cart" onclick="gocart" Width="179px"/>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button1" runat="server" Text="My Wishlists" onclick="gotowishlist" Width="179px"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;


            <asp:Button ID="cart0" runat="server" Text="Log Out" onclick="logout" Width="179px"/>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
            <br />
            <strong><em><span class="auto-style1">Create Wishlist</span></em></strong><br />
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   
            
            
            <asp:Label ID="lbl_password" runat="server" Text="WishList name: "></asp:Label>
       
            
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       
            
          <asp:TextBox ID="txt_wishname" runat="server"></asp:TextBox>    
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
          <asp:Button ID="Button3" runat="server" Text="Create Wishlist" onclick="createwish" Width="179px"/>


             <br />
            <br />
            <strong><em><span class="auto-style1">Add Product in Wishlist </span></em></strong>


             <br />
            <br />


             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


             <asp:Label ID="Label5" runat="server" Text="WishList name: "></asp:Label>
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <asp:TextBox ID="txt_wishname1" runat="server"></asp:TextBox>    
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
              <asp:Label ID="Label6" runat="server" Text="Serial Number: "></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txt_serialnum" runat="server"></asp:TextBox>    
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
            <asp:Button ID="Button2" runat="server" Text="Add Product in Wishlist" onclick="addinwish" Width="179px"/> 
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
            <br />
            <strong><em><span class="auto-style1">Add Product in Cart </span></em></strong>
            <br />
            <br />
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

           <asp:Label ID="Label1" runat="server" Text="Serial number: "></asp:Label>
       
            
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       
            
          <asp:TextBox ID="txt_serial" runat="server"></asp:TextBox>    
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
          <asp:Button ID="Button4" runat="server" Text="Add product in Cart" onclick="addproductinCart" Width="179px"/>


            &nbsp;


            <br />
            <br />


            <br />
            <strong><em><span class="auto-style1">Add Credit Card</span></em></strong><br />
            <br />


           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


           <asp:Label ID="Label2" runat="server" Text="Credit Card Number: "></asp:Label>  
          &nbsp;<asp:TextBox ID="txt_number" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label3" runat="server" Text="Expiry Date: "></asp:Label>  
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
          <asp:TextBox ID="txt_date" runat="server"></asp:TextBox>    
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
            <asp:Label ID="Label4" runat="server" Text="CVV Code: "></asp:Label>  
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
          <asp:TextBox ID="txt_cvvcode" runat="server"></asp:TextBox>    
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
          <asp:Button ID="Button5" runat="server" Text="Add Credit Card" onclick="addcreditcard" Width="179px"/>


        &nbsp;&nbsp;&nbsp;<br />
            <br />
            <strong><em><span class="auto-style1">Cancel Order </span></em></strong>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <asp:Label ID="Label7" runat="server" Text="orederID: "></asp:Label>  
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
          <asp:TextBox ID="txt_orderID" runat="server"></asp:TextBox>    
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
          <asp:Button ID="Button6" runat="server" Text="cancel order" onclick="cancelO" Width="179px"/>

            
            <br />
            <br />
            <strong><em><span class="auto-style1">Products :
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server" Height="16px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" style="color: #CC6699; font-style: italic; font-weight: 700; font-size: x-large; background-color: #000066" Width="848px">
            </asp:GridView>
            </span></em></strong>
            <br />

            
        </div>
    </form>


    <p>
        &nbsp;<p>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>


</body>
</html>