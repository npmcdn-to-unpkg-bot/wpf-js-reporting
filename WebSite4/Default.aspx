<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="bower_components/bootstrap/dist/css/bootstrap-theme.min.css" rel="stylesheet" />
    <link href="bower_components/bootstrap/dist/css/bootstrap-theme.css" rel="stylesheet" />
    <script src="bower_components/bootstrap/dist/js/bootstrap.js"></script>
    <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="bower_components/bootstrap/dist/js/npm.js"></script>
    <script src="bower_components/d3/d3.js"></script>
    <script src="bower_components/d3/d3.min.js"></script>
    <script src="bower_components/jquery/dist/jquery.js"></script>
    <script src="bower_components/jquery/dist/jquery.min.js"></script>
    <link href="bower_components/jsgrid/css/jsgrid.css" rel="stylesheet" />
    <script src="bower_components/jsgrid/dist/jsgrid.js"></script>
    <script src="bower_components/jsgrid/dist/jsgrid.min.js"></script>
    <link href="bower_components/jsgrid/dist/jsgrid-theme.css" rel="stylesheet" />
    
    <script src="bla.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="jsGrid"></div>
        <div id="maindiv" style="background-color:black; color:white; font-size: 36px;" >
            BLALBDF
        </div>
        <div class="btn-group" role="group" aria-label="...">
        <button type="button" class="btn btn-default">Left</button>
        <button type="button" class="btn btn-default">Middle</button>
        <button type="button" class="btn btn-default">Right</button>
        </div>
        <script>
            $(function() {

            $("#jsGrid").jsGrid({
                height: "90%",
                width: "100%",

                sorting: true,
                paging: true,

                data: db.clients,

                fields: [
                    { name: "Name", type: "text", width: 150 },
                    { name: "Age", type: "number", width: 50 },
                    { name: "Address", type: "text", width: 200 },
                    { name: "Country", type: "select", items: db.countries, valueField: "Id", textField: "Name" },
                    { name: "Married", type: "checkbox", title: "Is Married" }
                ]
            });

            });
        </script>
        <script>
    $(function() {

    $("#jsGrid").jsGrid({
        height: "70%",
        width: "100%",
        editing: true,
        autoload: true,
        paging: true,
        deleteConfirm: function(item) {
            return "The client \"" + item.Name + "\" will be removed. Are you sure?";
        },
        rowClick: function(args) {
            showDetailsDialog("Edit", args.item);
        },
        controller: db,
        fields: [
            { name: "Name", type: "text", width: 150 },
            { name: "Age", type: "number", width: 50 },
            { name: "Address", type: "text", width: 200 },
            { name: "Country", type: "select", items: db.countries, valueField: "Id", textField: "Name" },
            { name: "Married", type: "checkbox", title: "Is Married", sorting: false },
            {
                type: "control",
                modeSwitchButton: false,
                editButton: false,
                headerTemplate: function() {
                    return $("<button>").attr("type", "button").text("Add")
                            .on("click", function () {
                                showDetailsDialog("Add", {});
                            });
                }
            }
        ]
    });

    $("#detailsDialog").dialog({
        autoOpen: false,
        width: 400,
        close: function() {
            $("#detailsForm").validate().resetForm();
            $("#detailsForm").find(".error").removeClass("error");
        }
    });

    $("#detailsForm").validate({
        rules: {
            name: "required",
            age: { required: true, range: [18, 150] },
            address: { required: true, minlength: 10 },
            country: "required"
        },
        messages: {
            name: "Please enter name",
            age: "Please enter valid age",
            address: "Please enter address (more than 10 chars)",
            country: "Please select country"
        },
        submitHandler: function() {
            formSubmitHandler();
        }
    });

    var formSubmitHandler = $.noop;

    var showDetailsDialog = function(dialogType, client) {
        $("#name").val(client.Name);
        $("#age").val(client.Age);
        $("#address").val(client.Address);
        $("#country").val(client.Country);
        $("#married").prop("checked", client.Married);

        formSubmitHandler = function() {
            saveClient(client, dialogType === "Add");
        };

        $("#detailsDialog").dialog("option", "title", dialogType + " Client")
                .dialog("open");
    };

    var saveClient = function(client, isNew) {
        $.extend(client, {
            Name: $("#name").val(),
            Age: parseInt($("#age").val(), 10),
            Address: $("#address").val(),
            Country: parseInt($("#country").val(), 10),
            Married: $("#married").is(":checked")
        });

        $("#jsGrid").jsGrid(isNew ? "insertItem" : "updateItem", client);

        $("#detailsDialog").dialog("close");
    };

});
</script>

            <div id="chartContainer">
              <script type="text/javascript">
                var svg = dimple.newSvg("#chartContainer", 590, 400);
                d3.tsv("/data/example_data.tsv", function (data) {
                  var myChart = new dimple.chart(svg, data);
                  myChart.setBounds(20, 20, 460, 360)
                  myChart.addMeasureAxis("p", "Unit Sales");
                  myChart.addSeries("Owner", dimple.plot.pie);
                  myChart.addLegend(500, 20, 90, 300, "left");
                  myChart.draw();
                });
              </script>
            </div>

    </form>
</body>
</html>
