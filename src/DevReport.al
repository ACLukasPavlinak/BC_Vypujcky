report 50104 "Zarizeni_report"
{
    DefaultLayout = Word;
    WordLayout = 'Zarizeni_report.docx';
    Caption = 'Můj report';
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