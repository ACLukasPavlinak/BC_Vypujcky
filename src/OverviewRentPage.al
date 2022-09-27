page 50103 OverviewRentPage
{
    Caption = 'Matice výpujček';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPlus;
    SaveValues = true;
    SourceTable = DevTab;
    UsageCategory = Lists;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            part(MatrixForm; "OverviewRentMatrix")
            {
                ApplicationArea = Location;
                ShowFilter = false;
            }
        }
    }

}