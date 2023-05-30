<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ASPVulnerableLab.Account.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <asp:PlaceHolder ID="LoginFormPage" runat="server">
        <form id="Form1"  method="post" runat="server" >
        <table> 
        <tr><td>UserName: </td><td><asp:TextBox Id="Username" runat="server" name="username"/></td><td><span id="status"></span></td></tr>
        <tr><td>Password :</td><td><asp:TextBox id="Password" runat="server" type="password" name="password"/></td></tr>
        protected void ChangeSecretButton_Click(object sender, EventArgs e)
        {
            StringBuilder html = new StringBuilder();

            string constr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (var conn = new SqlConnection(constr))
            {
                conn.Open();
                if (Session["user_id"] != null)
                {
                    int user_id = (Int32)Session["user_id"];
                    string updSql = @"UPDATE users SET secret = '" + NewSecret.Text + "' where id=" + user_id;
                    using (var cmd = new SqlCommand(updSql, conn))
                    {
                        if (cmd.ExecuteNonQuery() > 0)
                        {
                            html.Append("<b style='color:green'>Updated</b>");
                        }
                        else
                        {
                            html.Append("<b style='color:red'>No changes made</b>");
                        }
                    }
                }
                else
                {
                    html.Append("<b style='color:red'>Login before to change the password</b>");
                }
            }

            ChangeSecretStatus.Controls.Add(new Literal { Text = html.ToString() });
        }
         <tr><td><asp:button ID="Button1" runat="server" Text="Login" onclick="LoginButton_Click"/></td></tr>
        </table>  
        </form>
    </asp:PlaceHolder>
</asp:Content>
