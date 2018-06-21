<%@ Page Language="VB" AutoEventWireup="false" CodeFile="jsTree_test.aspx.vb" Inherits="jsTree_test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.12.0.js"></script>
    <script src="Scripts/jstree.min.js"></script>
    <link rel="stylesheet" href="style/jsTree_themes/default/style.min.css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#jstree_demo_div').jstree({
                "core": {
                    "themes": {
                        "name": "default",
                        "variant": "normal",
                        "dots":true
                    },
                    'data': [
                        { "id": "A", "parent": "#", "text": "Team A" },
                        { "id": "A01", "parent": "A", "text": "SubTeam A01" },
                        { "id": "A02", "parent": "A", "text": "SubTeam A02" },
                        { "id": "GA00001", "parent": "A01", "text": "xxx GA00001" },
                        { "id": "GA00002", "parent": "A01", "text": "xxx GA00002" },
                        { "id": "GA00003", "parent": "A01", "text": "xxx GA00003" },
                        { "id": "GA00004", "parent": "A02", "text": "xxx GA00004" },
                        { "id": "GA00005", "parent": "#", "text": "xxx GA00005" }
                    ]
                },
                "plugins": ["search"]
            })
            $('#jstree_demo_div').on("changed.jstree", function (e, data) {
                console.log(data.selected);
            });
            var to = false;
            $('#tb_jstree_search').keyup(function () {
                if (to) { clearTimeout(to); }
                to = setTimeout(function () {
                    var v = $('#tb_jstree_search').val();
                    $('#jstree_demo_div').jstree(true).search(v);
                }, 250);
            });
        })


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <input type="text" id="tb_jstree_search" />
            <div id="jstree_demo_div"></div>
        </div>
    </form>
</body>
</html>
