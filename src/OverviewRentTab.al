table 50102 OverviewRentTab
{
    Caption = 'OverviewRentTab';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PK; Integer)
        {
            Caption = 'PK';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; DevName; Text[32])
        {
            DataClassification = ToBeClassified;
        }

        field(3; colum1; Integer)
        {
            Caption = 'colum1';
            DataClassification = ToBeClassified;
        }
        field(4; colum2; Integer)
        {
            Caption = 'colum2';
            DataClassification = ToBeClassified;
        }
        field(5; colum3; Integer)
        {
            Caption = 'colum3';
            DataClassification = ToBeClassified;
        }
        field(6; colum4; Integer)
        {
            Caption = 'colum4';
            DataClassification = ToBeClassified;
        }
        field(7; colum5; Integer)
        {
            Caption = 'colum5';
            DataClassification = ToBeClassified;
        }
        field(8; colum6; Integer)
        {
            Caption = 'colum6';
            DataClassification = ToBeClassified;
        }
        field(9; colum7; Integer)
        {
            Caption = 'colum7';
            DataClassification = ToBeClassified;
        }
        field(10; colum8; Integer)
        {
            Caption = 'colum8';
            DataClassification = ToBeClassified;
        }
        field(11; colum9; Integer)
        {
            Caption = 'colum9';
            DataClassification = ToBeClassified;
        }
        field(12; colum10; Integer)
        {
            Caption = 'colum10';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; PK)
        {
            Clustered = true;
        }
    }
}
