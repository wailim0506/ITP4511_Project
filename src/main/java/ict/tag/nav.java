/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/TagHandler.java to edit this template
 */
package ict.tag;

import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.JspFragment;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.*;

/**
 *
 * @author wailim0506
 */
public class nav extends SimpleTagSupport {

    private String userType, staffName;

    public void setUserType(String tagType) {
        this.userType = tagType;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    @Override
    public void doTag() throws JspException {
        JspWriter out = getJspContext().getOut();

        try {
            if ("shop".equalsIgnoreCase(userType)) {
                shopNav(out, staffName);
            } else if ("warehouse".equalsIgnoreCase(userType)) {
                warehouseNav(out);
            } else {

            }

            JspFragment f = getJspBody();
            if (f != null) {
                f.invoke(out);
            }

        } catch (java.io.IOException ex) {
            throw new JspException("Error in primeTag tag", ex);
        }
    }

    private void shopNav(JspWriter out, String staffName) throws IOException {

        out.println(
                "<nav class=\"navbar navbar-expand-lg sticky-top shadow-sm\" style=\"border-bottom: var(--bs-border-width) solid var(--bs-border-color); z-index: 1000; background-color: var(--bs-body-bg);\">"
                        + "    <div class=\"container\">"
                        + "        <a class=\"navbar-brand d-flex align-items-center\" href=\"/ITP4511_Project/page/store/index.jsp\">"
                        + "            <i class=\"material-icons text-primary me-2\">bakery_dining</i>"
                        + "            <span class=\"fw-bold\">ACER</span>"
                        + "        </a>"
                        + "        <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navbarNav\" "
                        + "                aria-controls=\"navbarNav\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">"
                        + "            <span class=\"navbar-toggler-icon\"></span>"
                        + "        </button>"
                        + "        <div class=\"collapse navbar-collapse\" id=\"navbarNav\">"
                        + "            <ul class=\"navbar-nav me-auto\">"
                        + "                <li class=\"nav-item\">"
                        + "                    <a class=\"nav-link\" href=\""
                        + "/ITP4511_Project/page/store/index.jsp\"><i class=\"material-icons small align-middle me-1\">home</i> Dashboard</a>"
                        + "                </li>"
                        + "                <li class=\"nav-item\">"
                        + "                    <a class=\"nav-link\" href=\"/ITP4511_Project/reserveFruit?action=listAll\"><i class=\"material-icons small align-middle me-1\">shopping_cart</i> Reserve</a>"
                        + "                </li>"
                        + "                <li class=\"nav-item\">"
                        + "                    <a class=\"nav-link\" href=\"/ITP4511_Project/reserveRecord?action=listAll\"><i class=\"material-icons small align-middle me-1\">bookmark</i> Reserve Record</a>"
                        + "                </li>"
                        + "                <li class=\"nav-item\">"
                        + "                    <a class=\"nav-link\" href=\"/ITP4511_Project/borrowFruit?action=select\"><i class=\"material-icons small align-middle me-1\">swap_horiz</i> Borrow</a>"
                        + "                </li>"
                        + "                <li class=\"nav-item\">"
                        + "                    <a class=\"nav-link\" href=\"/ITP4511_Project/borrowRecord?action=listAll\"><i class=\"material-icons small align-middle me-1\">history</i> Borrow Record</a>"
                        + "                </li>"
                        + "                <li class=\"nav-item\">"
                        + "                    <a class=\"nav-link\" href=\"/ITP4511_Project/borrowRequest?action=all\"><i class=\"material-icons small align-middle me-1\">send</i> Borrow Request</a>"
                        + "                </li>"
                        + "                <li class=\"nav-item\">"
                        + "                    <a class=\"nav-link\" href=\"/ITP4511_Project/stock?action=list\"><i class=\"material-icons small align-middle me-1\">inventory</i> Stock</a>"
                        + "                </li>"
                        + "            </ul>"
                        + "            <div class=\"d-flex align-items-center\">"
                        + "                <div class=\"dropdown\">"
                        + "                    <a class=\"btn btn-outline-secondary dropdown-toggle d-flex align-items-center\" href=\"#\" role=\"button\" "
                        + "                       id=\"userDropdown\" data-bs-toggle=\"dropdown\" aria-expanded=\"false\">"
                        + "                        <i class=\"material-icons me-2\">account_circle</i>"
                        + "                        <span>" + staffName + "</span>"
                        + "                    </a>"
                        + "                    <ul class=\"dropdown-menu dropdown-menu-end shadow\" aria-labelledby=\"userDropdown\">"
                        + "                        <li><a class=\"dropdown-item\" href=\"/ITP4511_Project/page/profile.jsp\"><i class=\"material-icons small me-2\">person</i>Profile</a></li>"
                        + "                        <li><hr class=\"dropdown-divider\"></li>"
                        + "                        <li><a class=\"dropdown-item\" href=\""
                        + "/ITP4511_Project/login?action=logout\"><i class=\"material-icons small me-2\">logout</i>Logout</a></li>"
                        + "                    </ul>"
                        + "                </div>"
                        + "            </div>"
                        + "        </div>"
                        + "    </div>"
                        + "</nav>");

    }

    private void warehouseNav(JspWriter out) throws IOException {
        out.println(
                "<nav class=\"navbar navbar-expand-lg sticky-top shadow-sm\" style=\"border-bottom: var(--bs-border-width) solid var(--bs-border-color); z-index: 1000; background-color: var(--bs-body-bg);\">"
                        + "    <div class=\"container\">"
                        + "        <a class=\"navbar-brand d-flex align-items-center\" href=\"/ITP4511_Project/page/warehouse/index.jsp\">"
                        + "            <i class=\"material-icons text-primary me-2\">bakery_dining</i>"
                        + "            <span class=\"fw-bold\">ACER</span>"
                        + "        </a>"
                        + "        <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navbarNav\" "
                        + "                aria-controls=\"navbarNav\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">"
                        + "            <span class=\"navbar-toggler-icon\"></span>"
                        + "        </button>"
                        + "        <div class=\"collapse navbar-collapse\" id=\"navbarNav\">"
                        + "            <ul class=\"navbar-nav me-auto\">"
                        + "                <li class=\"nav-item\">"
                        + "                    <a class=\"nav-link\" href=\"/ITP4511_Project/page/warehouse/index.jsp\"><i class=\"material-icons small align-middle me-1\">home</i> Dashboard</a>"
                        + "                </li>"
                        + "                <li class=\"nav-item\">"
                        + "                    <a class=\"nav-link\" href=\"/ITP4511_Project/inventory?action=list\"><i class=\"material-icons small align-middle me-1\">inventory_2</i> Inventory</a>"
                        + "                </li>"
                        + "                <li class=\"nav-item\">"
                        + "                    <a class=\"nav-link\" href=\"#\"><i class=\"material-icons small align-middle me-1\">receipt_long</i> Order</a>"
                        + "                </li>"
                        + "                <li class=\"nav-item\">"
                        + "                    <a class=\"nav-link\" href=\"#\"><i class=\"material-icons small align-middle me-1\">local_shipping</i> Delivery</a>"
                        + "                </li>"
                        + "                <li class=\"nav-item\">"
                        + "                    <a class=\"nav-link\" href=\"#\"><i class=\"material-icons small align-middle me-1\">manage_accounts</i> Staffing</a>"
                        + "                </li>"
                        + "            </ul>"
                        + "            <div class=\"d-flex align-items-center\">"
                        + "                <div class=\"dropdown\">"
                        + "                    <a class=\"btn btn-outline-secondary dropdown-toggle d-flex align-items-center\" href=\"#\" role=\"button\" "
                        + "                       id=\"userDropdown\" data-bs-toggle=\"dropdown\" aria-expanded=\"false\">"
                        + "                        <i class=\"material-icons me-2\">account_circle</i>"
                        + "                        <span>" + staffName + "</span>"
                        + "                    </a>"
                        + "                    <ul class=\"dropdown-menu dropdown-menu-end shadow\" aria-labelledby=\"userDropdown\">"
                        + "                        <li><a class=\"dropdown-item\" href=\"/ITP4511_Project/page/profile.jsp\"><i class=\"material-icons small me-2\">person</i>Profile</a></li>"
                        + "                        <li><hr class=\"dropdown-divider\"></li>"
                        + "                        <li><a class=\"dropdown-item\" href=\""
                        + "/ITP4511_Project/login?action=logout\"><i class=\"material-icons small me-2\">logout</i>Logout</a></li>"
                        + "                    </ul>"
                        + "                </div>"
                        + "            </div>"
                        + "        </div>"
                        + "    </div>"
                        + "</nav>");
    }
}
