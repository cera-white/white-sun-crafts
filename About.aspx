<%@ Page Title="White Sun Crafts | About" MaintainScrollPositionOnPostback="true" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | About</h1>
    <asp:MultiView ID="mvAbout" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwMaster" runat="server">
            <%--Master View--%>
            <div class="article-top">
                <h3>ABOUT WHITE SUN</h3>
                <div class="article-bottom">
                    <div class="col-md-4" style="margin-left: -10px">
                        <img src="~/images/white-sun.jpg" alt="White Sun" class="img-responsive zoom-img" runat="server">
                    </div>
                    <div class="col-md-8 article-head">
                        <h6><a href="#staff">Welcome to the White Family, a family of computer programmers who craft on the side.</a></h6>
                        <p>It all started back in the early 2000s. Cera came home from Girl Scout camp obsessed with making bead animals, making them for everyone she knew – as keychains, house decorations, window decorations, and just about anything else she could think of to use them for. She inevitably involved the whole family in her quest to amass a collection of beads with which to build her army of bead animals... but Cera eventually grew out of this obsession, as children tend to do.</p>
                        <p>Her mother, Lori, found a good use for Cera's old bead collection: making jewelry and other crafts during her off-hours. She started attending any bead and/or rock shows she heard about in Kansas City, and she began frequenting local shops until they knew her by name. Soon, her collection of beads and crafting supplies grew far beyond anyone's wildest dreams, and with practice and constant experimentation, she slowly became an expert in her craft.</p>
                        <p>Now, the two of them have teamed up – Lori with her beadwork skills and Cera with her web-design know-how – and together they created <strong>White Sun Crafts</strong> as a way to share their work with the world.</p>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>

            <div class="col-m-on">
                <div class="in-line">
                    <div class="para-an">
                        <a name="staff">
                            <h3>MEET THE CRAFTERS</h3>
                        </a>
                        <p>Click on an artist to view more information.</p>
                    </div>

                    <asp:ListView ID="lvVendors" runat="server" DataSourceID="dsActiveVendors">
                        <LayoutTemplate>
                            <div class="lady-on">
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="col-md-4 you-women">
                                <a href="About.aspx?id=<%# Eval("WGVendorID") %>">
                                    <img class="img-responsive pic-in" src="images/vendors/<%# Eval("Image") %>" alt="<%# Eval("Name") %>"></a>
                                <p><%# Eval("Name") %> - <%# Eval("Specialty") %></p>
                                <span><a href="http://<%# Eval("Website") %>" target="_blank">View Website</a></span>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>

                    <asp:SqlDataSource ID="dsActiveVendors" runat="server" ConnectionString="<%$ ConnectionStrings:WGConnectionString %>" SelectCommand="SELECT WGVendorID, Name, Image, Website, IsActive, Specialty FROM WGVendors WHERE (IsActive = @IsActive)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="true" Name="IsActive" Type="Boolean" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </asp:View>

        <asp:View ID="vwDetails" runat="server">
            <%--Details View--%>
            <asp:FormView ID="fvSelectedVendor" runat="server" DataKeyNames="WGVendorID" DataSourceID="dsSelectedVendor">
                <EditItemTemplate>
                </EditItemTemplate>
                <InsertItemTemplate>
                </InsertItemTemplate>
                <ItemTemplate>
                    <div class="single">
                        <div class="col-md-12">
                            <div class="single_grid">
                                <div class="grid">
                                    <img src="images/vendors/<%# Eval("Image") %>" class="img-responsive" alt="<%# Eval("Name") %>" />
                                    <div class="clearfix"></div>
                                </div>
                                <!---->
                                <div class="span1_of_1_des">
                                    <div class="desc1" style="padding-left: 10px">
                                        <h3><%# Eval("Name") %></h3>
                                        <h5><%# Eval("Specialty") %></h5>
                                        <br />
                                        <p><%# Eval("Description") %></p>

                                        <div class="available">
                                            <div class="form-in">
                                                <a href="http://<%# Eval("Website") %>" target="_blank">View Website</a>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="col-m-on">
                                <div class="in-line">
                                    <div class="para-an">
                                        <h3>PORTFOLIO</h3>
                                        <p>Check out some of the awesome things this crafter has made.</p>
                                    </div>

                                    <asp:ListView ID="lvProductsByVendor" runat="server" DataSourceID="dsProductsByVendor" OnDataBound="lvProductsByVendor_DataBound">
                                        <LayoutTemplate>
                                            <div class="lady-on">
                                                <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                                            </div>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <div class="col-md-4 you-women">
                                                <a href="Products.aspx?id=<%# Eval("WGProductID") %>">
                                                    <img class="img-responsive pic-in" src="images/products/<%# Eval("Thumbnail") %>" alt="<%# Eval("Name") %>"></a>
                                                <p><%# Eval("Name") %></p>
                                                <span><%# Eval("LastUpdated", "{0:d}") %>  |
                                                      <a href="Products.aspx?id=<%# Eval("WGProductID") %>"><%# Eval("Status") %></a></span>
                                            </div>
                                        </ItemTemplate>
                                        <EmptyDataTemplate>
                                            <p>Sorry, this crafter doesn't have anything to display yet!</p>
                                        </EmptyDataTemplate>
                                    </asp:ListView>

                                    <asp:SqlDataSource ID="dsProductsByVendor" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT WGProducts.WGProductID, WGProducts.Name, WGProducts.Thumbnail, WGProducts.WGVendorID, WGProducts.LastUpdated, WGProducts.WGProductStatusID, WGProductStatuses.Name AS Status FROM WGProducts INNER JOIN WGProductStatuses ON WGProducts.WGProductStatusID = WGProductStatuses.WGProductStatusID WHERE (WGProducts.WGVendorID = @WGVendorID)">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="id" Name="WGVendorID" Type="Int32"></asp:QueryStringParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                    <div class="clearfix"></div>
                                    <!--Paging-->
                                    <div class="pages pull-left" style="margin-left: -5px">
                                        <asp:DataPager ID="dpProductsByVendor" runat="server" PagedControlID="lvProductsByVendor" PageSize="6">
                                            <Fields>
                                                <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" ButtonCssClass="prev glyphicon glyphicon-menu-left" RenderNonBreakingSpacesBetweenControls="False" PreviousPageText="" NextPageText="" />
                                                <asp:NumericPagerField ButtonCount="10" ButtonType="Link" NumericButtonCssClass="num" NextPreviousButtonCssClass="num" CurrentPageLabelCssClass="num currentNum" RenderNonBreakingSpacesBetweenControls="false"></asp:NumericPagerField>
                                                <asp:NextPreviousPagerField ButtonType="Link" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="next glyphicon glyphicon-menu-right" RenderNonBreakingSpacesBetweenControls="False" PreviousPageText="" NextPageText="" />
                                            </Fields>
                                        </asp:DataPager>
                                        <asp:Label ID="lblShowingResults" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!---->

                        <div class="clearfix"></div>
                    </div>
                </ItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="dsSelectedVendor" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT [WGVendorID], [Name], [Image], [Website], [IsActive], [UserId], [Description], [Specialty] FROM [WGVendors] WHERE ([WGVendorID] = @WGVendorID)">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="id" Name="WGVendorID" Type="Int32"></asp:QueryStringParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:View>
    </asp:MultiView>
</asp:Content>

