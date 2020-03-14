<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="viewWish.aspx.cs" Inherits="database_M3.viewWish" %>

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

            <br />

            <strong><em><span class="auto-style1">
            <br />
            Remove Product from Wishlist</span></em></strong><br />
            <br />
            <asp:Label ID="Label5" runat="server" Text="WishList name: "></asp:Label>
             &nbsp;&nbsp;&nbsp;
             <asp:TextBox ID="txt_wishname1" runat="server"></asp:TextBox>    
              &nbsp;&nbsp;&nbsp;    
              <asp:Label ID="Label6" runat="server" Text="Serial Number: "></asp:Label>
            &nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txt_serialnum" runat="server"></asp:TextBox>    
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
            <asp:Button ID="Button2" runat="server" Text="Remove Product from Wishlist" onclick="removefromwish" Width="252px"/>
            <br />
            <br />
            <br />
        </div>
        <asp:GridView ID="GridView1" runat="server" Height="235px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" style="color: #CC6699; font-style: italic; font-weight: 700; background-color: #000066" Width="1470px">
        </asp:GridView>
    </form>
</body>
</html>
