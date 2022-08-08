// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

//TODO: kontrola vypujcek a pripadne zvyrazneni proslych
//FIXME: zamezeni pridavani nekoretnich zaznamu napr. NoDev == 0, NoEmp == 0, atd...


table 50100 DevTab
{
    DataClassification = ToBeClassified;
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
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }

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

    actions
    {
        area(Navigation)
        {
            action(NewAction)
            {
                ApplicationArea = All;
                RunObject = codeunit "Document Totals";
            }
        }
    }
}

table 50101 RentDev
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; NoRent; Integer)
        {
            AutoIncrement = true;
            Caption = 'Číslo výpůjčky';
        }

        field(2; NoDev; Integer)
        {
            Caption = 'Číslo zařízení';
            TableRelation = DevTab.NoDev;
        }

        field(3; NoEmp; Code[20])
        {
            Caption = 'Číslo zaměstnance';
            TableRelation = Employee."No.";
        }

        field(4; Status; Option)
        {
            OptionMembers = "Vypůjčeno","Vráceno","Po lhůtě";
            OptionCaption = 'Vypůjčeno, Vráceno, Po Lhůtě';
        }

        field(5; Since; Date)
        {
            Caption = 'Od kdy';
        }

        field(6; Till; Date)
        {
            Caption = 'Do kdy';
        }

        field(7; Contact; Text[50])
        {
            Caption = 'Kontakt';
        }
    }

    keys
    {
        key(PK; NoRent)
        {
            Clustered = true;
        }
    }
}

page 50101 RentPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = RentDev;
    Caption = 'Výpůjčky';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(NoRent; Rec.NoRent)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }

                field(NoDev; Rec.NoDev)
                {
                    ApplicationArea = All;
                    NotBlank = true;

                    trigger OnValidate()
                    var
                        dev: Record DevTab;
                    begin
                        while (dev.NoDev <> Rec.NoDev) do begin
                            dev.Next();
                        end;
                        if dev.Amount > 0 then begin
                            dev.Amount := dev.Amount - 1;
                            dev.Modify();
                        end else begin
                            Rec.NoDev := 0;
                            Message('Zařízení není momenetálně na skladě... :(');
                        end;

                    end;
                }

                field(NoEmp; Rec.NoEmp)
                {
                    ApplicationArea = All;
                    NotBlank = true;

                    trigger OnValidate()
                    var
                        RefEmp: Record Employee;
                    begin
                        while (RefEmp."No." <> Rec.NoEmp) do begin
                            RefEmp.Next();
                        end;

                        Rec.Contact := RefEmp."Phone No.";
                    end;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }

                field(Since; Rec.Since)
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }

                field(Till; Rec.Till)
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }

                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(NewAction)
            {
                ApplicationArea = All;
                RunObject = codeunit "Document Totals";
            }
        }
    }


    trigger OnModifyRecord(): Boolean
    begin
        if Rec.Since > Rec.Till then begin
            Rec.Till := Rec.Since;
            Message('Zadal jsi špatny datum');
        end;

        if Rec.NoDev = 0 then begin
            Message('Nebylo zvoleno zařízení!!!');
        end;

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Since := DT2DATE(CurrentDateTime);
    end;
}