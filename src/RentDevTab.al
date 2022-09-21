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
            Caption = 'Předchozí číslo zařízení';
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

        field(6; statusStyle; Text[50])
        {
            Caption = 'Styl statusu';
        }

        field(7; Since; Date)
        {
            Caption = 'Od kdy';
        }

        field(8; Till; Date)
        {
            Caption = 'Do kdy';
        }

        field(9; Contact; Text[50])
        {
            Caption = 'Kontakt';
        }

        field(10; EmpName; Text[50])
        {
            Caption = 'Jméno zaměstnance';
        }

        field(11; DevName; Text[50])
        {
            Caption = 'Název zařízení';
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