page 50102 "Zarizeni_card"
{
    PageType = Card;
    SourceTable = DevTab;
    Caption = 'Zařízení';

    layout
    {
        area(Content)
        {
            group(Obecné)
            {
                field(No; Rec.NoDev)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    NotBlank = true;
                }
            }

            group(Detaily)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (Rec.Name = '') and (Rec.NoDev > 0) then
            Rec.Delete(True);
    end;
}