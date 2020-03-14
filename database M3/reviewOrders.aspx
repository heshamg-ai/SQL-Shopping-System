<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="reviewOrders.aspx.cs" Inherits="database_M3.reviewOrders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="font-size: large">
    <form id="form1" runat="server">
        <div>
            &nbsp;<asp:Button ID="cart2" runat="server" onclick="adm" Text="Back" Width="179px" />
            <br />
            <br />
        </div>
        <asp:GridView ID="GridView1" runat="server" Height="252px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" style="color: #CC6699; font-style: italic; font-weight: 700; background-color: #000066" Width="1090px">
        </asp:GridView>
    </form>
</body>
</html>
