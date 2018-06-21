Imports System.Data
Imports System.Data.Odbc
Imports System.Collections.Generic
Imports System.Web.Services
Imports System.Web.Script.Services
Imports System.Runtime.Serialization.Json


Partial Class _Default
    Inherits System.Web.UI.Page
    Protected highchartsData As String

    Private Sub _Default_Init(sender As Object, e As EventArgs) Handles Me.Init

    End Sub

    <WebMethod()> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)> _
    Shared Function getHighChartMain(ByVal pcCode As String) As String
        Dim dt As DataTable = New DataTable("monthMMN")

        dt.Columns.Add("key", GetType(System.String))
        dt.Columns.Add("S1", GetType(System.Decimal))
        dt.Columns.Add("S2", GetType(System.Decimal))
        dt.Columns.Add("S3", GetType(System.Decimal))

        dt.Rows.Add("Jan", Rnd() * 100, Rnd() * -100, Rnd() * 100 - Rnd() * -100)
        dt.Rows.Add("Feb", Rnd() * 100, Rnd() * -100, Rnd() * 100 - Rnd() * -100)
        dt.Rows.Add("Mar", Rnd() * 100, Rnd() * -100, Rnd() * 100 - Rnd() * -100)
        dt.Rows.Add("Apr", Rnd() * 100, Rnd() * -100, Rnd() * 100 - Rnd() * -100)
        dt.Rows.Add("May", Rnd() * 100, Rnd() * -100, Rnd() * 100 - Rnd() * -100)
        dt.Rows.Add("Jun", Rnd() * 100, Rnd() * -100, Rnd() * 100 - Rnd() * -100)
        dt.Rows.Add("Jul", Rnd() * 100, Rnd() * -100, Rnd() * 100 - Rnd() * -100)
        dt.Rows.Add("Aug", Rnd() * 100, Rnd() * -100, Rnd() * 100 - Rnd() * -100)
        dt.Rows.Add("Sep", Rnd() * 100, Rnd() * -100, Rnd() * 100 - Rnd() * -100)
        dt.Rows.Add("Oct", Rnd() * 100, Rnd() * -100, Rnd() * 100 - Rnd() * -100)
        dt.Rows.Add("Nov", Rnd() * 100, Rnd() * -100, Rnd() * 100 - Rnd() * -100)
        dt.Rows.Add("Dec", Rnd() * 100, Rnd() * -100, Rnd() * 100 - Rnd() * -100)


        'var Data = {
        'S1:  [['D1', 2], ['D2', 3]],
        'S2: [['D1', 8], ['D2', 7]],
        'S3: [['D1', 6], ['D2', 4]]
        '}

        'Dim packet As New List(Of Dictionary(Of String, Object))()
        Dim point As Dictionary(Of String, Object)
        Dim series As List(Of Object)
        Dim packet As New Dictionary(Of String, Object)
        Dim jsonSerializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Try
            For Each dc As DataColumn In dt.Columns

                If dc.ColumnName <> "key" Then
                    series = New List(Of Object)
                    For Each dr As DataRow In dt.Rows
                        point = New Dictionary(Of String, Object)
                        point.Add("name", dr("key"))
                        point.Add("y", dr(dc))
                        point.Add("drilldown", True)
                        series.Add(point)
                    Next
                    packet.Add(dc.ColumnName, series)
                End If
            Next
            Return jsonSerializer.Serialize(packet)
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    <WebMethod()> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)> _
    Public Shared Function getHighChartDrilldown(ByVal varDrillDown As String) As String

        Try
            Dim d As String = varDrillDown
            Dim dt As DataTable = New DataTable("dailyMMN")

            dt.Columns.Add("key", GetType(System.String))
            dt.Columns.Add("S1", GetType(System.Decimal))
            dt.Columns.Add("S2", GetType(System.Decimal))
            dt.Columns.Add("S3", GetType(System.Decimal))

            'dt.Rows.Add("Mar-01", 10, -3, 7)
            'dt.Rows.Add("Mar-02", 12, -1, 11)
            'dt.Rows.Add("Mar-03", 5, -8, -3)

            For i As Integer = 1 To 30
                dt.Rows.Add(varDrillDown + " - " + i.ToString, Rnd() * 100, Rnd() * -100, Rnd() * 100 - Rnd() * -100)
            Next


            'var Data = {
            'S1:  [['D1', 2], ['D2', 3]],
            'S2: [['D1', 8], ['D2', 7]],
            'S3: [['D1', 6], ['D2', 4]]
            '}

            'Dim packet As New List(Of Dictionary(Of String, Object))()
            Dim packet As New Dictionary(Of String, Object)
            Dim point As List(Of Object)
            Dim series As List(Of Object)
            Dim jsonSerializer As New System.Web.Script.Serialization.JavaScriptSerializer()

            'For Each dc As DataColumn In dt.Columns
            '    If dc.ColumnName <> "key" Then

            '    End If
            '    j = j + "Series" + seriesCount.ToString
            'Next
            For Each dc As DataColumn In dt.Columns

                If dc.ColumnName <> "key" Then
                    series = New List(Of Object)
                    For Each dr As DataRow In dt.Rows
                        point = New List(Of Object)
                        point.Add(dr("key"))
                        point.Add(dr(dc))
                        series.Add(point)
                    Next
                    packet.Add(dc.ColumnName, series)
                End If
            Next
            Return jsonSerializer.Serialize(packet)
        Catch ex As Exception
            Throw ex
        End Try

    End Function

End Class
