<%@ Page Title="White Sun Crafts | Manage: Statuses" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageProductStatuses.aspx.cs" Inherits="Secure_Admin_ManageProductStatuses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Manage: Statuses</h1>
    <div class="para-an">
        <h3>Manage Product Statuses</h3>
        <asp:Button ID="btnAdd" runat="server" Text="Add New Status" CssClass="btn btn-default pull-right" OnClick="btnAdd_Click" />
        <p>Use this panel to add and edit product status information.</p>
    </div>

    <asp:MultiView ID="mvStatuses" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwMaster" runat="server">
            <!--Master-->
            <asp:GridView ID="gvStatuses" runat="server" AutoGenerateColumns="False" DataKeyNames="WGProductStatusID" DataSourceID="dsStatuses" GridLines="Vertical" CellPadding="4" CssClass="table table-striped table-bordered" OnSelectedIndexChanged="gvStatuses_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="WGProductStatusID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="WGProductStatusID" />
                    <asp:TemplateField HeaderText="Name" ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select" Text='<%# Eval("Name") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsStatuses" runat="server" ConnectionString="<%$ ConnectionStrings:WGConnectionString %>" SelectCommand="SELECT [WGProductStatusID], [Name], [Description] FROM [WGProductStatuses]"></asp:SqlDataSource>

        </asp:View>

        <asp:View ID="vwDetails" runat="server">
            <!--Details-->
            <asp:FormView ID="fvSelectedStatus" runat="server" DataKeyNames="WGProductStatusID" DataSourceID="dsSelectedStatus" EnableViewState="false">
                <EditItemTemplate>
                    <table>
                        <tr>
                            <td>Name:</td>
                            <td>
                                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvName" ControlToValidate="NameTextBox" runat="server" ErrorMessage="*Name Required" CssClass="emphasize"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>Description:</td>
                            <td colspan="3">
                                <asp:TextBox ID="DescriptionTextBox" TextMode="MultiLine" Width="400px" Rows="5" runat="server" Text='<%# Bind("Description") %>' />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-default" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    <table>
                        <tr>
                            <td>Name:</td>
                            <td>
                                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvName" ControlToValidate="NameTextBox" runat="server" ErrorMessage="*Name Required" CssClass="emphasize"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>Description:</td>
                            <td colspan="3">
                                <asp:TextBox ID="DescriptionTextBox" TextMode="MultiLine" Width="400px" Rows="5" runat="server" Text='<%# Bind("Description") %>' />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Add" CssClass="btn btn-default" />
                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" OnClick="InsertCancelButton_Click" />
                </InsertItemTemplate>
                <ItemTemplate>
                    <table>
                        <tr>
                            <td>Name:</td>
                            <td>
                                <asp:Label ID="NameLabel" runat="server" Text='<%# Bind("Name") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Description:</td>
                            <td>
                                <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Bind("Description") %>' />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-default" />
                    &nbsp;<asp:Button ID="btnBack" runat="server" Text="Back to Statuses" CssClass="btn btn-default" OnClick="btnBack_Click" />
                </ItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="dsSelectedStatus" runat="server" ConnectionString="<%$ ConnectionStrings:WGConnectionString %>" DeleteCommand="DELETE FROM [WGProductStatuses] WHERE [WGProductStatusID] = @WGProductStatusID" InsertCommand="INSERT INTO [WGProductStatuses] ([Name], [Description]) VALUES (@Name, @Description)" SelectCommand="SELECT [WGProductStatusID], [Name], [Description] FROM [WGProductStatuses] WHERE ([WGProductStatusID] = @WGProductStatusID)" UpdateCommand="UPDATE [WGProductStatuses] SET [Name] = @Name, [Description] = @Description WHERE [WGProductStatusID] = @WGProductStatusID">
                <DeleteParameters>
                    <asp:Parameter Name="WGProductStatusID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvStatuses" Name="WGProductStatusID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="WGProductStatusID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>

        </asp:View>
    </asp:MultiView>
    <br />
    <br />
</asp:Content>

