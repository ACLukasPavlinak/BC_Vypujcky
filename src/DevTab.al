table 50100 DevTab
{
    DataClassification = ToBeClassified;
    Caption = 'Zařízení';
    DrillDownPageId = "DevPage";
    LookupPageId = "Devpage";
    DataCaptionFields = NoDev, Name;

    fields
    {
        field(1; NoDev; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Číslo zařízení';
            Description = 'Musí být jedinečné';
            AutoIncrement = true;
        }


        field(2; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Název';
        }


        field(3; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Popis';
        }


        field(4; Amount; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Počet';

            trigger OnValidate()
            begin
                if Rec.Amount < 0 then begin
                    Message('Zadal jsi špatný počet zařízení');
                    Rec.Amount := 0;
                end;
            end;
        }
    }
    keys
    {
        key(PK; NoDev)
        {
            Clustered = true;
        }
    }
}