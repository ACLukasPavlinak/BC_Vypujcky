page 50100 DevPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DevTab;
    Caption = 'Zařízení na vypůjčení';


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(No; Rec.NoDev)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec.Amount < 0 then begin
                            Message('Zadal jsi špatný počet zařízení');
                            Rec.Amount := 0;
                        end;
                    end;
                }
            }
        }
    }
}