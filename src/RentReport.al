report 50106 "Vypujcky_report"
{
    DefaultLayout = Word;
    WordLayout = 'Vypujcky_report.docx';
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