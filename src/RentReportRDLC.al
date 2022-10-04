report 50100 "Vypujcky_report_RDLC"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Vypujcky_report.RDL';
    Caption = 'Report výpůjček';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(RentDev; RentDev)
        {
            column(NoRent; NoRent)
            { }
            column(DevName; DevName)
            { }
            column(EmpName; EmpName)
            { }
            column(Status; Status)
            { }
            column(Since; Since)
            { }
            column(Till; Till)
            { }
            column(Contact; Contact)
            { }
        }
    }
}