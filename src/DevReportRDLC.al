report 50108 "Zarizeni_report_RDLC"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Zarizeni_report.rdl';
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