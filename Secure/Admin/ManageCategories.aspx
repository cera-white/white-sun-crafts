<%@ Page Title="White Sun Crafts | Manage: Categories" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageCategories.aspx.cs" Inherits="Secure_Admin_ManageCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Manage: Categories</h1>
    <div class="para-an">
        <h3>Manage Categories</h3>
        <asp:Button ID="btnAdd" runat="server" Text="Add New Category" CssClass="btn btn-default pull-right" OnClick="btnAdd_Click" />
        <p>Use this panel to add and edit category information.</p>
    </div>

    <asp:MultiView ID="mvCategories" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwMaster" runat="server">
            <!--Master-->
            <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="False" DataKeyNames="WGCategoryID" DataSourceID="dsCategories" GridLines="Vertical" CellPadding="4" CssClass="table table-striped table-bordered" OnSelectedIndexChanged="gvCategories_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="WGCategoryID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="WGCategoryID" />
                    <asp:TemplateField HeaderText="Name" ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select" Text='<%# Eval("Name") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:TemplateField HeaderText="Active" SortExpression="IsActive">
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("IsActive") %>' />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("IsActive") %>' Enabled="false" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsCategories" runat="server" ConnectionString="<%$ ConnectionStrings:WGConnectionString %>" SelectCommand="SELECT [WGCategoryID], [Name], [Description], [IsActive] FROM [WGCategories] ORDER BY [Name]"></asp:SqlDataSource>

        </asp:View>

        <asp:View ID="vwDetails" runat="server">
            <!--Details-->
            <asp:FormView ID="fvSelectedCategory" runat="server" DataKeyNames="WGCategoryID" DataSourceID="dsSelectedCategory" EnableViewState="false">
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
                        <tr>
                            <td>
                                <asp:CheckBox ID="IsActiveCheckBox" runat="server" Checked='<%# Bind("IsActive") %>' />
                                Active?
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
                        <tr>
                            <td>
                                <asp:CheckBox ID="IsActiveCheckBox" runat="server" Checked='<%# Bind("IsActive") %>' />
                                Active?
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
                        <tr>
                            <td>
                                <asp:CheckBox ID="IsActiveCheckBox" runat="server" Checked='<%# Bind("IsActive") %>' Enabled="false" />
                                Active?
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit Category" CssClass="btn btn-default" />
                    <asp:Button ID="btnBack" runat="server" Text="Back to Categories" CssClass="btn btn-default" OnClick="btnBack_Click" />
                </ItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="dsSelectedCategory" runat="server" ConnectionString="<%$ ConnectionStrings:WGConnectionString %>" DeleteCommand="DELETE FROM [WGCategories] WHERE [WGCategoryID] = @WGCategoryID" InsertCommand="INSERT INTO [WGCategories] ([Name], [Description], [IsActive]) VALUES (@Name, @Description, @IsActive)" SelectCommand="SELECT [WGCategoryID], [Name], [Description], [IsActive] FROM [WGCategories] WHERE ([WGCategoryID] = @WGCategoryID)" UpdateCommand="UPDATE [WGCategories] SET [Name] = @Name, [Description] = @Description, [IsActive] = @IsActive WHERE [WGCategoryID] = @WGCategoryID" OnInserted="dsSelectedCategory_Inserted">
                <DeleteParameters>
                    <asp:Parameter Name="WGCategoryID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="IsActive" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvCategories" Name="WGCategoryID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="IsActive" Type="Boolean" />
                    <asp:Parameter Name="WGCategoryID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:View>
    </asp:MultiView>
    <br />
    <br />
</asp:Content>

