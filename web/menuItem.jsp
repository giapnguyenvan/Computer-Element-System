<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="model.MenuItem" %>
<%@ page import="model.MenuAttribute" %>
<%@ page import="model.MenuAttributeValue" %>
<%@ page import="dal.MenuItemDAO" %>
<%@ page import="com.google.gson.Gson" %>

<%
    List<MenuItem> menuItems = MenuItemDAO.getAllMenuItemsWithAttributesAndValues();
    Gson gson = new Gson();
    String menuDataJson = gson.toJson(menuItems).replace("\"", "&quot;").replace("'", "&#39;");
%>
<html>
<head>
    <title>Danh sách Menu Item</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .menu-container {
            position: relative;
            width: 260px;
        }
        .menu-list {
            width: 260px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            padding: 8px 0;
            margin: 0;
            list-style: none;
        }
        .menu-list li {
            position: relative;
            display: flex;
            align-items: center;
            padding: 10px 18px;
            font-size: 16px;
            color: #222;
            cursor: pointer;
            border-radius: 6px;
            transition: background 0.2s;
        }
        .menu-list li:hover {
            background: #f5f5f5;
        }
        .menu-list .menu-icon {
            width: 24px;
            text-align: center;
            margin-right: 12px;
            font-size: 18px;
        }
        .menu-list .arrow {
            margin-left: auto;
            color: #bbb;
            font-size: 14px;
        }
        .menu-list a {
            color: inherit;
            text-decoration: none;
            flex: 1;
        }

        /* Mega Menu Styles */
        .mega-menu {
            display: none; /* Hidden by default */
            position: absolute;
            left: 100%; /* Position to the right of the parent li */
            top: 0;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            padding: 15px;
            min-width: 600px; /* Adjust as needed */
            z-index: 1000;
        }

        .mega-menu-column {
            display: inline-block; /* For columns */
            vertical-align: top;
            width: 30%; /* Adjust for desired column width */
            padding-right: 15px;
        }

        .mega-menu-column h5 {
            font-size: 16px;
            font-weight: bold;
            color: #d9534f; /* Red color for headers */
            margin-bottom: 10px;
            border-bottom: 1px solid #eee;
            padding-bottom: 5px;
        }

        .mega-menu-column ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .mega-menu-column ul li a {
            display: block;
            padding: 5px 0;
            color: #333;
            text-decoration: none;
            transition: color 0.2s;
        }

        .mega-menu-column ul li a:hover {
            color: #0d6efd;
        }

        .mega-menu-column ul li {
            position: relative; /* Thêm dòng này để định vị sub-menu cấp 3 */
        }
        
        /* Third level menu (MenuAttributeValue) */
        .third-level-menu {
            display: none; /* Hidden by default */
            position: absolute;
            left: 100%; /* Position to the right of the parent li */
            top: 0;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            padding: 15px;
            min-width: 200px; /* Adjust as needed */
            z-index: 1001;
        }

        .show-menu {
            display: block !important; /* Force display */
        }

    </style>
</head>
<body>
    <div class="menu-container">
        <ul class="menu-list" id="main-menu">
            <!-- Menu items will be dynamically loaded here by JavaScript -->
        </ul>
    </div>

    <div id="menuDataJsonContainer" data-json="<%= menuDataJson %>" style="display:none;"></div>

    <script>
        const menuData = JSON.parse(document.getElementById('menuDataJsonContainer').dataset.json);
        const mainMenu = document.getElementById('main-menu');

        function renderThirdLevelMenu(attribute) {
            let thirdLevelHtml = '';
            if (attribute.menuAttributeValues && attribute.menuAttributeValues.length > 0) {
                thirdLevelHtml += '<div class="third-level-menu">';
                thirdLevelHtml += '<ul>';
                attribute.menuAttributeValues.forEach(value => {
                    thirdLevelHtml += '<li><a href="' + (value.url ? value.url : '#') + '">' + value.value + '</a></li>';
                });
                thirdLevelHtml += '</ul>';
                thirdLevelHtml += '</div>';
            }
            return thirdLevelHtml;
        }

        function renderMegaMenu(item) {
            let megaMenuHtml = '';
            if (item.menuAttributes && item.menuAttributes.length > 0) {
                megaMenuHtml += '<div class="mega-menu">';
                item.menuAttributes.forEach(attribute => {
                    megaMenuHtml += '<div class="mega-menu-column">';
                    megaMenuHtml += '<h5>' + attribute.name + '</h5>';
                    megaMenuHtml += '<ul>';
                    megaMenuHtml += '<li data-attribute-id="' + attribute.attributeId + '"><a href="' + (attribute.url ? attribute.url : '#') + '">' + attribute.name + '</a>';
                    if (attribute.menuAttributeValues && attribute.menuAttributeValues.length > 0) {
                        megaMenuHtml += '<span class="arrow"><i class="fa-solid fa-angle-right"></i></span>';
                    }
                    megaMenuHtml += renderThirdLevelMenu(attribute);
                    megaMenuHtml += '</li>';
                    megaMenuHtml += '</ul>';
                    megaMenuHtml += '</div>';
                });
                megaMenuHtml += '</div>';
            }
            return megaMenuHtml;
        }

        menuData.forEach(item => {
            const listItem = document.createElement('li');
            listItem.setAttribute('data-item-id', item.menuItemId);
            listItem.innerHTML = 
                '<span class="menu-icon">' +
                    (item.icon ? '<i class="' + item.icon + '"></i>' : '') +
                '</span>' +
                '<a href="' + (item.url ? item.url : '#') + '">' + item.name + '</a>' +
                (item.menuAttributes && item.menuAttributes.length > 0 ? '<span class="arrow"><i class="fa-solid fa-angle-right"></i></span>' : '') +
                '';
            listItem.innerHTML += renderMegaMenu(item);
            mainMenu.appendChild(listItem);
        });

        // Add hover logic for main menu items to show mega menu
        document.querySelectorAll('.menu-list > li').forEach(listItem => {
            const megaMenu = listItem.querySelector('.mega-menu');
            if (megaMenu) {
                listItem.addEventListener('mouseenter', () => {
                    console.log('MouseEnter Level 1:', listItem.dataset.itemId, megaMenu);
                    // debugger; // Tạm dừng ở đây để kiểm tra
                    megaMenu.classList.add('show-menu');
                });
                listItem.addEventListener('mouseleave', () => {
                    console.log('MouseLeave Level 1:', listItem.dataset.itemId, megaMenu);
                    // debugger; // Tạm dừng ở đây để kiểm tra
                    megaMenu.classList.remove('show-menu');
                });
            }
        });

        // Add hover logic for second level attributes to show third level values
        document.querySelectorAll('.mega-menu-column ul li').forEach(li => {
            const thirdLevelMenu = li.querySelector('.third-level-menu');
            if (thirdLevelMenu) {
                li.addEventListener('mouseenter', () => {
                    console.log('MouseEnter Level 2:', li.dataset.attributeId, thirdLevelMenu);
                    // debugger; // Tạm dừng ở đây để kiểm tra
                    thirdLevelMenu.classList.add('show-menu');
                });
                li.addEventListener('mouseleave', () => {
                    console.log('MouseLeave Level 2:', li.dataset.attributeId, thirdLevelMenu);
                    // debugger; // Tạm dừng ở đây để kiểm tra
                    thirdLevelMenu.classList.remove('show-menu');
                });
            }
        });

    </script>
</body>
</html> 