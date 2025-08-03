package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import Admin.AdminDTO;
import Home.HomeDTO;

public final class HomePage_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(1);
    _jspx_dependants.add("/menu.jsp");
  }

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/HomePage.css\">\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>HOME</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <header>\n");
      out.write("            <div class=\"nav-container\">\n");
      out.write("                <div class=\"logo\">\n");
      out.write("                    <img src=\"img/logo.png\" alt=\"Logo\">\n");
      out.write("                    <span>Seafood Shop</span>\n");
      out.write("                </div>\n");
      out.write("                <nav>\n");
      out.write("                    <ul>\n");
      out.write("                        <li><a href=\"#\">Home</a></li>\n");
      out.write("                        <li><a href=\"#menu\">Menu</a></li> \n");
      out.write("                        <li><a href=\"#about\">About</a></li> \n");
      out.write("                        <li><a href=\"#contact\">Contact</a></li>\n");
      out.write("                    </ul>\n");
      out.write("                </nav>\n");
      out.write("\n");
      out.write("\n");
      out.write("                <div class=\"icons\">\n");
      out.write("                    <input type=\"text\" placeholder=\"Search\">\n");
      out.write("                    <i class=\"fas fa-search\"></i>\n");
      out.write("                    <i class=\"fas fa-shopping-cart\"></i>\n");
      out.write("                    <i class=\"fas fa-user-circle\"></i>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </header>\n");
      out.write("\n");
      out.write("        ");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/style.css\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css\" integrity=\"sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==\" crossorigin=\"anonymous\" referrerpolicy=\"no-referrer\" />\n");
      out.write("    \n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Menu</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("            <header>\n");
      out.write("        <div class=\"nav-container\">\n");
      out.write("            <div class=\"logo\">\n");
      out.write("                <img src=\"img/logo.png\" alt=\"Logo\">\n");
      out.write("                <span>Seafood Shop</span>\n");
      out.write("            </div>\n");
      out.write("            \n");
      out.write("            <nav>\n");
      out.write("                <ul>\n");
      out.write("                    <li><a href=\"SeafoodController\">Home</a></li>\n");
      out.write("                    <li><a href=\"#menu\">Menu</a></li> \n");
      out.write("                    <li><a href=\"#products\">Products</a></li>\n");
      out.write("                    <li><a href=\"#contact\">Contact</a></li>\n");
      out.write("                </ul>\n");
      out.write("            </nav>\n");
      out.write("\n");
      out.write("            <div class=\"icons\">\n");
      out.write("                <form action=\"SeafoodController#products\" method=\"get\">\n");
      out.write("                    <input type=\"text\" name=\"keyword\" placeholder=\"Search\">\n");
      out.write("                    <input type=\"hidden\" name=\"action\" value=\"search\">\n");
      out.write("                    <input type=\"submit\" value=\"Search\">\n");
      out.write("                </form>\n");
      out.write("\n");
      out.write("                <i class=\"fas fa-shopping-cart\"></i>\n");
      out.write("                <div class=\"hiden-login\">\n");
      out.write("                    <i class=\"fa-solid fa-user\"></i>\n");
      out.write("                    <div class=\"nemu-login\">\n");
      out.write("                <c:choose>\n");
      out.write("                    <c:when test=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${not empty sessionScope.usersession}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("\">\n");
      out.write("\n");
      out.write("                        <a href=\"logout.jsp\">Logout</a>\n");
      out.write("                    </c:when>\n");
      out.write("                    <c:otherwise>\n");
      out.write("                        <a href=\"login.jsp\" class=\"user-icon\">Login</a>\n");
      out.write("                        <a href=\"signup.jsp\">Sign Up</a>\n");
      out.write("                    </c:otherwise>\n");
      out.write("                </c:choose>\n");
      out.write("                     </div>   \n");
      out.write("                </div>        \n");
      out.write("            </div>\n");
      out.write("            \n");
      out.write("        </div>\n");
      out.write("    </header>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
      out.write("\n");
      out.write("        ");
 HomeDTO homeData = (HomeDTO) request.getAttribute("info");
            String totalRevenue = (String) request.getAttribute("formattedRevenue");
        
      out.write("\n");
      out.write("\n");
      out.write("        <div class=\"content\">\n");
      out.write("            <div class=\"dashboard\">\n");
      out.write("                <div class=\"box total-customer\">TOTAL CUSTOMER <br> ");
      out.print( homeData.getTotalCustomers());
      out.write("</div>\n");
      out.write("                <div class=\"box total-order\">TOTAL ORDER <br> ");
      out.print( homeData.getTotalOrders());
      out.write("</div>\n");
      out.write("                <div class=\"box total-product\">TOTAL PRODUCT <br> ");
      out.print( homeData.getTotalProducts());
      out.write("</div>\n");
      out.write("                <div class=\"box total-price\">TOTAL PRICE <br> ");
      out.print( totalRevenue);
      out.write(" VND</div>\n");
      out.write("                <div class=\"box quantity-almost-sold\">QUANTITY ALMOST SOLD OUT <br> ???</div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
