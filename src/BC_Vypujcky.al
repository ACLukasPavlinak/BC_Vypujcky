// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

//TODO: zvyrazneni proslych vypujcek


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

        field(3; PrevNoDev; Integer)
        {
            Caption = 'Číslo zařízení';
            TableRelation = DevTab.NoDev;
        }

        field(4; NoEmp; Code[20])
        {
            Caption = 'Číslo zaměstnance';
            TableRelation = Employee."No.";
        }

        field(5; Status; Option)
        {
            OptionMembers = "Vypujceno","Vraceno","PoLhute";
            OptionCaption = 'Vypůjčeno, Vráceno, Po Lhůtě';
        }

        field(6; Since; Date)
        {
            Caption = 'Od kdy';
        }

        field(7; Till; Date)
        {
            Caption = 'Do kdy';
        }

        field(8; Contact; Text[50])
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
                    ShowMandatory = true;
                    BlankZero = true;


                    trigger OnValidate()
                    var
                        dev, dev2 : Record DevTab;
                        i: Integer;
                    begin
                        //pokud se nezmeni zarizeni nic se nebude delat
                        if Rec.NoDev <> Rec.PrevNoDev then begin


                            for i := 1 to dev.Count() do begin
                                if dev.NoDev <> Rec.NoDev then
                                    dev.Next();
                            end;

                            if dev.Amount > 0 then begin
                                dev.Amount := dev.Amount - 1;
                                dev.Modify();
                            end else begin
                                Rec.NoDev := 0;
                                Message('Zařízení není momenetálně na skladě... :(');
                            end;

                            if Rec.PrevNoDev <> 0 then begin
                                for i := 1 to dev2.Count() do begin
                                    if dev2.NoDev <> Rec.PrevNoDev then
                                        dev2.Next();
                                end;

                                dev2.Amount := dev2.Amount + 1;
                                dev2.Modify();
                            end;

                            Rec.PrevNoDev := Rec.NoDev;
                        end;
                    end;
                }

                field(NoEmp; Rec.NoEmp)
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        i: Integer;
                        RefEmp: Record Employee;
                    begin
                        //vyplneni kontaktu na zaklade cisla zamestnance
                        for i := 1 to RefEmp.Count() do begin
                            if RefEmp."No." <> Rec.NoEmp then
                                RefEmp.Next();
                        end;

                        Rec.Contact := RefEmp."E-Mail";
                    end;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    Editable = false;
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
                    ShowMandatory = true;
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
        area(Processing)
        {
            action("Změna stavu")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Vraceno;
                    Rec.Modify();
                end;
            }
        }
    }


    trigger OnModifyRecord(): Boolean
    var
        mess: Text;
    begin
        //detekce nevyplnenych poli a nasledne upozorneni uzivatele
        if Rec.Since > Rec.Till then begin
            Rec.Till := Rec.Since;
            mess := mess + 'Zadal jsi špatny datum.\';
        end;

        if Rec.NoDev = 0 then begin
            mess := mess + 'Nebylo zvoleno zařízení.\';
        end;

        if Rec.NoEmp = '' then begin
            mess := mess + 'Nebyl zvolen zamestnanec.';
        end;

        if mess <> '' then begin
            Message(mess);
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //automaticke vlozeni pocatecniho data na dnesni datum
        Rec.Since := DT2DATE(CurrentDateTime);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        i: Integer;
        RefDev: Record DevTab;
    begin
        //pokud je vyplneny cislo zarizeni tak se pri smazani zvysi pocet zarizeni
        if Rec.NoDev <> 0 then begin
            for i := 1 to RefDev.Count() do begin
                if RefDev.NoDev <> Rec.NoDev then
                    RefDev.Next();
            end;

            RefDev.Amount := RefDev.Amount + 1;
            RefDev.Modify();
        end;
    end;

    trigger OnOpenPage()
    var
        flag: Boolean;
        i: Integer;
        RefRent: Record RentDev;
    begin
        flag := false;
        RefRent.Next();
        for i := 1 to RefRent.Count() do begin
            if (RefRent.Status = RefRent.Status::Vypujceno) and (RefRent.Till < DT2DATE(CurrentDateTime)) then begin
                RefRent.Status := RefRent.Status::PoLhute;
                RefRent.Modify();
                flag := true;
            end;
            RefRent.Next();
        end;
        if flag then begin
            Message('Výpůjčka je po Lhůtě');
        end;
    end;
}