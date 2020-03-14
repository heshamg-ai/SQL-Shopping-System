<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="viewCart.aspx.cs" Inherits="database_M3.viewCart" %>

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
        <asp:Button ID="Button5" runat="server" Text="Back" onclick="redirec" Width="179px"/>
                   
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" Text="Make Order" onclick="makeO" Width="179px"/>
                   
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           
            <br />
            <br />
            <strong><span class="auto-style1"><em>Specify Amount of Order</em></span></strong><br />
            <br />
                   
        <asp:Label ID="lbl_username" runat="server" Text="Order ID: "></asp:Label>
        <asp:TextBox ID="txt_orderid" runat="server"></asp:TextBox>

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <asp:Label ID="Label1" runat="server" Text="Cash: "></asp:Label>
        <asp:TextBox ID="txt_cash" runat="server"></asp:TextBox>

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <asp:Label ID="Label2" runat="server" Text="Credit: "></asp:Label>
        <asp:TextBox ID="txt_credit" runat="server"></asp:TextBox>

         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

         <asp:Button ID="Button2" runat="server" Text="Specify Amount" onclick="specify" Width="179px"/>

            <br />
            <br />
            <br />
            <strong><em><span class="auto-style1">Choose Credit Card </span></em></strong>
            <br />
            <br />

            <asp:Label ID="Label3" runat="server" Text="Credit Card Number: "></asp:Label>
        <asp:TextBox ID="txt_creditcardnum" runat="server"></asp:TextBox>

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <asp:Label ID="Label4" runat="server" Text="Order ID: "></asp:Label>
        <asp:TextBox ID="txt_order" runat="server"></asp:TextBox>

         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

         <asp:Button ID="Button3" runat="server" Text="Choose Credit Card" onclick="choose" Width="179px"/>

            <br />
            <br />
            <br />
            <br />
            <strong><em><span class="auto-style1">Remove Product from Wishlist</span></em></strong><br />
            <br />
             <asp:Label ID="Label6" runat="server" Text="Serial Number: "></asp:Label>
            &nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txt_serialnum" runat="server"></asp:TextBox>    
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
            <asp:Button ID="Button4" runat="server" Text="Remove Product from my Cart" onclick="removefromcart" Width="252px"/>
            <br />
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server" Height="188px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" style="color: #CC6699; font-style: italic; font-weight: 700; background-color: #000066" Width="1470px">
            </asp:GridView>
            <br />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
