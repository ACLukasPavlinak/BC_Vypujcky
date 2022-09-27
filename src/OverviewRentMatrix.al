page 50104 OverviewRentMatrix
{
    Caption = 'Overview Rent Matrix';
    PageType = ListPart;
    SourceTable = "OverviewRentTab";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;
                field("Dev\Emp"; Rec.DevName)
                {
                    CaptionClass = 'Dev\Emp';
                    ApplicationArea = Planning;
                    Editable = false;
                }

                field(Field1; Rec.colum1)
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[1];
                    Visible = Field1Visible;
                    BlankZero = true;
                }
                field(Field2; Rec.colum2)
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[2];
                    Visible = Field2Visible;
                    BlankZero = true;
                }
                field(Field3; Rec.colum3)
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[3];
                    Visible = Field3Visible;
                    BlankZero = true;
                }
                field(Field4; Rec.colum4)
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[4];
                    Visible = Field4Visible;
                    BlankZero = true;
                }
                field(Field5; Rec.colum5)
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[5];
                    Visible = Field5Visible;
                    BlankZero = true;
                }
                field(Field6; Rec.colum6)
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[6];
                    Visible = Field6Visible;
                    BlankZero = true;
                }
                field(Field7; Rec.colum7)
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[7];
                    Visible = Field7Visible;
                    BlankZero = true;
                }
                field(Field8; Rec.colum8)
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[8];
                    Visible = Field8Visible;
                    BlankZero = true;
                }
                field(Field9; Rec.colum9)
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[9];
                    Visible = Field9Visible;
                    BlankZero = true;
                }
                field(Field10; Rec.colum10)
                {
                    ApplicationArea = Planning;
                    CaptionClass = MATRIX_CaptionSet[10];
                    Visible = Field10Visible;
                    BlankZero = true;
                }
            }
        }
    }

    trigger OnInit()
    begin
        Field10Visible := true;
        Field9Visible := true;
        Field8Visible := true;
        Field7Visible := true;
        Field6Visible := true;
        Field5Visible := true;
        Field4Visible := true;
        Field3Visible := true;
        Field2Visible := true;
        Field1Visible := true;

        SetEmp();
        SetCellData();
    end;

    var
        MATRIX_CaptionSet: array[10] of Text[32];
        [InDataSet]
        Field1Visible: Boolean;
        [InDataSet]
        Field2Visible: Boolean;
        [InDataSet]
        Field3Visible: Boolean;
        [InDataSet]
        Field4Visible: Boolean;
        [InDataSet]
        Field5Visible: Boolean;
        [InDataSet]
        Field6Visible: Boolean;
        [InDataSet]
        Field7Visible: Boolean;
        [InDataSet]
        Field8Visible: Boolean;
        [InDataSet]
        Field9Visible: Boolean;
        [InDataSet]
        Field10Visible: Boolean;

    procedure SetEmp()
    var
        emp: Record Employee;
        dev: Record DevTab;
        OVDev: Record OverviewRentTab;
        Caption: Text[32];
        i: Integer;
    begin
        while dev.Name = '' do begin
            dev.Next();
        end;

        OVDev.DeleteAll(true);

        i := 1;

        OVDev.Init();
        OVDev.PK := i;
        OVDev.DevName := dev.Name;
        OVDev.Insert();
        dev.Next();

        while OVDev.DevName <> dev.Name do begin
            i := i + 1;
            OVDev.PK := i;
            OVDev.DevName := dev.Name;
            OVDev.Insert();
            dev.Next();
        end;


        while emp."First Name" = '' do begin
            emp.Next();
        end;

        MATRIX_CaptionSet[1] := emp.FullName();
        emp.Next();

        for i := 2 to 10 do begin
            if MATRIX_CaptionSet[i - 1] <> emp.FullName() then begin
                MATRIX_CaptionSet[i] := emp.FullName();
                emp.Next();
            end else begin
                break;
            end;

        end;

        Field1Visible := MATRIX_CaptionSet[1] <> '';
        Field2Visible := MATRIX_CaptionSet[2] <> '';
        Field3Visible := MATRIX_CaptionSet[3] <> '';
        Field4Visible := MATRIX_CaptionSet[4] <> '';
        Field5Visible := MATRIX_CaptionSet[5] <> '';
        Field6Visible := MATRIX_CaptionSet[6] <> '';
        Field7Visible := MATRIX_CaptionSet[7] <> '';
        Field8Visible := MATRIX_CaptionSet[8] <> '';
        Field9Visible := MATRIX_CaptionSet[9] <> '';
        Field10Visible := MATRIX_CaptionSet[10] <> '';
    end;

    procedure SetCellData()
    var
        dev: Record DevTab;
        emp: Record Employee;
        rent: Record RentDev;
        matrix: array[10, 10] of Integer;
        row: Integer;
        col: Integer;
        tmpNo: Integer;
        tmpName: Text[32];
    begin
        while rent.NoDev = 0 do begin
            rent.Next();
        end;
        tmpNo := 0;

        while rent.NoRent <> tmpNo do begin
            tmpNo := rent.NoRent;
            row := 1;
            col := 1;
            if rent.Status <> rent.Status::Vraceno then begin
                while dev.Name = '' do begin
                    dev.Next();
                end;

                while dev.Name <> rent.DevName do begin
                    row := row + 1;
                    dev.Next();
                end;

                if emp."No." = '' then begin
                    emp.Next();
                end;


                while emp.FullName() <> rent.EmpName do begin
                    col := col + 1;
                    emp.Next();
                end;

                matrix[row, col] := matrix[row, col] + 1;
            end;
            dev.FindFirst();
            emp.FindFirst();
            rent.Next();
        end;

        row := 1;

        rec.FindFirst();
        while rec.DevName = '' do begin
            rec.Next();
        end;

        while Rec.DevName <> tmpName do begin
            tmpName := Rec.DevName;
            Rec.colum1 := matrix[row, 1];
            Rec.Modify();
            Rec.colum2 := matrix[row, 2];
            Rec.Modify();
            Rec.colum3 := matrix[row, 3];
            Rec.Modify();
            Rec.colum4 := matrix[row, 4];
            Rec.Modify();
            Rec.colum5 := matrix[row, 5];
            Rec.Modify();
            Rec.colum6 := matrix[row, 6];
            Rec.Modify();
            Rec.colum7 := matrix[row, 7];
            Rec.Modify();
            Rec.colum8 := matrix[row, 8];
            Rec.Modify();
            Rec.colum9 := matrix[row, 9];
            Rec.Modify();
            Rec.colum10 := matrix[row, 10];
            Rec.Modify();

            Rec.Next();
            row := row + 1;
        end;
    end;
}