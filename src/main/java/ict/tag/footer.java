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
public class footer extends SimpleTagSupport {

    private String userType;

    public void setUserType(String tagType) {
        this.userType = tagType;
    }

    @Override
    public void doTag() throws JspException {
        JspWriter out = getJspContext().getOut();

        try {
            if ("shop".equalsIgnoreCase(userType)) {
                shopFooter(out);
            } else if ("Source".equalsIgnoreCase(userType)) {
                warehouseFooterSource(out);
            } else if ("Central".equalsIgnoreCase(userType)) {
                warehouseFooter(out);
            } else {
                seniorManagementFooter(out);
            }

            JspFragment f = getJspBody();
            if (f != null) {
                f.invoke(out);
            }

        } catch (java.io.IOException ex) {
            throw new JspException("Error in primeTag tag", ex);
        }
    }

    private void shopFooter(JspWriter out) throws IOException {

        out.println(
                "<div class=\"mt-4 py-3\" style=\"border-top: var(--bs-border-width) solid var(--bs-border-color);\">"
                        + "    <div class=\"container\">"
                        + "        <!-- Navigation Links -->"
                        + "        <nav class=\"nav justify-content-center flex-nowrap\">"
                        + "            <a class=\"nav-link text-secondary\" href=\""
                        + "/ITP4511_Project/page/store/index.jsp\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">home</i>"
                        + "                    <span>Dashboard</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/reserveFruit?action=listAll\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">shopping_cart</i>"
                        + "                    <span>Reserve</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/reserveRecord?action=listAll\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">bookmark</i>"
                        + "                    <span>Reserve Record</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"borrowFruit?action=select\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">swap_horiz</i>"
                        + "                    <span>Borrow</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"borrowFruit?action=select\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">history</i>"
                        + "                    <span>Borrow Record</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/borrowRequest?action=all\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">send</i>"
                        + "                    <span>Borrow Request</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/stock?action=list\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">inventory</i>"
                        + "                    <span>Stock</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/page/profile.jsp\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">person</i>"
                        + "                    <span>Profile</span>"
                        + "                </div>"
                        + "            </a>"
                        + "        </nav>"
                        + "        <!-- Copyright -->"
                        + "        <div class=\"text-center text-muted small mt-2\">"
                        + "            <div class=\"d-flex align-items-center justify-content-center\">"
                        + "                <i class=\"material-icons small me-1\">bakery_dining</i>"
                        + "                <span>ACER International Bakery</span>"
                        + "            </div>"
                        + "            <p class=\"mb-0 mt-1\">&copy; 2025 ACER. All rights reserved.</p>"
                        + "        </div>"
                        + "    </div>"
                        + "</div>");

    }

    private void warehouseFooterSource(JspWriter out) throws IOException {
        out.println(
                "<div class=\"mt-4 py-3\" style=\"border-top: var(--bs-border-width) solid var(--bs-border-color);\">"
                        + "    <div class=\"container\">"
                        + "        <!-- Navigation Links -->"
                        + "        <nav class=\"nav justify-content-center flex-nowrap\">"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/page/warehouse/index.jsp\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">home</i>"
                        + "                    <span>Dashboard</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/inventory?action=list\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">inventory_2</i>"
                        + "                    <span>Inventory</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/Order?action=list\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">receipt_long</i>"
                        + "                    <span>Order</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/Delivery?action=list\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">local_shipping</i>"
                        + "                    <span>Delivery</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/page/profile.jsp\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">person</i>"
                        + "                    <span>Profile</span>"
                        + "                </div>"
                        + "            </a>"
                        + "        </nav>"
                        + "        <!-- Copyright -->"
                        + "        <div class=\"text-center text-muted small mt-2\">"
                        + "            <div class=\"d-flex align-items-center justify-content-center\">"
                        + "                <i class=\"material-icons small me-1\">bakery_dining</i>"
                        + "                <span>ACER International Bakery</span>"
                        + "            </div>"
                        + "            <p class=\"mb-0 mt-1\">&copy; 2025 ACER. All rights reserved.</p>"
                        + "        </div>"
                        + "    </div>"
                        + "</div>");
    }

    private void warehouseFooter(JspWriter out) throws IOException {
        out.println(
                "<div class=\"mt-4 py-3\" style=\"border-top: var(--bs-border-width) solid var(--bs-border-color);\">"
                        + "    <div class=\"container\">"
                        + "        <!-- Navigation Links -->"
                        + "        <nav class=\"nav justify-content-center flex-nowrap\">"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/page/warehouse/index.jsp\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">home</i>"
                        + "                    <span>Dashboard</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/inventory?action=list\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">inventory_2</i>"
                        + "                    <span>Inventory</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/Restock?action=list\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">move_to_inbox</i>"
                        + "                    <span>Restock</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/Order?action=list\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">receipt_long</i>"
                        + "                    <span>Order</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/Delivery?action=list\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">local_shipping</i>"
                        + "                    <span>Delivery</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/page/profile.jsp\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">person</i>"
                        + "                    <span>Profile</span>"
                        + "                </div>"
                        + "            </a>"
                        + "        </nav>"
                        + "        <!-- Copyright -->"
                        + "        <div class=\"text-center text-muted small mt-2\">"
                        + "            <div class=\"d-flex align-items-center justify-content-center\">"
                        + "                <i class=\"material-icons small me-1\">bakery_dining</i>"
                        + "                <span>ACER International Bakery</span>"
                        + "            </div>"
                        + "            <p class=\"mb-0 mt-1\">&copy; 2025 ACER. All rights reserved.</p>"
                        + "        </div>"
                        + "    </div>"
                        + "</div>");
    }

    private void seniorManagementFooter(JspWriter out) throws IOException {
        out.println(
                "<div class=\"mt-4 py-3\" style=\"border-top: var(--bs-border-width) solid var(--bs-border-color);\">"
                        + "    <div class=\"container\">"
                        + "        <!-- Navigation Links -->"
                        + "        <nav class=\"nav justify-content-center flex-nowrap\">"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/page/seniorManagement/index.jsp\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">home</i>"
                        + "                    <span>Dashboard</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/consumption\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">bar_chart</i>"
                        + "                    <span>Consumption Reports</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/reserveNeed?viewLevel=c&cn=all&date=last12Months\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">assessment</i>"
                        + "                    <span>Reserve Needs</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/manageFruit\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">category</i>"
                        + "                    <span>Manage Fruit</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/userList\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">manage_accounts</i>"
                        + "                    <span>User Management</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/shopList\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">storefront</i>"
                        + "                    <span>Shop</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/WarehouseList\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">home</i>"
                        + "                    <span>Warehouse</span>"
                        + "                </div>"
                        + "            </a>"
                        + "            <a class=\"nav-link text-secondary\" href=\"/ITP4511_Project/page/profile.jsp\">"
                        + "                <div class=\"d-flex align-items-center\">"
                        + "                    <i class=\"material-icons small me-1\">person</i>"
                        + "                    <span>Profile</span>"
                        + "                </div>"
                        + "            </a>"
                        + "        </nav>"
                        + "        <!-- Copyright -->"
                        + "        <div class=\"text-center text-muted small mt-2\">"
                        + "            <div class=\"d-flex align-items-center justify-content-center\">"
                        + "                <i class=\"material-icons small me-1\">bakery_dining</i>"
                        + "                <span>ACER International Bakery</span>"
                        + "            </div>"
                        + "            <p class=\"mb-0 mt-1\">&copy; 2025 ACER. All rights reserved.</p>"
                        + "        </div>"
                        + "    </div>"
                        + "</div>");
    }
}
