report 50107 "Zarizeni_report_Excel"
{
    DefaultLayout = Word;
    WordLayout = 'Zarizeni_report.docx';
    Caption = 'Report zařízení';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(DevTab; DevTab)
        {
            column(No; NoDev)
            { }
            column(Name; Name)
            { }
            column(Description; Description)
            { }
            column(Amount; Amount)
            { }
        }
    }
}