
#referencia: https://github.com/nik01010/dashboardthemes

### creating custom theme object
grey_light_modified <- htmltools::tags$head(htmltools::tags$style(htmltools::HTML(
  '

/* font */
 body, label, input, button, select, box, .h1, .h2, .h3, .h4, .h5, h1, h2, h3, h4, h5 {
    font-family: "Arial";
    color: rgb(45,45,45);
}
/* font: fix for h6 */
/* messes up sidebar user section if included above */
 .h6, h6 {
    font-family: "Arial";
}
/* sidebar: logo */
 .skin-blue .main-header .logo {
    background: rgb(64, 113, 237);
}
/* sidebar: logo hover */
 .skin-blue .main-header .logo:hover {
    background: rgb(64, 113, 237);
}
/* sidebar: collapse button*/
 .skin-blue .main-header .navbar .sidebar-toggle {
    background: rgb(64, 113, 237);
    color:rgb(220,220,220);
}
/* sidebar: collapse button hover */
 .skin-blue .main-header .navbar .sidebar-toggle:hover {
    background: rgb(0, 93, 199);
    color:rgb(16, 61, 120);
}
/* header */
 .skin-blue .main-header .navbar {
    background: rgb(64, 113, 237);
    box-shadow: 3px 5px 5px #dfdfdf;
}
/* sidebar*/
 .skin-blue .main-sidebar {
    /*background: rgb(255,255,255);*/
    background:
linear-gradient(135deg, #e6ecf2 21px, #dfe4eb 22px, #9ecfff 24px, transparent 24px, transparent 67px, #d9ecff 67px, #d9ecff 69px, transparent 69px),
linear-gradient(225deg, #dfe4eb 21px, #dfe4eb 22px, #9ecfff 24px, transparent 24px, transparent 67px, #d9ecff 67px, #d9ecff 69px, transparent 69px)0 64px;
background-color:#e6f3ff;
background-size: 64px 128px;
    box-shadow: 3px 5px 5px #dfdfdf;
    padding-left: 0px;
    padding-right: 0px;
    /* padding-top: 60px;
     */
}
/* sidebar menu */
 .main-sidebar .user-panel, .sidebar-menu, .sidebar-menu>li.header {
    white-space: nowrap;
    background: transparent;
    padding: 0px;
    border-radius: 0px;
}
/* fix for user panel */
 .user-panel>.info>p, .skin-blue .user-panel>.info {
    color: rgb(64, 113, 237);
    font-size: 12px;
    font-weight: normal;
}
 section.sidebar .user-panel {
    padding: 10px;
}
/* sidebar: tabs */
 .skin-blue .main-sidebar .sidebar .sidebar-menu a {
    color: rgb(60, 60, 60);
    font-size: 14px;
    border-style: none;
    border-color: none;
    border-width: 0px;
}
/* sidebar: tab selected */
 .skin-blue .main-sidebar .sidebar .sidebar-menu .active > a {
    color: rgb(0,0,0);
    font-size: 14px;
    border-radius: 0px;
    border-style: none solid none none;
    border-color: rgb(64, 113, 237);
    border-width: 4px;
}
 .skin-blue .sidebar-menu > li:hover > a, .skin-blue .sidebar-menu > li.active > a {
    color: rgb(0,0,0);
    background: rgb(156, 199, 255);
    border-radius: 0px;
}
/* sidebar: tab hovered */
 .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover {
    background: rgb(156, 199, 255);
    color: rgb(0,0,0);
    font-size: 14px;
    border-style: none solid none none;
    border-color: rgb(64, 113, 237);
    border-width: 4px;
    border-radius: 0px;
}
/* sidebar: subtab */
 .skin-blue .sidebar-menu > li > .treeview-menu {
    margin: 0px;
    background: transparent;
}
 .skin-blue .treeview-menu > li > a {
    background: transparent;
}
/* sidebar: subtab selected */
 .skin-blue .treeview-menu > li.active > a, .skin-blue .treeview-menu > li > a:hover {
    background: rgb(156, 199, 255);
}
/* sidebar: search text area */
 .skin-blue .sidebar-form input[type=text] {
    background: rgb(240,240,240);
    color: rgb(45,45,45);
    border-radius: 5px 0px 0px 5px;
    border-color: rgb(220,220,220);
    border-style: solid none solid solid;
}
/* sidebar: search button */
 .skin-blue .input-group-btn > .btn {
    background: rgb(240,240,240);
    color: rgb(60, 60, 60);
    border-radius: 0px 5px 5px 0px;
    border-style: solid solid solid none;
    border-color: rgb(220,220,220);
}
/* sidebar form */
 .skin-blue .sidebar-form {
    border-radius: 0px;
    border: 0px none rgb(255,255,255);
    margin: 10px;
}
/* body */
 .content-wrapper, .right-side {
    background: rgb(240,240,240);
}
/* box */
 .box {
    background: rgb(196, 213, 255);
    border-radius: 5px;
    box-shadow: none ;
}
/* box: title */
 .box-header .box-title {
    font-size: 18px;
}
/* tabbox: title */
 .nav-tabs-custom>.nav-tabs>li.header {
    color: rgb(45,45,45);
    font-size: 18px;
}
/* tabbox: tab color */
 .nav-tabs-custom, .nav-tabs-custom .nav-tabs li.active:hover a, .nav-tabs-custom .nav-tabs li.active a {
    background: rgb(196, 213, 255);
    color: rgb(45,45,45);
    border-radius: 5px;
}
 .nav-tabs-custom {
    box-shadow: none ;
}
/* tabbox: active tab bg */
 .nav-tabs-custom>.nav-tabs>li.active {
    border-radius: 5px;
    border-top-color: rgb(64, 113, 237);
    # box-shadow: none ;
}
/* tabbox: font color */
 .nav-tabs-custom>.nav-tabs>li.active:hover>a, .nav-tabs-custom>.nav-tabs>li.active>a {
    border-bottom-color: rgb(196, 213, 255);
    border-top-color: rgb(64, 113, 237);
    border-right-color: rgb(64, 113, 237);
    border-left-color: rgb(64, 113, 237);
    color: rgb(45,45,45);
    font-size: 14px;
    border-radius: 5px;
}
/* tabbox: inactive tabs background */
 .nav-tabs-custom>.nav-tabs>li>a {
    color: rgb(60, 60, 60);
    font-size: 14px;
}
/* tabbox: top area back color */
 .nav-tabs-custom, .nav-tabs-custom>.tab-content, .nav-tabs-custom>.nav-tabs {
    border-bottom-color: rgb(64, 113, 237);
    background: rgb(196, 213, 255);
}
/* tabbox: top area rounded corners */
 .nav-tabs-custom>.nav-tabs {
    margin: 0;
    border-radius: 5px;
}
/* infobox */
 .info-box {
    background: rgb(196, 213, 255);
    border-radius: 5px;
    box-shadow: none ;
}
/* valuebox */
 .small-box {
    border-radius: 5px;
    box-shadow: none ;
}
/* valuebox: main font color */
 .small-box h3, .small-box p {
    color: rgb(255,255,255) 
}
/* box: default color */
 .box.box-solid>.box-header, .box>.box-header {
    color: rgb(45,45,45);
}
 .box.box-solid>.box-header {
    border-radius: 5px;
}
 .box.box-solid, .box {
    border-radius: 5px;
    border-top-color: rgb(225,225,225);
}
/* box: info color */
 .box.box-solid.box-info>.box-header h3, .box.box-info>.box-header h3 {
    color: rgb(15,15,15);
}
 .box.box-solid.box-info>.box-header {
    background: rgb(180,180,180);
    border-radius: 5px;
}
 .box.box-solid.box-info, .box.box-info {
    border-color: rgb(180,180,180);
    border-left-color: rgb(180,180,180);
    border-right-color: rgb(180,180,180);
    border-top-color: rgb(180,180,180);
    border-radius: 5px;
}
/* box: primary color */
 .box.box-solid.box-primary>.box-header h3, .box.box-primary>.box-header h3 {
    color: rgb(15,15,15);
}
 .box.box-solid.box-primary>.box-header {
    background: rgb(95,155,213);
    border-radius: 5px;
}
 .box.box-solid.box-primary, .box.box-primary {
    border-color: rgb(95,155,213);
    border-left-color: rgb(95,155,213);
    border-right-color: rgb(95,155,213);
    border-top-color: rgb(95,155,213);
    border-radius: 5px;
}
/* box: success color */
 .box.box-solid.box-success>.box-header h3, .box.box-success>.box-header h3 {
    color: rgb(15,15,15);
}
 .box.box-solid.box-success>.box-header {
    background: rgb(112,173,71);
    border-radius: 5px;
}
 .box.box-solid.box-success, .box.box-success {
    border-color: rgb(112,173,71);
    border-left-color: rgb(112,173,71);
    border-right-color: rgb(112,173,71);
    border-top-color: rgb(112,173,71);
    border-radius: 5px;
}
/* box: warning color */
 .box.box-solid.box-warning>.box-header h3, .box.box-warning>.box-header h3 {
    color: rgb(15,15,15);
}
 .box.box-solid.box-warning>.box-header {
    background: rgb(237,125,49);
    border-radius: 5px;
}
 .box.box-solid.box-warning, .box.box-warning {
    border-color: rgb(237,125,49);
    border-left-color: rgb(237,125,49);
    border-right-color: rgb(237,125,49);
    border-top-color: rgb(237,125,49);
    border-radius: 5px;
}
/* box: danger color */
 .box.box-solid.box-danger>.box-header h3, .box.box-danger>.box-header h3 {
    color: rgb(15,15,15);
}
 .box.box-solid.box-danger>.box-header {
    background: rgb(232,76,34);
    border-radius: 5px;
}
 .box.box-solid.box-danger, .box.box-danger {
    border-color: rgb(232,76,34);
    border-left-color: rgb(232,76,34);
    border-right-color: rgb(232,76,34);
    border-top-color: rgb(232,76,34);
    border-radius: 5px;
}
/* button */
 .btn-default {
    background: rgb(215,215,215);
    color: rgb(45,45,45);
    border-color: rgb(150,150,150);
    border-radius: 5px;
    height: autopx;
    padding: 6px 12px;
}
/* button: hover */
 .btn-default:hover {
    background: rgb(190,190,190);
    color: rgb(0,0,0);
    border-color: rgb(150,150,150);
}
/* button: focus */
 .btn-default:focus, .action-button:focus {
    background: rgb(215,215,215);
    color: rgb(45,45,45);
    border-color: rgb(150,150,150);
}
/* button: active */
 .btn-default:active, .action-button:active {
    background: rgb(215,215,215);
    color: rgb(45,45,45);
    border-color: rgb(150,150,150);
}
/* button: visited */
 .btn-default:visited {
    background: rgb(215,215,215);
    color: rgb(45,45,45);
    border-color: rgb(150,150,150);
}
/* textbox */
 .form-control, .selectize-input, .selectize-control.single .selectize-input {
    background: rgb(255,255,255);
    color: rgb(45,45,45);
    border-color: rgb(118,118,118);
    border-radius: 5px;
    height: autopx;
    min-height: autopx;
    padding: 6px 12px;
}
/* textbox: selected */
 .form-control:focus, .selectize-input.focus {
    color: rgb(45,45,45);
    background: rgb(156, 199, 255);
    border-color: rgb(108,108,108);
    -webkit-box-shadow: inset 0px 0px 0px, 0px 0px 0px;
    box-shadow: inset 0px 0px 0px, 0px 0px 0px;
}
/* multi-row selectize input */
 .selectize-control.multi .selectize-input.has-items {
    height: auto;
}
/* verbatim text output */
 .qt pre, .qt code {
    font-family: Arial !important;
}
 pre {
    color: rgb(45,45,45);
    background-color: rgb(255,255,255);
    border: 1px solid rgb(118,118,118);
    border-radius: 5px;
}
/* drop-down menu */
 .selectize-dropdown, .selectize-dropdown.form-control {
    background: rgb(255,255,255);
    border-radius: 4px;
}
/* table */
 .table {
    background: rgb(196, 213, 255);
    border-radius: 5px;
}
/* table: row border color*/
 .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
    border-top: 1px solid rgb(227, 235, 255);
}
/* table: top border color*/
 .table>thead>tr>th {
    border-bottom: 1px solid rgb(227, 235, 255);
}
/* table: hover row */
 .table-hover>tbody>tr:hover {
     background-color: rgb(227, 235, 255);
}
/* table: stripe row */
 .table-striped>tbody>tr:nth-of-type(odd) {
    background-color: rgb(227, 235, 255);
}
/* table: body colour */
 table.dataTable tbody tr {
    background-color: rgb(196, 213, 255) !important;
}
/* table: text and footer border colour */
 table.dataTable {
    color: rgb(45,45,45) !important;
    border: 0px !important;
}
/* datatable: selected row */
 table.dataTable tr.selected td, table.dataTable td.selected {
    background-color: rgb(112,173,71) !important;
    color: rgb(0,0,0) !important;
}
/* datatable: hover row */
 table.dataTable tr.hover td, table.dataTable td.hover {
    background-color: rgb(227, 235, 255) !important;
}
 table.dataTable.hover tbody tr:hover, table.dataTable.display tbody tr:hover {
    background-color: rgb(227, 235, 255) !important;
}
 table.dataTable.row-border tbody th, table.dataTable.row-border tbody td, table.dataTable.display tbody th, table.dataTable.display tbody td {
    border-top: 1px solid rgb(227, 235, 255) !important;
}
/* datatable: stripe row */
 table.dataTable.stripe tbody tr.odd, table.dataTable.display tbody tr.odd {
    background-color: rgb(227, 235, 255) !important;
}
/* datatable: page control */
 .dataTables_wrapper .dataTables_paginate .paginate_button {
    color: rgb(45,45,45) !important;
}
/* datatable: table info */
 .dataTables_wrapper .dataTables_paginate .paginate_button.disabled, .dataTables_wrapper .dataTables_paginate .paginate_button.disabled:hover, .dataTables_wrapper .dataTables_paginate .paginate_button.disabled:active {
    color: rgb(45,45,45) !important;
}
 .dataTables_wrapper .dataTables_length, .dataTables_wrapper .dataTables_filter, .dataTables_wrapper .dataTables_info, .dataTables_wrapper .dataTables_processing, .dataTables_wrapper .dataTables_paginate {
    color: rgb(45,45,45) !important;
}
 .dataTables_wrapper .dataTables_length, .dataTables_wrapper .dataTables_filter, .dataTables_wrapper .dataTables_info, .dataTables_wrapper .dataTables_processing, .dataTables_wrapper .dataTables_paginate {
    color: rgb(45,45,45) !important;
}
/* datatable search box */
 .dataTables_wrapper .dataTables_filter input {
    background-color: rgb(255,255,255);
    border: 1px solid rgb(118,118,118);
    border-radius: 5px;
}
/* notification and progress bar */
 .progress-bar {
    background-color: rgb(112,173,71);
}
 .shiny-notification {
    height: 80px;
    font-family: Arial;
    font-size: 15px;
    border-radius: 10px;
    margin-left: -450px !important;
}
/* horizontal divider line */
 hr {
    border-top: 1px solid rgb(215,215,215);
}
/* modal */
 .modal-body {
    background-color: rgb(196, 213, 255);
}
 .modal-footer {
    background-color: rgb(196, 213, 255);
}
 .modal-header {
    background-color: rgb(196, 213, 255);
}
 

'
  
)))


















